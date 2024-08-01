# Lenovo ThinkPad T490 Hackintosh OpenCore
[![OpenCore](https://img.shields.io/badge/OpenCore-1.0.1-cyan.svg)](https://github.com/acidanthera/OpenCorePkg/releases/latest) [![macOS Sequoia](https://img.shields.io/badge/macOS-15.0-white.svg)](https://www.apple.com/macos/macos-sequoia-preview/) [![release](https://img.shields.io/badge/Download-latest-success.svg)](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/releases/latest)<br>![10053604](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/assets/76865553/ed932a1a-8205-4b81-a4e2-f68d7d8a7178)

**TABLE of CONTENTS**

- [About](#about)
	- [Notable Features](#notable-features)
	- [Future Developments](#future-developments)
- [Issues](#issues)
- [Specs](#specs)
- [BIOS Settings](#bios-settings)
- [EFI Folder Content](#efi-folder-content)
- [Preparations](#preparations)
	- [Config Adjustments](#config-adjustments)
		- [AirportItlwm.kext vs. itlwm.kext](#airportitlwmkext-vs-itlwmkext)
- [Deployment](#deployment)
	- [If macOS is installed already](#if-macos-is-installed-already)
	- [If macOS is not installed](#if-macos-is-not-installed)
- [Post-Install](#post-install)
- [Understanding YogaSMC Settings](#understanding-yogasmc-settings)
- [For OCAT Users](#for-ocat-users)
- [Credits and Thank Yous](#credits-and-thank-yous)

## About
OpenCore EFI folder and config for running macOS Sonoma and newer on the Lenovo ThinkPad T490. Read the following documentation carefully in order to install/boot macOS successfully!

> [!CAUTION]
> 
> Upgrading from to macOS 14.3.1 to 14.4 and newer via `System Update` causes a Kernel Panic during install! Disable `AiportItlwm` and enable `itlwm.kext` instead. Set `SecureBootModel` to `Disabled`, reset NVRAM and run the update again. If this does not work, follow this [workaround](https://github.com/5T33Z0/OC-Little-Translated/blob/main/W_Workarounds/macOS14.4.md) to install macOS 14.4 on a new APFS volume. Use Migration Manager afterwards to get your data onto the new volume!

### Notable Features
- Compatible with macOS Sonoma and Sequoia
- New USB Port Mapping (includes ports of Docking Station) 
- Working MicroSD Card Reader
- Working clamshell mode (when connected to A/C and external display)
- Optimized Framebuffer Patch for smoother handshake with external displays
- Lean EFI folder with slimmed kexts (20 instead of 62 MB):
 	- **AirportItlwm_Sonoma**: 1,8 instead of 16 MB. Only Contains Firmware for Intel AC 9560.
	- **AppleALC**: 86 Kb instead of 2,3 MB. Only contains layout `97`.
	- **IntelBluetoothFirmware**: 560 KB instead of 11,5 MB.
	- **itlwm** (1.5 mb instead of 16 mb). Only Contains Firmware for Intel AC 9560.
- YogaSMC support for additional features like CPU fan control, performance bias, all <kbd>Fn</kbd> Keyboard shortcuts working, additional OSD overlays, etc.
- No injection of `PlatformInfo` data into Windows.
- Working 3D Globe in Maps (macOS 12+)

### Future Developments
- Creating AppleALC Layout for Docking Station
- Enabling HDMI/DP Ports on Docking Station

## Issues
- Audio Jack creates an unpleasant buzz/noise during driver initialization. So it's best to connect Headphones to it *after* booting.

> [!IMPORTANT]
> 
> Before reporting any issues, ensure that your system uses the latest UEFI and EC Firmware as I do. I have no time trying to fix issues which are not caused by my EFI but rather by running the system on outdated firmware! 

## Specs

Category | Description
:-------:|------------
**Model** | Lenovo ThinkPad T490 
**Variant** | [**20N3**](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t490-type-20n2-20n3/document-userguide)
**BIOS** | **UEFI**: v1.82 (2024-02-22) <br> **Embedded Controller**: v1.27
**CPU** | Intel [**Intel Core i5 8265U**](https://ark.intel.com/content/www/us/en/ark/products/149088/intel-core-i58265u-processor-6m-cache-up-to-3-90-ghz.html) (Quad Core)
**RAM** | 16 GB: <ul> <li> 8 GB Samsung DDR 4 @2666 Mhz (soldered) <li> 8 GB Samsung DDR 4 @2666 Mhz (RAM Slot)
**Storage** | ~~Samsung PM981a NVMe~~ ([**unusable**](https://dortania.github.io/Anti-Hackintosh-Buyers-Guide/Storage.html)) <br> Western Digital PC SN530 NVMe SSD
**Display** | Full HD (1080p) (Non-Touch)
**iGPU** | Intel(R) Grpahics UHD 620 (spoofed as Iris 655, BusID: `2`)
**dGPU** | None
**Audio** | [**Realtek ALC257**](https://github.com/dreamwhite/ChonkyAppleALC-Build/blob/master/Realtek/ALC257.md) (using Layout `97`)
**Thunderbolt** | Titan Ridge Thunderbolt 3 Connector (USB-C)<br> (Reported working but I don't have any gear to test it)
**Ethernet** | Intel I219-V
**WiFi** | Intel AC-9560 <br> **Firmware**: [**`iwm-9000-46`**](https://www.intel.com/content/www/us/en/support/articles/000005511/wireless.html) ([Screenshot](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/blob/main/Additional_Files/Pics/wifi-firmware.png))
**Bluetooth** | **Device**: Intel Wireless Bluetooth <br> **BT Version**: 5.1 <br> **VID**: `0x8087`, **PID**: `0x0aaa` <br> **Firmware**: `ibt-17-16-1.sfi`, `ibt17-16-1.ddc` <br>**USB Port**: `HS10`
**Trackpad** | Synaptics <br>**Device-id**: `pci8086,9de8`. Controlled via SMBus.
**SD Card Reader** | Realtek MicroSD Card Reader
**Dock** | [**ThinkPad Ultra Docking Station**](https://support.lenovo.com/us/en/solutions/pd500173-thinkpad-ultra-docking-station-overview-and-service-parts)

## BIOS Settings
After powering on the machine, spam <kbd>F1</kbd> until you hear a beep to enter the BIOS. Change the following settings:

Category | Setting
:-------:|------------
**Config** | **Display** <ul> <li>Shared Display Priority: `HDMI` <li> Total Graphics Memory: `256 MB` </ul> **CPU** <ul> <li> Intel Hyperthreading Technology: `ON` 
**Security** | **Fingerprint** <ul><li>Predesktop Authentication: `OFF` </ul> **Security Chip** <ul><li>Security Chip`ON` or `OFF` (enable for Windows 11) </ul> **Memory Protection** <ul> <li> Execution Prevention: `ON`</ul></ul> **Virtualization** <ul><li> Kernel DMA Protection: `ON` (enables `VT-D` by design)</ul> **I/O Port Access** <ul> <li> Ethernet LAN: `ON` <li> Wireless LAN: `ON` <li> Bluetooth: `ON` <li> USB Port: `ON` <li> Memory Card Slot: `ON` <li> Smart Card Slot: `OFF` <li> Integrated Camera: `ON` <li> Integrated Audio: `ON` <li> Microphone: `ON` <li> Fingerprint Reader: `ON` (works in Windows only) or `OFF` <li> Thunderbolt 3: `ON` </ul> **Absolute Persistance Module** <ul><li> Absolute Persistance Module Activation: `Disabled`</ul> **Secure Boot Configuration** <ul><li> Secure Boot: `OFF` </ul> **Intel SGX** <ul><li> Intel SGX Control: `Disabled`
**Startup** | <ul> <li> **UEFI/ Legacy Boot**: `UEFI Only` <li> **Boot Mode**: `Quick` (Skips Diagnostics)

## EFI Folder Content

<details>
<summary><strong>Click to reveal</strong></summary>

```
EFI
├── BOOT
│   └── BOOTx64.efi
├── OC
│   ├── ACPI
│   │   ├── DMAR.aml
│   │   ├── SSDT-ALS0.aml
│   │   ├── SSDT-AWAC.aml
│   │   ├── SSDT-ECRW.aml
│   │   ├── SSDT-EXT1-FixShutdown.aml
│   │   ├── SSDT-EXT3-LedReset-TP.aml
│   │   ├── SSDT-EXT4-WakeScreen.aml
│   │   ├── SSDT-GPRW.aml
│   │   ├── SSDT-MCHC.aml
│   │   ├── SSDT-PLUG.aml
│   │   ├── SSDT-PNLF.aml
│   │   ├── SSDT-PORTS.aml
│   │   ├── SSDT-PTSWAK.aml
│   │   ├── SSDT-THINK.aml
│   │   └── SSDT-USBX.aml
│   ├── Drivers
│   │   ├── AudioDxe.efi
│   │   ├── HfsPlus.efi
│   │   ├── OpenCanopy.efi
│   │   ├── OpenRuntime.efi
│   │   └── ResetNvramEntry.efi
│   ├── Kexts (Loading managed by MinKernel/MaxKernel settings)
│   │   ├── AMFIPass.kext
│   │   ├── AdvancedMap.kext
│   │   ├── AirportItlwm_Sonoma.kext
│   │   ├── AppleALC.kext
│   │   ├── BlueToolFixup.kext
│   │   ├── BrightnessKeys.kext
│   │   ├── CPUFriend.kext
│   │   ├── CPUFriendDataProvider.kext
│   │   ├── ECEnabler.kext
│   │   ├── IntelBTPatcher.kext
│   │   ├── IntelBluetoothFirmware.kext
│   │   ├── IntelBluetoothInjector.kext
│   │   ├── IntelMausiEthernet.kext
│   │   ├── itlwm.kext (disabled)
│   │   ├── Lilu.kext
│   │   ├── NVMeFix.kext
│   │   ├── RealtekCardReader.kext
│   │   ├── RealtekCardReaderFriend.kext
│   │   ├── RestrictEvents.kext
│   │   ├── SMCBatteryManager.kext
│   │   ├── SMCProcessor.kext
│   │   ├── SMCSuperIO.kext
│   │   ├── VirtualSMC.kext
│   │   ├── VoodooPS2Controller.kext
│   │   │   └── Contents
│   │   │       └── PlugIns
│   │   │           ├── VoodooInput.kext (disabled)
│   │   │           ├── VoodooPS2Keyboard.kext
│   │   │           ├── VoodooPS2Mouse.kext (disabled)
│   │   │           └── VoodooPS2Trackpad.kext
│   │   ├── VoodooRMI.kext
│   │   │       └── PlugIns
│   │   │           ├── RMII2C.kext (disabled)
│   │   │           ├── RMISMBus.kext
│   │   │           └── VoodooInput.kext
│   │   ├── VoodooSMBus.kext
│   │   ├── WhateverGreen.kext
│   │   └── YogaSMC.kext
│   ├── OpenCore.efi
│   ├── Resources
│   │   ├── Audio
│   │   │   └── OCEFIAudio_VoiceOver_Boot.mp3
│   │   ├── Font
│   │   │   ├── Font_1x.bin
│   │   │   ├── Font_1x.png
│   │   │   ├── Font_2x.bin
│   │   │   └── Font_2x.png
│   │   ├── Image
│   │   │   ├── Acidanthera (removed icons from tree view)
│   │   │   │   ├── Chardonnay
│   │   │   │   ├── GoldenGate
│   │   │   │   └── Syrah 
│   │   │   └── Blackosx
│   │   │       └── BsxM1 (removed icons from tree view)
│   │   └── Label (removed files from tree view)
│   └── Config.plist
└── OC Changelog.md
```
</details>

## Preparations

### Config Adjustments
- Download the [**latest Release**](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/releases/latest) of my EFI folder and unzip it
- Open the config.plist with a plist editor (e.g. ProperTree or OCAT) and adjust the following settings based on the used version of macOS and personal preferences:
	- **Graphics**
		- `Devices/Properties/Add/PciRoot(0x0)/Pci(0x2,0x0)`
			- If you plan to install macOS 13.3 or older, disable/delete `enable-backlight-registers-alternative-fix` and use `enable-backlight-registers-fix` instead to fix black screen issues.
			- If other issues occur, try the other framebuffer patch in the config (the one that's disable by `#`)!
			- An additional list of Framebuffer Patches can be found [here](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/blob/main/Additional_Files/Framebuffer_Patches/UHD620_Framebuffer_Patches.plist)
	- **Wi-Fi**: Decide, which Wi-Fi kext you want to use (&rarr; see [**AirportItlwm vs. itlwm**](#airportitlwmkext-vs-itlwmkext)):
    	- Sonoma uses **AirportItlwm_Sonoma** 
    	- Sequoia uses **Itlwm** because there's no AirportItlwm variant for Sequoia yet 
	- **Kernel/Quirks**: 
		- `AppleXcpmCfgLock` is not required on my system. Try for yourself if your T490 can boot without it.
	- **NVRAM/Add/7C436110-AB2A-4BBB-A880-FE41995C9F82**
		- Optional: add `boot-args` `-v`, `debug=0x100` and `keepsyms=1` for debugging if you face issues.
	- **UEFI/APFS** 
    	- Change `MinVersion` and `MinDate` to `-1` if you want to run macOS Catalina or older.
	- **Platforminfo/Generic**: SMBIOS
		- Generate `MLB`, `Serial` and `ROM` for `MacBookPro15,2` using GenSMBIOS or OCAT.
- Save the changes

> [!CAUTION]
> 
> - Don't change the SMBIOS or the USB port mapping stored in `USBMap_MBP152.kext` won't be applied and Bluetooth won't work either! If you must change the SMBIOS then you also need to change the `model` property inside the `info.plist` of the kext to match the selected SMBIOS as well ([instructions](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/issues/13#issuecomment-1858917249)).
> - If your T490 model uses a different WiFi/BT card than the stock Intel AC-9560 card, use the official `itlwm.kext` instead because mine only contains the firmware for the 9560 so it won't work with other cards.

#### AirportItlwm.kext vs. itlwm.kext
Although the Intel AC-9560 Card is compatible with both kexts (use either one or the other), there are Pros and Cons to both of them (check the [**FAQs**](https://openintelwireless.github.io/itlwm/FAQ.html#features) for other differences):

- **AirportItlwm**: (default)
	- **Pro**: Can be used during macOS Setup/Recoveery which is not possible with `itlwm.kext`
	- **Pro**: Supports Location Services and "Find My Mac"
 	- **Pro**: Connects faster to Wi-Fi Hotspots than `itlwm.kext`
	- **Con**: Doesn't perform as well as `itlwm.kext`
	- **Con**: Can't connect to hidden WiFi Networks
	- **Con**: Requires the correct kext per macOS version, so running multiple version of macOS requires multiple versions of this kext controlled via `MinKernel` and `MaxKernel` settings
	- **Con**: iMessage and FaceTime don't work when using AirportItlwm (&rarr; See [Issue 14](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/issues/14))

- **itlwm.kext** (disabled)
	- **Pro**: `itlwm.kext` works across _multiple_ versions of macOS
	- **Pro**: Loading webpages feels a lot quicker than with `AirportItlwm` 
	- **Pro**: Can connect to hidden WiFi Networks
 	- **Pro**: Does work with iMessage and FaceTime 	
	- **Con**: Requires [**HeliPort**](https://github.com/diepeterpan/HeliPort/releases) app to connect to Wi-Fi hotspots, so it can't be used during macOS Setup/Recovery
	- **Con**: Doesn't support Location Services

- Pre-compiled WiFi kexts for other versions of macOS can be found in the [Additional Files](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Additional_Files/Slimmed_Kexts/Intel_AC-9650/itlwm) section!

> [!NOTE]
> 
> My config uses `AirportItlw.kext` by default since it allows accessing the internet during macOS installation (unlike `itlwm.kext` which requires an additional app to do so). Currently, AirportItlwm kexts for macOS Sonoma is included. My `itlwm.kext` is a slimmed-down version only containing the firmware for the Intel AC-9560 (1,5 MB instead of 16,1 MB). If you want to use itlwm, disable AirportItlwm (all variants) and enable itlwm in the config.plist instead. Next, download the Helipad app, run it and add it to "Login Items" (in System Settings) so that it starts automatically with macOS.

## Deployment
### If macOS is installed already
- Put the EFI folder on a FAT32 formatted USB flash drive
- Reboot from said USB flash drive for testing
- If it works, mount your system's ESP, replace the BOOT and OC folders in the EFI folder
- Continue with Post-Install 

### If macOS is not installed
- Follow Dortania's [**OpenCore Install Guide**](https://dortania.github.io/OpenCore-Install-Guide/installer-guide/#making-the-installer) to prepare a USB Installer
- **Optional**: Once the USB has been created, download the latest version of [**HeliPort**](https://github.com/diepeterpan/HeliPort/releases) and copy the .dmg to your USB Installer (only required when `itlwm.kext` is used for Wi-Fi)
- Next, mount the ESP of the USB Installer (you can use [**MountEFI**](https://github.com/corpnewt/MountEFI) for this)
- Put the EFI folder on the EFI partition of the USB installer
- Reboot from the USB installer 
- Install macOS
- Once that is completed, continue with Post-Install

## Post-Install
- **Disable Gatekeeper**: `sudo spctl --master-disable` because it is annoying and wants to stop you from running scripts from github etc.
- **Wi-Fi** (`itlwm.kext` users only): 
	- Mount **HeliPort.dmg**, drag the app into the "Programs" folder and run it.
	- Use it to connect to your WiFI hotspot.
	- Add HeliPort to "Login Items", so it stars with macOS and connects to your WiFi network automatically.
- **YogaSMC**:
	- Download [**YogaSMC-App**](https://github.com/zhen-zen/YogaSMC/files/14324664/Builds.zip) and mount it. This is a custom build which fixes the "Failed to open Preferences" [issue](https://github.com/zhen-zen/YogaSMC/issues/189) in Ventura and newer  
	- Double-click the YogaSMC **prefPane** to install it
	- Drag the `YogaSMC` app into the "Programs" folder and run it
	- Click on the icon (⌥) in the menu bar and select "Start at Login"
	- Now you can control performance profiles, fan speed and other settings
- Use [**CPUFriendFriend**](https://github.com/corpnewt/CPUFriendFriend) to generate your own `CPUFriendDataProvider.kext` to optimize CPU Power Management if your T490 uses a different CPU than mine.
- **Enabling Hibernation**: Use Terminal or change in Hackintool
	- Disable PowerNap: `sudo pmset -a powernap 0`
	- Change Hibernatemode to 25: `sudo pmset -a hibernatemode 25` 

## Understanding YogaSMC Settings
Open the YogaSMC preference pane. You will find the following options (among others):

- `DYTC`: DYTC stands for `Dynamic Thermal Control`. It allows the OS or firmware to manage the thermal characteristics of a device or component dynamically, adjusting power and performance to maintain safe operating temperatures. 3 profiles are available: "Quiet", "Balanced", and "Performance"
- If you tick the `PSC support`, the control for the slider becomes more nuanced. Instead of 3 positions it gets more increments. I think `PSC` refers to `Power State Current` in the `DSDT` and is used to control different levels of performance via the slider.

### Disabling YogaSMC
If you don't want to use YogaSMC, do the following:

- macOS:
	- Open System Preferences
	- Right-Click on `YogaSMCPane` and remove it
	- Under "Login items" (or similar) remove the YogaSMC App from the list
- Config.plist: 
	- Under `ACPI`, disable `SSDT-THINK.aml` and `SSDT-ECRW.aml`
	- Under `Kernel`, disable `YogaSMC.kext`

> [!NOTE]
> 
> After disabling YogaSMC, fan and performance controls are no longer available. F-keys besides Volume and Brightness will no longer work either.

## For OCAT Users
Add the following entries to the "Kext URL Upgrade" list accessible via "Settings" from the "Sync" window (if not present already), so kext which are marked in grey in the Sync window will be downloaded when checking for updates:

Kext Name | Source URL
----------|-----------
**AdvancedMap.kext** | https://github.com/notjosh/AdvancedMap
**AirportItlwm.kext** | https://github.com/OpenIntelWireless/itlwm 
**IntelBluetoothFirmware.kext** | https://github.com/OpenIntelWireless/IntelBluetoothFirmware
**IntelMausiEthernet.kext** | https://github.com/CloverHackyColor/IntelMausiEthernet
**itlwm.kext** | https://github.com/OpenIntelWireless/itlwm 
**RealtekCardReader.kext** | https://github.com/0xFireWolf/RealtekCardReader
**RealtekCardReaderFriend.kext** | https://github.com/0xFireWolf/RealtekCardReaderFriend

> [!IMPORTANT]
> 
> Don't update `AirportItlwm.kext`, `AppleALC.kext`, `IntelBluetoothFirmware.kext` and `itlwm.kext` via OCAT because then you lose the slimmed versions of these kexts!

## Compile Intel Wi-Fi and Bluetooth Firmware kexts easily

Chris1111 has created a helpful little app called [**Wifi-Intel-KextsBuilder**](https://github.com/chris1111/Wifi-Intel-KextsBuilder) which automates the process of compiling Intel Wi-Fi and Bluetooth Firmware kexts. It only requires you to have Xcode installed and will handle the rest on its own once you run it.

Wifi-Intel-KextsBuilder downloads the source code of itlwm, IntelBluetoothFirmware, MacKernelSDK and Lilu and then compiles itlwm, AirportItlwm and Intel Bluetooth Firmware kexts. They will be located under "Users/YOUR_USERNAME/Developer/Wifi-Intel-KextsBuilder/ in the "build/Release" folder of each repo.

These kexts won't be slimmed like the ones present in my EFI folders but at least you now have a simple option to compile these kexts on your own in the future.

## Credits and Thank Yous
- [**Acidanthera**](https://github.com/acidanthera) for OpenCore, Kexts and maciASL
- Chris1111 for [**Wifi-Intel-KextsBuilder**](https://github.com/chris1111/Wifi-Intel-KextsBuilder)
- [**CorpNewt**](https://github.com/corpnewt) for ProperTree, CPUFriendFriend and SSDTTime
- Dreamwhite for slimmed versions of [**itlwm.kext**](https://github.com/dreamwhite/Chonky-itlwm-Build/releases)
- [**ic005k**](https://github.com/ic005k/OCAuxiliaryTools) for OpenCore Auxiliary Tools
- [**benbaker76**](https://github.com/benbaker76/Hackintool) for Hackintool
- [**zxystd**](https://github.com/zxystd/BrcmPatchRAM) for Sonoma-compatible BrcmPatchRAM kext
- **Special Thx to**:
	- [1Revenger1](https://github.com/1Revenger1/) for VoodooRMI and fixing issues with the TrackPad
	-  deeveedee for advice when trying to optimize the framebuffer patch for connecting to my external display. 
- **T490 OpenCore Repos** used for referencing and ACPI hotfixes:
	- [yusifsalam](https://github.com/yusifsalam/t490-macos)
	- [Krissh-C ](https://github.com/Krissh-C/T490-macOS)
	- [ganyuanzhen](https://github.com/ganyuanzhen/T490-Hackintosh-Opencore)
	- [laserdyke](https://github.com/laserdyke/t490-opencore)
	- [ZoR3oL](https://github.com/ZoR3oL/t490-hackintosh)
