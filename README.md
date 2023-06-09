# Lenovo ThinkPad T490 Hackintosh OpenCore

[![OpenCore](https://img.shields.io/badge/OpenCore-0.9.3-blue.svg)](https://github.com/acidanthera/OpenCorePkg/releases/latest) [![macOS Monterey](https://img.shields.io/badge/macOS-12.6.7-white.svg)](https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/) [![macOS Ventura](https://img.shields.io/badge/macOS-13.5b2-white.svg)](https://www.apple.com/macos/ventura/)

**TABLE of CONTENTS**

- [About](#about)
  - [Notable Features](#notable-features)
  - [Future Developments](#future-developments)
- [Issues](#issues)
- [Specs](#specs)
- [BIOS Settings](#bios-settings)
- [EFI Folder Content](#efi-folder-content)
- [Preperatios](#preperatios)
  - [Config adjustments](#config-adjustments)
- [Deployment](#deployment)
  - [If macOS is installed already](#if-macos-is-installed-already)
  - [If macOS is not installed](#if-macos-is-not-installed)
- [Post-Install](#post-install)
- [Credits and Thank Yous](#credits-and-thank-yous)

## About
OpenCore EFI folder and config for running macOS Monterey and newer on the Lenovo Thinkpad T490. Read the documnettion carefully in order to boot your OS successfully.

### Notable Features
- Latest versions of OpenCore and Kexts
- Lean EFI folder with slimmed kexts:
	- **AppleALC** (87 kB instead of 2.2 mb). Only contains layout `97`.
	- **AirportItlwm** (1.7 mb instead of 16 mb). Only Contains Firmware for Intel AC 9560.
	- **itlwm** (1.6 mb instead of 16 mb). Only Contains Firmware for Intel AC 9560.
- Kext loading for different versions of macOS managed via `MinKernel` and `MaxKernel` setting
- YogaSMC support for addittional features like CPU fan control, performance balance, all <kbd>Fn</kbd> Key shortcuts working, additional OSD overlays, etc.
- No injection of PlatformInfo data into Windows.

### Future Developments
- I am planning to get my hands on a Lenovo Thinkpad Thunderbolt 3 Dock (Gen 2) to see if it works
- Since I've had this Notebook for a couple of days only, I am using a USBMap.kext for now. But I am looking into mapping the USB ports via ACPI instead so it works with any SMBIOS and any version of macOS so you never have to wworry about it
- Adding Clover support (maybe)

## Issues
- Erratic Mouse Pointer behavior in BootPicker. Disabled `PointerSupport` for now. Since it works fine when using a USB mouse, I think the issue might be related to VoodooSMBus or VoodooRMI. Created an issue report.
- Audio Jack creates an unpleasant buzz/noise during drivier initialization. So it's best to connect to it *after* booting.
- When attaching to an external mintor via HDMI to DVI cable, both screens turn on and off a few times until the link is established. When connecting from HDMI to HDMI, this doesn't happen.

## Specs
Category | Description
:---------:|------------
**Model** | Lenovo ThinkPad T490 
**Type** | [**20N3**](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t490-type-20n2-20n3/document-userguide)
**BIOS** | **UEFI**: 1.79 (2023-01-16)<br> **Embedded Controller**: 1.26
**CPU** | Intel [**Intel Core i5 8265U**](https://ark.intel.com/content/www/us/en/ark/products/149088/intel-core-i58265u-processor-6m-cache-up-to-3-90-ghz.html) (Quad Core)
**RAM** | 16 GB: <ul> <li> 8 GB Samsung DDR 4 @2400 Mhz (soldered) <li> 8 GB Kingston DDR 4 @2400 Mhz (RAM Slot)
**Storage** | ~~Samsung PM981 NVMe~~ ([**unusable**](https://dortania.github.io/Anti-Hackintosh-Buyers-Guide/Storage.html)) <br> 250 GB M.2 Crucial MX 500 SATA SSD
**Display** | Full HD (1080p) (Non-Touch)
**dGPU** | –
**iGPU** | Intel UHD 620
**Audio** | Realtek ALC257, `alcid=97` 
**Thunderbolt** | Titan Ridge Thunderbolt 3 Connector (USB-C)<br> (Untested)
**Ethernet** | Intel I219-V
**WiFi** | Intel AC-9560 (**Model**: iwm-9000-46)
**Bluetooth** |Intel Wireless Bluetooth. Not working in macOS 13.5b2 <br> **VID**: `0x8087`, **PID**: `0x0aaa`, **USB Port**: HS10
**Trackpad** | Synaptics (**Device-id**: `pci8086,9de8`). Controlled via SMBUS.
**SD Card Reader** | Realtek MicroSD Card Reader

## BIOS Settings
After powering on the machine, spam <kbd>Enter</kbd> until you hear a beep, then press <kbd>F1</kbd> to enter the BIOS. Change the following settings:

Category | Setting
:-------:|------------
**Config** | **Display** <ul> <li>Shared Display Priority: `HDMI` <li> Total Graphics Memory: `256 MB` </ul> **CPU** <ul> <li> Intel Hyperthreading Technology: `ON`
**Security** | **Fingerprint** <ul><li>Predesktop Authentication: `OFF` </ul>**Security Chip** <ul><li>Security Chip`ON` or `OFF` (enable for Windows 11) </ul> **Memory Protection** <ul> <li> Execution Prevention: `ON`</ul></ul>**Virtualization** <ul><li> Kernel DMA Protection: `ON` (enables `VT-D` by design)</ul> **I/O Port Access** <ul> <li> Ethernet LAN: `ON` <li> Wireless LAN: `ON` <li> Bluetooth: `ON` <li> USB Port: `ON` <li> Memory Card: `OFF` <li> Smart Card Slot: `OFF` <li> Integrated Camera: `ON` <li> Integrated Audio: `ON` <li> Microphone: `ON` <li> Fingerprint Reader: `OFF` <li> Thunderbolt 3: `ON` </ul> **Absolute Persistance Module** <ul><li> Absolute Persistance Module Activation: `Disabled`</ul> **Secure Boot Configuration** <ul><li> Secure Boot: `OFF` </ul> **Intel SGX** <ul><li> Intel SGX Control: `Disabled`
**Startup** | <ul> <li> **UEFI/ Legacy Boot**: `UEFI Only` <li> **Boot Mode**: `Quick` (Skips Diagnostics)

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
    │   ├── AirportItlwm.kext
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

## Preperatios

### Config adjustments
- Download the latest EFI folder from the "Releases" Section and unzip it
- Open the config.plist with a plist editor of your choice (I am using OCAT)
- Go to `PlatformInfo/Generic` and generate Serials for `MacBookPro15,4` with GenSMBIOS or OCAT. :warning: Don't change the SMBIOS or the USBMap.kext won't work anymore!
- If you are using/installing a different OS than macOS Monterey, you need to replace [AirportItlwm.kext](https://github.com/OpenIntelWireless/itlwm/releases) by the version for the OS you are planning to use.
- Save your config.plist

## Deployment
### If macOS is installed already
- Put the EFI folder on a FAT32 formatted USB stick
- Reboot from said USB flash drive for testing
- If it works, place the EFI forder on the SSD of your Laptop
- Continue with Post-Install 

### If macOS is not installed
- Follow Dortania's [OpenCore Install Guide](https://dortania.github.io/OpenCore-Install-Guide/installer-guide/#making-the-installer) to prepare a USB Installer
- Once the USB  has been created, mount its EFI Parttion (you can use [MountEFI](https://github.com/corpnewt/MountEFI))
- Put the EFI folder on the EFI partition of the USB installer
- Reboot from the USB installer 
- Install macOS
- Once that is completed, continue with Post-Install

## Post-Install
- Enable **YogaSMC**:
	- Download and install the [**YogaSMC App**](https://github.com/zhen-zen/YogaSMC/releases) and Preference Pane so YogaSMC can work
- **Optional**: Switch WiFi kext form `AirportItlwm` to `itlwm`. 
	- itlm uses Apple's IOEthernet rather than IO80211.
	- itlm provides a stabler and faster performance than AirportItlwm. You also don't need different versions of the kext for different versions of macOS. 
	- Only downside: it requires its own app called [HeliPort](https://github.com/OpenIntelWireless/HeliPort) to connect to hotspots which does not work during macOS install/recovery. More Info [here](https://openintelwireless.github.io/HeliPort/Installation.html)

## Credits and Thank Yous
- [**Acidanthera**](https://github.com/acidanthera) for OpenCore, Kexts and maciASL
- [**CorpNewt**](https://github.com/corpnewt) for ProperTree, CPUFriendFriend and SSDTTime
- Dreamwhite for slimmed [**slimmed versions of itlwm kext**](https://github.com/dreamwhite/Chonky-itlwm-Build/releases) kexts
- [**ic005k**](https://github.com/ic005k/OCAuxiliaryTools) for OpenCore Auxiliary Tools
- [**benbaker76**](https://github.com/benbaker76/Hackintool) for Hackintool
- **T490 OpenCore Repos** for referencing and ACPI fixes:
	- [yusifsalam](https://github.com/yusifsalam/t490-macos)
	- [Krissh-C ](https://github.com/Krissh-C)
	- [ganyuanzhen](https://github.com/ganyuanzhen/T490-Hackintosh-Opencore)
	- [laserdyke](https://github.com/laserdyke/t490-opencore)
	- [ZoR3oL](https://github.com/ZoR3oL/t490-hackintosh)
