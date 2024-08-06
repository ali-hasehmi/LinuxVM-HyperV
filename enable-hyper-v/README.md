# How to enable hyper-v in Windows 10/11

> **Important Note:** Before proceeding, ensure your system meets the requirements for Hyper-V. Please verify your system's compatibility to avoid any issues. You can find more information on the system requirements [here](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/hyper-v-requirements).

>**Important Note:** Enabling Hyper-V may affect compatibility with other third-party virtualization software, such as VirtualBox and VMware. If you rely on these tools, please consider the implications before enabling Hyper-V. You can find more information [here](https://learn.microsoft.com/en-us/troubleshoot/windows-client/application-management/virtualization-apps-not-work-with-hyper-v).

# Content
1. [Enable Hyper-v](#1-enable-hyper-v)
2. [Restart your computer](#2-restart-your-computer)
3. [Launch Hyper-v Manager](#3-launch-hyper-v-manager)
4. [Enable Enhanced Session Mode](#4-enable-enhance-session-mode)
5. [Create a Virtual Switch](#5-create-a-virtual-switch)

## 1. Enable Hyper-v
* Press the **Windows key + S** to open the Search bar.

* Type **"Turn Windows features on or off"** and select the result.

    ![turn windows features on or off](./images/turn-windows-features-on-or-off.png)

* In the Windows Features window, scroll down and check the box next to **"Hyper-V"**.

    ![select hyperv](./images/select-hyper-v.png)
* Click **"OK"** to save the changes.

## 2. Restart your computer

* Restart your computer to apply the changes.
## 3. Launch Hyper-v Manager


* Press the **Windows key + S** to open the Search bar.

* Type "**Hyper-V Manager**" and select the result.

    ![hyperv manager](./images/hyper-v-manager.png)
    
* The Hyper-V Manager window will open, where you can create and manage virtual machines.

## 4. Enable Enhance Session Mode

## 5. Create a Virtual Switch