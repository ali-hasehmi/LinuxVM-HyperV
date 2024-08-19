#!/bin/bash

# Function to handle reboot
function askForReboot() {

    read -p "[?] Reboot now? [Y,n] " -n 1 -r

    echo # (optional) move to a new line

    if [[ $REPLY =~ ^[Yy]$ || -z $REPLY ]]; then

        sudo reboot

    fi

}

function checkService() {
    if pgrep -x "$1" >/dev/null; then
        return 0
    else
        return 1
    fi
}

function installFromAUR() {
    if [ -z $1 ]; then
        echo "[!] installFromAUR: need to provide Repository URL."
        exit 1
    fi
    REPO_URL=$1

    if [ -z $2 ]; then
        echo "[!] installFromAUR: need to provide Repository Directory."
        exit 1
    fi
    REPO_DIR=$2

    cd /tmp
    if [ -d $REPO_DIR ]; then
        # Repository exists just update
        cd ${REPO_DIR} && git pull
    else
        # Clone the Repository
        git clone --recursive ${REPO_URL}
        # Change to Project Directory
        cd ${REPO_DIR}
    fi
    echo "[+] Installing ${REPO_DIR}..."
    makepkg -si
}

function installXorgXrdp() {

    default=2
    while true; do
        # Prompt user with options, providing a default value
        echo "[?] Which package would you like to install?"
        echo -n "[ 1. xorgxrdp, 2. xorgxrdp-glamor 3. xorgxrdp-nvidia ] (default: $default): "
        read -n 1 -r # The user input will be stored in the REPLY variable
        echo

        # Set the default if the user presses Enter without input
        REPLY=${REPLY:-$default}

        # Determine the package to install based on user input or default
        if [[ "$REPLY" == "1" ]]; then
            URL="https://aur.archlinux.org/xorgxrdp.git"
            DIR="xorgxrdp"
            break
        elif [[ "$REPLY" == "2" ]]; then
            URL="https://aur.archlinux.org/xorgxrdp-glamor.git"
            DIR="xorgxrdp-glamor"
            break
        elif [[ "$REPLY" == "3" ]]; then
            URL="https://aur.archlinux.org/xorgxrdp-nvidia.git"
            DIR="xorgxrdp-nvidia"
            break
        else
            echo "Invalid choice..."
        fi
    done
    installFromAUR ${URL} ${DIR}
}

function installAudioModule() {
    if checkService "pipewire"; then
        default=2 # pipewire-module-xrdp
    elif checkService "pulseaudio"; then
        default=1 #  pulseaudio-module-xrdp
    else
        default=1 # Fallback default to  pulseaudio-module-xrdp
    fi

    while true; do
        # Prompt user with options, providing a default value
        echo "[?] Which package would you like to install?"
        echo -n "[1. pulseaudio-module-xrdp, 2. pipewire-module-xrdp] (default: $default): "
        read -n 1 -r # The user input will be stored in the REPLY variable
        echo

        # Set the default if the user presses Enter without input
        REPLY=${REPLY:-$default}

        # Determine the package to install based on user input or default
        if [[ "$REPLY" == "1" ]]; then
            URL="https://aur.archlinux.org/pulseaudio-module-xrdp.git"
            DIR="pulseaudio-module-xrdp"
            break
        elif [[ "$REPLY" == "2" ]]; then
            URL="https://aur.archlinux.org/pipewire-module-xrdp.git"
            DIR="pipewire-module-xrdp"
            break
        else
            echo "Invalid choice..."
        fi
    done
    installFromAUR $URL $DIR
}

function handleXrdpInitRc() {
    # Define file paths
    XRDPINITRC="$HOME/.xrdpinitrc"
    XINITRC="$HOME/.xinitrc"
    DEFAULT_XINITRC="/etc/X11/xinit/xinitrc"

    # Check if ~/.xrdpinitrc exists
    if [ -f "$XRDPINITRC" ]; then
        echo "[-] ${XRDPINITRC} already existed"
        return 0
    fi
    # Check if ~/xinitrc exists
    if [ -f "$XINITRC" ]; then
        # Copy ~/xinitrc to ~/.xrdpinitrc
        cp "$XINITRC" "$XRDPINITRC"
        echo "[+] ${XRDPINITRC} copied from ${XINITRC}"
        return 0
    fi
    # Check if /etc/X11/xinit/xinitrc exists
    if [ -f "$DEFAULT_XINITRC" ]; then
        # Copy /etc/X11/xinit/xinitrc to ~/.xrdpinitrc
        cp "$DEFAULT_XINITRC" "$XRDPINITRC"
        echo "[+] ${XRDPINITRC} copied from ${DEFAULT_XINITRC}"
        return 0
    fi
    # If none of the files exist
    echo "[!] None of the files ~/.xrdpinitrc, ~/xinitrc, or /etc/X11/xinit/xinitrc exist. Operation failed."
    return 1
}
# exit script on error
set -e

# Check if script run as root
if [ "$(id -u)" -eq 0 ]; then
    echo '[!] This script must be run as non-root user' >&2
    exit 1
fi

# Make sure system is in good shape
sudo pacman -Syu --noconfirm --needed

# install some essential packages
sudo pacman -S git base-devel linux-tools cloud-utils --noconfirm --needed

# install xrdp
installFromAUR 'https://aur.archlinux.org/xrdp.git' 'xrdp'

# install xorgxrdp
installXorgXrdp

# install audio module to redirect audio (either pulseaudio or pipewire - choose base on running service)
installAudioModule

# stoping services
sudo systemctl stop xrdp
sudo systemctl stop xrdp-sesman

# Configure the installed XRDP ini files.
# Use vsock transport.
sudo sed -i_orig -e 's/port=3389/port=vsock:\/\/-1:3389/g' /etc/xrdp/xrdp.ini
# Use rdp security.
sudo sed -i_orig -e 's/security_layer=negotiate/security_layer=rdp/g' /etc/xrdp/xrdp.ini
# Remove encryption validation.
sudo sed -i_orig -e 's/crypt_level=high/crypt_level=none/g' /etc/xrdp/xrdp.ini
# Disable bitmap compression since its local its much faster
sudo sed -i_orig -e 's/bitmap_compression=true/bitmap_compression=false/g' /etc/xrdp/xrdp.ini

# Make everyone can create a xserver
sudo tee /etc/X11/Xwrapper.config >/dev/null <<EOL
needs_root_rights=no
allowed_users=anybody
EOL

# Rename the redirected drives to 'shared-drives'
sudo sed -i -e 's/FuseMountName=thinclient_drives/FuseMountName=shared-drives/g' /etc/xrdp/sesman.ini

# Blacklist the vmw module
if [ ! -e /etc/modprobe.d/blacklist-vmw_vsock_vmci_transport.conf ]; then
    sudo tee /etc/modprobe.d/blacklist-vmw_vsock_vmci_transport.conf < "blacklist vmw_vsock_vmci_transport" 
fi

#Ensure hv_sock gets loaded
if [ ! -e /etc/modules-load.d/hv_sock.conf ]; then
    sudo tee /etc/modules-load.d/hv_sock.conf < "hv_sock" 
fi

# Configure the policy xrdp session
sudo mkdir -p /etc/polkit-1/localauthority/50-local.d/
sudo tee /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla >/dev/null <<EOF
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
EOF

# function call to create ~/.xrdpinitrc (if not already existed)
handleXrdpInitRc

# Function to remove '--exit-with-session' from a ~/.xrdpinitrc
sed -i 's/--exit-with-session//g' "${HOME}/.xrdpinitrc"

# configure startwm.sh to run the ~/.xrdpinitrc instead of ~/.xinitrc
sudo sed -i "s/\/.xinitrc/\/.xrdpinitrc/g" "/etc/xrdp/startwm.sh"

# reconfigure the service
sudo systemctl daemon-reload
sudo systemctl enable --now xrdp
sudo systemctl enable --now xrdp-sesman

# Enable Services related to Hyper-V integration services
# systemctl enable hv-fcopy-daemon.service # it seems, the service no longer exists in arch
sudo systemctl enable hv_kvp_daemon.service # Hyper-V KVP Protocol Daemon
sudo systemctl enable hv_vss_daemon.service # Hyper-V VSS Protocol Daemon

echo "Install is complete."
echo "Reboot your machine to begin using XRDP."
askForReboot
