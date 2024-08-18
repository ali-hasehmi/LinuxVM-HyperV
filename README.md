# What is Hyper-V

[Hyper-V](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/hyper-v-technology-overview) is a native [hypervisor](https://en.wikipedia.org/wiki/Hypervisor) developed by Microsoft that allows you to create and manage virtual machines (VMs) on Windows. As a **Type 1 (bare-metal)** hypervisor, it runs directly on the host's hardware, providing **near-native performance** by efficiently managing system resources. Hyper-V is integrated into Windows, eliminating the need for additional software installations, and supports a wide range of operating systems, including various versions of *Windows, Linux, and FreeBSD*.  
Hyper-V offers advanced features such as live migration, which allows you to move running VMs between hosts without downtime, and dynamic memory allocation, which optimizes memory usage by adjusting the allocated memory to VMs as needed. It also provides robust security with features like shielded VMs to protect against unauthorized access, and nested virtualization, enabling the use of virtual machines within VMs. Hyper-V is ideal for both enterprise environments and development tasks, supporting scenarios from simple desktop virtualization to complex cloud and data center deployments.


## Table of content


* **[Enable Hyper-V](./enable-hyper-v/README.md)**

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
