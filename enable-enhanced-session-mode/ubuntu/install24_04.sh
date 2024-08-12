#!/bin/bash

# This is a rewritten version of github.com/Hinara/linux-vm-tools/master/ubuntu/24.04/install.sh

# exit script on error 
set -e

# Check if script run as root
if [ "$(id -u)" -ne 0 ]; then
    echo 'This script must be run with root privileges' >&2
    exit 1
fi

# Make sure system is in good shape
apt update
apt upgrade -y
apt autoremove

# Check if reboot is needed
if [ -f /var/run/reboot-required ]; then
    echo "A reboot is required in order to proceed with the install." >&2
    echo "Please reboot and re-run this script to finish the install." >&2
    exit 1
fi

# install hv_kvp utils
apt install -y linux-tools-virtual
apt install -y linux-cloud-tools-virtual

# installing xrdp and xorgxrdp for support of rdp
# installing pipewire-xrdp for support for redirecting audio
apt install -y xrdp xorgxrp pipewire-module-xrdp libpipewire-0.3-modules-xrdp


# stoping services
systemctl stop xrdp
systemctl stop xrdp-sesman


# Configure the installed XRDP ini files.
# Use vsock transport.
sed -i_orig -e 's/port=3389/port=vsock:\/\/-1:3389/g' /etc/xrdp/xrdp.ini
# Use rdp security.
sed -i_orig -e 's/security_layer=negotiate/security_layer=rdp/g' /etc/xrdp/xrdp.ini
# Remove encryption validation.
sed -i_orig -e 's/crypt_level=high/crypt_level=none/g' /etc/xrdp/xrdp.ini
# Disable bitmap compression since its local its much faster
sed -i_orig -e 's/bitmap_compression=true/bitmap_compression=false/g' /etc/xrdp/xrdp.ini


# Add script to setup the ubuntu session properly
if [ ! -e /etc/profile.d/xrdp-setup.sh ]; then
cat >> /etc/profile.d/xrdp-setup.sh << EOF
#!/bin/bash
export DESKTOP_SESSION=ubuntu
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
EOF
chmod a+x /etc/profile.d/xrdp-setup.sh
fi


# Make everyone can connect
sudo tee /etc/X11/Xwrapper.config > /dev/null << EOL
# Xwrapper.config (Debian X Window System server wrapper configuration file)
#
# This file was generated by the post-installation script of the
# xserver-xorg-legacy package using values from the debconf database.
#
# See the Xwrapper.config(5) manual page for more information.
#
# This file is automatically updated on upgrades of the xserver-xorg-legacy
# package *only* if it has not been modified since the last upgrade of that
# package.
#
# If you have edited this file but would like it to be automatically updated
# again, run the following command as root:
#   dpkg-reconfigure xserver-xorg-legacy 
needs_root_rights=no
allowed_users=anybody
EOL

# Rename the redirected drives to 'shared-drives'
sed -i -e 's/FuseMountName=thinclient_drives/FuseMountName=shared-drives/g' /etc/xrdp/sesman.ini


# Blacklist the vmw module
if [ ! -e /etc/modprobe.d/blacklist-vmw_vsock_vmci_transport.conf ]; then
  echo "blacklist vmw_vsock_vmci_transport" > /etc/modprobe.d/blacklist-vmw_vsock_vmci_transport.conf
fi


#Ensure hv_sock gets loaded
if [ ! -e /etc/modules-load.d/hv_sock.conf ]; then
  echo "hv_sock" > /etc/modules-load.d/hv_sock.conf
fi

# Configure the policy xrdp session
mkdir -p /etc/polkit-1/localauthority/50-local.d/
cat > /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla <<EOF
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
EOF


# reconfigure the service
systemctl daemon-reload
systemctl enable --now xrdp
systemctl enable --now xrdp-sesman


echo "Install is complete."
echo "Reboot your machine to begin using XRDP."
