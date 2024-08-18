# What is Hyper-V

[Hyper-V](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/hyper-v-technology-overview) is a virtualization platform developed by Microsoft. It allows you to create and manage virtual machines (VMs) on a physical host machine. With Hyper-V, you can run multiple operating systems on a single physical server, each with its own dedicated resources and isolated from the others.

## How does Hyper-V differ from other virtualization platforms on Windows?

Hyper-V is a **Type 1** [hypervisor](https://en.wikipedia.org/wiki/Hypervisor), also known as a bare-metal hypervisor, which runs directly on the hardware, offering **near-native performance** and making it more efficient than Type 2 hypervisors like *VirtualBox* and *VMware Workstation*, which operate on top of an existing operating system. One of its key advantages is that it’s already built into Windows, requiring **no additional software** to set up. Its deep integration with the OS enables advanced features such as **live migration, dynamic memory management, and robust security**, making it an ideal choice for enterprise environments and performance-critical tasks.


## Table of content


* **[Enable Hyper-v](./enable-hyper-v/README.md)**

* **[Create GNU/Linux virtual machine](./create-linux-vm/README.md)**

* **[Enable Enhanced Session Mode](./enable-enhanced-session-mode/README.md)**


## Resources

#### Documentation
- [Hyper-V (ArchWiki)](https://wiki.archlinux.org/title/Hyper-V#Virtual-machine-creation)
- [xRDP](https://github.com/neutrinolabs/xrdp/wiki)
- [xRDP (ArchWiki)](https://wiki.archlinux.org/title/Xrdp)
- [XorgxRDP](https://github.com/neutrinolabs/xorgxrdp/wiki)
#### Tutorials
- [xRDP Sound Redirection on Ubuntu or Debian](https://c-nergy.be/blog/?p=17734) 
- [ArchVM in Hyper-v](https://github.com/k247tEK/archVM-Hyper-V)

#### Other
- [linux-vm-tools (Hinara)](https://github.com/Hinara/linux-vm-tools) 
- [install xRDP in Mint 21.2](https://gist.github.com/ParkWardRR/2ab9b5d41bbaceca8471d591755a1898)
- [build XorgxRDP-glamor](https://gist.github.com/rcarmo/b4ce5a130e5b8de4e8d1db6b7965eedc)
- [xRDP-nvidia-setup](https://gist.github.com/Nexarian/0eb26a3284b21b55b6e1e8653ed88ec9)
