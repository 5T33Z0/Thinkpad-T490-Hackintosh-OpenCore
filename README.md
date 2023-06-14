# Lenovo ThinkPad T490 Hackintosh OpenCore
[![OpenCore](https://img.shields.io/badge/OpenCore-0.9.3-blue.svg)](https://github.com/acidanthera/OpenCorePkg/releases/latest) [![macOS Monterey](https://img.shields.io/badge/macOS-12.6.7-white.svg)](https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/) [![macOS Ventura](https://img.shields.io/badge/macOS-13.5b2-white.svg)](https://www.apple.com/macos/ventura/) [![macOS Sonoma](https://img.shields.io/badge/macOS-14.0b-white.svg)](https://www.apple.com/macos/sonoma-preview/)<br>
![10053604](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/assets/76865553/ed932a1a-8205-4b81-a4e2-f68d7d8a7178)

**TABLE of CONTENTS**

- [About](#about)
  - [Notable Features](#notable-features)
  - [Future Developments](#future-developments)
- [Issues](#issues)
- [Specs](#specs)
- [BIOS Settings](#bios-settings)
- [EFI Folder Content](#efi-folder-content)
- [Preparations](#preparations)
  - [Config adjustments](#config-adjustments)
    - [AirportItlwm.kext vs. itlwm.kext](#airportitlwmkext-vs-itlwmkext)
- [Deployment](#deployment)
  - [If macOS is installed already](#if-macos-is-installed-already)
  - [If macOS is not installed](#if-macos-is-not-installed)
- [Post-Install](#post-install)
- [For OCAT Users](#for-ocat-users)
- [Credits and Thank Yous](#credits-and-thank-yous)

## About
OpenCore EFI folder and config for running macOS Monterey and newer on the Lenovo ThinkPad T490. Read the documentation carefully in order to boot macOS successfully.

### Notable Features
- Compatible with macOS Sonoma
- MicroSD Card Reader is working
- Clamshell mode working (when connected to A/C and external display)
- Lean EFI folder with slimmed kexts (20 mb instead of 70) :
	- **AppleALC** (87 kB instead of 2.2 mb). Only contains layout `97`.
	- **AirportItlwm** (1.7 mb instead of 16 mb). Only Contains Firmware for Intel AC 9560.
	- **itlwm** (1.6 mb instead of 16 mb). Only Contains Firmware for Intel AC 9560.
- YogaSMC support for additional features like CPU fan control, performance bias, all <kbd>Fn</kbd> Key shortcuts working, additional OSD overlays, etc.
- No injection of `PlatformInfo` data into Windows.

### Future Developments
1. ~~Implementing Clamshell Mode:~~ Done!
2. Mapping USB Ports via ACPI instead of using USBMap.kext
3. I am planning to get my hands on a Lenovo ThinkPad Thunderbolt 3 Dock (Gen 2) to see if it works
4. ~~Trying to create a better Connector Patch for external DVI Monitor~~ Done!
5. ~~Adding Clover support~~ Send a 

## Issues
- Audio Jack creates an unpleasant buzz/noise during driver initialization. So it's best to connect Headphones to it *after* booting.

## Specs
Category | Description
:---------:|------------
**Model** | Lenovo ThinkPad T490 
**Variant** | [**20N3**](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t490-type-20n2-20n3/document-userguide)
**BIOS** | **UEFI**: 1.79 (2023-01-16)<br> **Embedded Controller**: 1.26
**CPU** | Intel [**Intel Core i5 8265U**](https://ark.intel.com/content/www/us/en/ark/products/149088/intel-core-i58265u-processor-6m-cache-up-to-3-90-ghz.html) (Quad Core)
**RAM** | 16 GB: <ul> <li> 8 GB Samsung DDR 4 @2400 Mhz (soldered) <li> 8 GB Kingston DDR 4 @2400 Mhz (RAM Slot)
**Storage** | ~~Samsung PM981 NVMe~~ ([**unusable**](https://dortania.github.io/Anti-Hackintosh-Buyers-Guide/Storage.html)) <br> 250 GB M.2 Crucial MX 500 SATA SSD
**Display** | Full HD (1080p) (Non-Touch)
**dGPU** | None
**iGPU** | Intel UHD 620 (spoofed as UHD 630)
**Audio** | [Realtek ALC257](https://github.com/dreamwhite/ChonkyAppleALC-Build/blob/master/Realtek/ALC257.md) (using Layout `97`)
**Thunderbolt** | Titan Ridge Thunderbolt 3 Connector (USB-C)<br> (Untested)
**Ethernet** | Intel I219-V
**WiFi** | Intel AC-9560 (**Model/Firmware**: iwm-9000-46)
**Bluetooth** |Intel Wireless Bluetooth <br> **VID**: `0x8087`, **PID**: `0x0aaa`, **USB Port**: `HS10`
**Trackpad** | Synaptics <br>**Device-id**: `pci8086,9de8`). Controlled via SMBus.
**SD Card Reader** | Realtek MicroSD Card Reader

## BIOS Settings
After powering on the machine, spam <kbd>F1</kbd> until you hear a beep to enter the BIOS. Change the following settings:

Category | Setting
:-------:|------------
**Config** | **Display** <ul> <li>Shared Display Priority: `HDMI` <li> Total Graphics Memory: `256 MB` </ul> **CPU** <ul> <li> Intel Hyperthreading Technology: `ON`
**Security** | **Fingerprint** <ul><li>Predesktop Authentication: `OFF` </ul>**Security Chip** <ul><li>Security Chip`ON` or `OFF` (enable for Windows 11) </ul> **Memory Protection** <ul> <li> Execution Prevention: `ON`</ul></ul>**Virtualization** <ul><li> Kernel DMA Protection: `ON` (enables `VT-D` by design)</ul> **I/O Port Access** <ul> <li> Ethernet LAN: `ON` <li> Wireless LAN: `ON` <li> Bluetooth: `ON` <li> USB Port: `ON` <li> Memory Card Slot: `ON` <li> Smart Card Slot: `OFF` <li> Integrated Camera: `ON` <li> Integrated Audio: `ON` <li> Microphone: `ON` <li> Fingerprint Reader: `OFF` <li> Thunderbolt 3: `ON` </ul> **Absolute Persistance Module** <ul><li> Absolute Persistance Module Activation: `Disabled`</ul> **Secure Boot Configuration** <ul><li> Secure Boot: `OFF` </ul> **Intel SGX** <ul><li> Intel SGX Control: `Disabled`
**Startup** | <ul> <li> **UEFI/ Legacy Boot**: `UEFI Only` <li> **Boot Mode**: `Quick` (Skips Diagnostics)

💡: **Tip**: Although the modern GUI is looking neat, you can navigate the menus much faster when using the old school looking "Simple Mode". 

## EFI Folder Content

<details>
<summary><strong>Click to reveal</strong></summary>

```
EFI
├── BOOT
│   └── BOOTx64.efi
└── OC
    ├── ACPI
    │   ├── SSDT-ALS0.aml
    │   ├── SSDT-AWAC.aml
    │   ├── SSDT-BAT.aml
    │   ├── SSDTT-ECRW.aml
    │   ├── SSDT-EXT1-FixShutdown.aml
    │   ├── SSDT-EXT3-LedReset-TP.aml
    │   ├── SSDT-EXT4-WakeScreen.aml
    │   ├── SSDT-GPRW.aml
    │   ├── SSDT-MCHC.aml
    │   ├── SSDT-PLUG.aml
    │   ├── SSDT-PNLF.aml
    │   ├── SSDT-PTSWAKTTS.aml
    │   ├── SSDT-PWRB.aml
    │   ├── SSDT-THINK.aml
    │   └── SSDT-USBX.aml
    ├── Drivers
    │   ├── AudioDXE.efi (disabled)
    │   ├── HfsPlus.efi
    │   ├── OpenCanopy.efi
    │   ├── OpenRuntime.efi
    │   └── ResetNvramEntry.efi
    ├── Kexts (loaded based on Min Kernel/Max Kernel settings)
    │   ├── AppleALC.kext
    │   ├── BlueToolFixup.kext
    │   ├── BrightnessKeys.kext
    │   ├── CPUFriend.kext
    │   ├── CPUFriendDataProvider.kext
    │   ├── ECEnabler.kext
    │   ├── IntelBluetoothFirmware.kext
    │   ├── IntelBTPatcher.kext
    │   ├── IntelMausiEthernet.kext
    │   ├── itlwm.kext
    │   ├── Lilu.kext
    │   ├── NVMeFix.kext
    │   ├── RealtekCardReader.kext
    │   ├── RealtekCardReaderFriend.kext
    │   ├── SMCBatteryManager.kext
    │   ├── USBMap.kext
    │   ├── VirtualSMC.kext
    │   ├── VoodooPS2Controller.kext
    │   ├── VoodooRMI.kext
    │   ├── VoodooSMBus.kext
    │   ├── WhateverGreen.kext
    │   └── YogaSMC.kext
    ├── OpenCore.efi
    ├── Resources (NOTE: shows sub-folders only, no files)
    │   ├── Font
    │   └── Image
    │       └── Acidanthera
    │       │   ├── Chardonnay
    │       │   ├── GoldenGate
    │       │   └── Syrah
    │       └── Blackosx
    │       │   └── BsxM1
    │       └── Label
    └── config.plist
```
</details>

## Preparations

### Config Adjustments
- Download the [latest Release](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/releases/latest) of my EFI folder and unzip it
- Open the config.plist with the plist editor of your choice (ProperTree or OCAT for example)
- `Kexts/Add` Section: decide, which Wifi kext you want to use (&rarr; see [AirportItlwm vs itlwm](#airportitlwmkext-vs-itlwmkext))
- Go to `PlatformInfo/Generic` and generate MLB, Serial and ROM for `MacBookPro15,4` with GenSMBIOS or OCAT. :warning: Don't change the SMBIOS or the `USBMap.kext` won't work anymore!
- Add `boot-args` for debugging if you have installation issues: `-v`, `debug=0x100` and `keepsyms=1`
- `UEFI/APFS`: change `MinVersion` and `MinDate` to `-1` for macOS Catalina and older.
- Save your config.plist

#### AirportItlwm.kext vs. itlwm.kext
Although the Intel AC-9560 Card is compatible with both kexts to connect to WiFi (use either one or the other), there are Pros and Cons to both of them:

- **AirportItlwm**:
	- **Con**: requires the correct kext per macOS version, so using it across multiple versions of macOS doesn't work. And it's not available for macOS Sonoma yet.
	- **Con**: doesn't work as well as itlwm.kext
	- **Pro**: can be used during macOS installation which is not possible with `itlwm.kext`.
- **itlwm.kext**
	- **Pro**: Only one kext which works accross multiple versions of macOS
	- **Pro**: Supplies Sonoma already (easier to maintain since Open Source)
	- **Pro**: Connects much faster to WiFi hotspots and performs better
	- **Con**: Requires [HeliPort](https://github.com/OpenIntelWireless/HeliPort) app to connect to WiFi Hotspots so it can't be used during macOS installation

**Suggestion**: Use Ethernet during macOS installation. If you don't have access to Ethernet, add the correct [`AirportItlw.kext`](https://github.com/OpenIntelWireless/itlwm/releases) for the desired macOS version you want to install and disable `itlwm.kext`.

## Deployment
### If macOS is installed already
- Put the EFI folder on a FAT32 formatted USB stick
- Reboot from said USB flash drive for testing
- If it works, place the EFI folder on the SSD of your Laptop
- Continue with Post-Install 

### If macOS is not installed
- Follow Dortania's [OpenCore Install Guide](https://dortania.github.io/OpenCore-Install-Guide/installer-guide/#making-the-installer) to prepare a USB Installer
- Once the USB  has been created, download the latest version of [**HeliPort**](https://github.com/OpenIntelWireless/HeliPort) and copy the .dmg to your USB Installer
- Next, mount the ESP of the USB Installer (you can use [**MountEFI**](https://github.com/corpnewt/MountEFI) for this)
- Put the EFI folder on the EFI partition of the USB installer
- Reboot from the USB installer 
- Install macOS
- Once that is completed, continue with Post-Install

**NOTE**: You will have to use Ethernet during the installation of macOS if your system requires access to the Internet.

## Post-Install
- Disable Gatekeeper: `sudo spctl --master-disable`
- Mount **HeliPort.dmg**, drag the app into the "Programs" folder and run it.
- Use it to connect to your WiFI Hotspot.
- Add HeiPort to "Login Items", so it stars and connects to your WiFi Hotspot automatically.
- Next, enable **YogaSMC**:
	- Download and mount [**YogaSMC-App**](https://github.com/zhen-zen/YogaSMC/releases) 
	- Drag the `YogaSMCNC` app into the "Programs" folder 
	- Double-click the YogaSMC **prefPane** to install it
	- Click on its icon (⌥) in the menu bar and select "Start at Login"
	- Now you can control Fan Speeds and other settings
- Use [CPUFriendFriend](https://github.com/corpnewt/CPUFriendFriend) to generate your own CPUFriendDataProvider.kext if your T490 uses a different CPU than mine to optimize CPU Power Management

## For OCAT Users
Add the following links to the "Kext URL Upgrade" list (accessible via "Settings" in the Sync window), so kext which are marked in grey in the Sync window will be downloaded when checking for updates:

Kext | Link
-----|-----
**itlwm.kext** | https://github.com/OpenIntelWireless/itlwm 
**BlueToolFixup.kext** | https://github.com/acidanthera/BrcmPatchRAM
**IntelMausiEthernet.kext** | https://github.com/CloverHackyColor/IntelMausiEthernet

## Credits and Thank Yous
- [**Acidanthera**](https://github.com/acidanthera) for OpenCore, Kexts and maciASL
- [**CorpNewt**](https://github.com/corpnewt) for ProperTree, CPUFriendFriend and SSDTTime
- Dreamwhite for [**slimmed versions of itlwm kext**](https://github.com/dreamwhite/Chonky-itlwm-Build/releases) kexts
- [**ic005k**](https://github.com/ic005k/OCAuxiliaryTools) for OpenCore Auxiliary Tools
- [**benbaker76**](https://github.com/benbaker76/Hackintool) for Hackintool
- [**zxystd**](https://github.com/zxystd/BrcmPatchRAM) for Sonoma-compatible BrcmPatchRAM kext
- **T490 OpenCore Repos** used for referencing and ACPI hotfixes:
	- [yusifsalam](https://github.com/yusifsalam/t490-macos)
	- [Krissh-C ](https://github.com/Krissh-C)
	- [ganyuanzhen](https://github.com/ganyuanzhen/T490-Hackintosh-Opencore)
	- [laserdyke](https://github.com/laserdyke/t490-opencore)
	- [ZoR3oL](https://github.com/ZoR3oL/t490-hackintosh)
