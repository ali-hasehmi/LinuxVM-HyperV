## What is Enhanced Session Mode?
Hyper-V enhanced session mode is a feature that allows you to have a more seamless experience when working with virtual machines. This mode provides access to local resources, such as the clipboard and printers, and improved display and audio performance.  

Some of the benefits of Enhanced Session Mode include:

* **Improved Display Resolution**: Enhanced Session Mode supports dynamic screen resolution changes, allowing the VM's display to resize to fit the window on the host.

* **Audio redirection**: Audio from the VM is redirected to your local machine, allowing you to hear audio from the VM.

* **Clipboard sharing**: You can copy and paste text and images between your local machine and the VM.
* Printer redirection: You can print from the VM to your local printers.

* Multi-monitor support: You can use multiple monitors to connect to a VM, just like you would with a physical machine.

* USB device redirection: You can redirect USB devices from your local machine to the VM.

> You can find more information in [here](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/learn-more/use-local-resources-on-hyper-v-virtual-machine-with-vmconnect#choose-a-local-resource).

> **NOTE**: If You don't use Enhanced Session Mode depending on your Linux distro, You would have **Display and Audio** Problems.

## How to make it work in GNU/Linux?

<details>
<summary>Ubuntu</summary>

<h3> 24.04 </h3>
<pre><code>
sudo bash -c "$(curl -sSL https://raw.githubusercontent.com/ali-hasehmi/LinuxVM-HyperV/main/enable-enhanced-session-mode/ubuntu/install24_04.sh)" 
</pre></code> 

<h3> 22.04 </h3>
<pre><code>
sudo bash -c "$(curl -sSL https://raw.githubusercontent.com/ali-hasehmi/LinuxVM-HyperV/main/enable-enhanced-session-mode/ubuntu/install22_04.sh)" 
</pre></code> 
  
<h3> 20.04 </h3>
<pre><code>
sudo bash -c "$(curl -sSL https://raw.githubusercontent.com/ali-hasehmi/LinuxVM-HyperV/main/enable-enhanced-session-mode/ubuntu/install20_04.sh)"
</pre></code> 

</details>