# What is Hyper-V

[Hyper-V](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/hyper-v-technology-overview) is a virtualization platform developed by Microsoft. It allows you to create and manage virtual machines (VMs) on a physical host machine. With Hyper-V, you can run multiple operating systems on a single physical server, each with its own dedicated resources and isolated from the others.

## How does Hyper-V differ from other virtualization platforms on Windows?

Hyper-V is a **Type 1** [hypervisor](https://en.wikipedia.org/wiki/Hypervisor), also known as a bare-metal hypervisor, which runs directly on the hardware, offering **near-native performance** and making it more efficient than Type 2 hypervisors like *VirtualBox* and *VMware Workstation*, which operate on top of an existing operating system. One of its key advantages is that it’s already built into Windows, requiring **no additional software** to set up. Its deep integration with the OS enables advanced features such as **live migration, dynamic memory management, and robust security**, making it an ideal choice for enterprise environments and performance-critical tasks.


## Table of content

* [Enable Hyper-v](./enable-hyper-v/README.md)

* [Create GNU/Linux virtual machine](./create-linux-vm/README.md)

* [Enable Enhanced Session Mode](./enable-enhanced-session-mode/README.md)

