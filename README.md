# Lenovo ThinkPad T490 Hackintosh OpenCore

[![OpenCore](https://img.shields.io/badge/OpenCore-1.0.7-cyan.svg?style=flat-square&title=OpenCore%20Bootloader)](https://github.com/acidanthera/OpenCorePkg/releases/latest)
[![macOS](https://img.shields.io/badge/macOS-14.x--26.3b-005BB5.svg?style=flat-square&title=Supported%20macOS%20Versions)](https://www.apple.com/macos/)
[![Release](https://img.shields.io/badge/Download-Latest-success.svg?style=flat-square&title=Latest%20Release)](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/releases/latest)
![ThinkPad T490 Hackintosh](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/assets/76865553/ed932a1a-8205-4b81-a4e2-f68d7d8a7178)

---

## About
OpenCore EFI folder and config for running macOS Sonoma and newer on the Lenovo ThinkPad T490. Read the following documentation carefully in order to install/boot macOS successfully!

|⚠️ Important Notes
|:-----------------------|
|**DO NOT APPLY AUDIO OR LEGACY USB PATCHES ON macOS 26.4 BETA 1** until macOS 26.4 Beta 1's **[Kernel Debug Kit](https://github.com/dortania/KdkSupportPkg/releases) (KDK)** is released! MacOS 26.4 Beta 1 is **not compatible with older KDK versions** and won't boot after applying audio or USB patches.|
| The **Samsung PM981a NVMe** that comes with the system is NOT compatible with macOS. You **_must_** use a different, compatible NVMe drive! |

## Notable Features
- [x] Proper Hibernation (Modes 3 and 25 supported)
- [x] Cleaner implementation of `_OSI` checks
- [x] Optimized Framebuffer Patch for smoother handshake with external displays
- [x] Added Disable BDPROCHOT driver to fix performance issues after waking from S3/S4 sleep. 
- [x] Working Thunderbolt 3 over USB-C
- [x] New USB Port Mapping with docking station support
- [x] Working clamshell mode (when connected to A/C and external display)
- [x] Working 3D globe in Maps app (macOS 12+)
- [x] No injection of `PlatformInfo` data into Microsoft Windows.
- [x] Lean EFI folder with slimmed kexts (20 MB instead of 62 MB):
 	- **AirportItlwm_Sonoma**: 1,8 instead of 16 MB. Only contains Firmware for Intel AC 9560.
	- **AppleALC**: 86 Kb instead of 2,3 MB. Only contains layout `97`.
	- **IntelBluetoothFirmware**: 560 KB instead of 11,5 MB.
	- **itlwm** (1.5 mb instead of 16 mb). Only Contains Firmware for Intel AC 9560.

## Known Issues
- [ ] Fingerprint reader &rarr; incompatible with macOS
- [ ] Infrared portion of integrated camera unsupported by macOS &rarr; So moving the frontside switch to the left actually disables the camera in macOS (if you don't want to disable it in BIOS)
- [ ] SDCard Reader only works when a card is inserted prior to booting (&rarr; see [issue 59](https://github.com/0xFireWolf/RealtekCardReader/issues/59))
- [ ] YogaSMC hasn't been update in years, causes issues and is incompatibel with macOS Tahoe. That's why it's disabled by default

> [!IMPORTANT]
> 
> - Before reporting any issues, ensure that your system uses the latest available UEFI and EC Firmware.
> - Don't install macOS on an external disk or flash drive – use a compatible internal disk.

## Future Developments
- [x] Adjusted Framebuffer Patch so HDMI/DP Ports on docking stations can be utilized
- [x] Adding USB ports of docking station to the USB port kext
- [ ] Creating an AppleALC Layout-ID for audio output on Docking Station

---

## System Specs

Category | Description
-------:|------------
**Model** | Lenovo ThinkPad T490 
**Variant** | [**20N3**](https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t490-type-20n2-20n3/document-userguide)
**UEFI BIOS** | v1.84 (2025-07-03)
**EC** | v1.27
**ME Firmware** | v12.0.95.2489
**CPU** | Intel [**Intel Core i5 8265U**](https://ark.intel.com/content/www/us/en/ark/products/149088/intel-core-i58265u-processor-6m-cache-up-to-3-90-ghz.html) (Quad Core)
**RAM** | 16 GB: <ul> <li> 8 GB Samsung DDR 4 @2666 Mhz (soldered) <li> 8 GB Samsung DDR 4 @2666 Mhz (RAM Slot)
**Storage** | ~~Samsung PM981a NVMe~~ ([**unusable**](https://dortania.github.io/Anti-Hackintosh-Buyers-Guide/Storage.html)) <br> Western Digital PC SN530 NVMe SSD
**Display** | Full HD (1080p) (Non-Touch)
**iGPU** | Intel(R) Grpahics UHD 620 (spoofed as Intel UHD 630, BusID: `2`)
**dGPU** | None
**Audio** | [**Realtek ALC257**](https://github.com/dreamwhite/ChonkyAppleALC-Build/blob/master/Realtek/ALC257.md) (using Layout `97`)
**Thunderbolt** | <ul><li>**Model**: Titan Ridge Thunderbolt 3 Connector (USB-C) <li>**Firmware**: 1.41.1353.0  <li>Tested with i-tec [USB-C Metal Nano](https://i-tec.pro/de/produkt/c31nanodockpropd-3/) Docking Station
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
**Config** | **Display** <ul> <li>Shared Display Priority: `HDMI` <li> Total Graphics Memory: irrelevant for macOS </ul> **CPU** <ul> <li> Intel Hyperthreading Technology: `ON` 
**Security** | **Fingerprint** <ul><li>Predesktop Authentication: `OFF` </ul> **Security Chip** <ul><li>Security Chip`ON` or `OFF` (enable for Windows 11) </ul> **Memory Protection** <ul> <li> Execution Prevention: `ON`</ul></ul> **Virtualization** <ul><li> Kernel DMA Protection: `ON` (enables `VT-D` by design)</ul> **I/O Port Access** <ul> <li> Ethernet LAN: `ON` <li> Wireless LAN: `ON` <li> Bluetooth: `ON` <li> USB Port: `ON` <li> Memory Card Slot: `ON` <li> Smart Card Slot: `OFF` <li> Integrated Camera: `ON` <li> Integrated Audio: `ON` <li> Microphone: `ON` <li> Fingerprint Reader: `ON` (works in Windows only) or `OFF` <li> Thunderbolt 3: `ON` </ul> **Absolute Persistance Module** <ul><li> Absolute Persistance Module Activation: `Disabled`</ul> **Secure Boot Configuration** <ul><li> Secure Boot: `OFF` </ul> **Intel SGX** <ul><li> Intel SGX Control: `Disabled`
**Startup** | <ul> <li> **UEFI/ Legacy Boot**: `UEFI Only` <li> **Boot Mode**: `Quick` (Skips Diagnostics)

## EFI Folder Content

<details>
<summary><strong>Click to reveal</strong></summary><br>

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
│   │   ├── SSDT-OSDW.aml
│   │   ├── SSDT-PLUG.aml
│   │   ├── SSDT-PNLF.aml
│   │   ├── SSDT-PORTS.aml
│   │   ├── SSDT-PTSWAK.aml
│   │   ├── SSDT-T490-KBRD.aml
│   │   ├── SSDT-THINK.aml
│   │   └── SSDT-USBX.aml
│   ├── Drivers
│   │   ├── AudioDxe.efi
│   │   ├── DisablePROCHOT.efi
│   │   ├── HfsPlus.efi
│   │   ├── OpenCanopy.efi
│   │   ├── OpenRuntime.efi
│   │   └── ResetNvramEntry.efi
│   ├── Kexts (Loading managed by MinKernel/MaxKernel settings)
│   │   ├── AdvancedMap.kext
│   │   ├── AirportItlwm_Sequoia.kext
│   │   ├── AirportItlwm_Sonoma.kext
│   │   ├── AMFIPass.kext
│   │   ├── AppleALC.kext
│   │   ├── BlueToolFixup.kext
│   │   ├── BrightnessKeys.kext
│   │   ├── CPUFriend.kext
│   │   ├── CPUFriendDataProvider.kext
│   │   ├── ECEnabler.kext
│   │   ├── HibernationFixup.kext
│   │   ├── IntelBluetoothFirmware.kext
│   │   ├── IntelBluetoothInjector.kext
│   │   ├── IntelBTPatcher.kext
│   │   ├── IntelMausiEthernet.kext
│   │   ├── IO80211FamilyLegacy.kext
│   │   ├── IOSkywalkFamily.kext
│   │   ├── itlwm.kext
│   │   ├── Lilu.kext
│   │   ├── NVMeFix.kext
│   │   ├── RealtekCardReader.kext
│   │   ├── RealtekCardReaderFriend.kext
│   │   ├── RestrictEvents.kext
│   │   ├── RTCMemoryFixup.kext
│   │   ├── SimpleMSR.kext
│   │   ├── SMCBatteryManager.kext
│   │   ├── SMCProcessor.kext
│   │   ├── SMCSuperIO.kext
│   │   ├── USBMap.kext
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
│   │   │   │   └── GoldenGate 
│   │   │   └── Blackosx
│   │   │       └── BsxM1 (removed icons from tree view)
│   │   └── Label (removed files from tree view)
│   └── Config.plist
└── OC Changelog.md
```
</details>

## Preparations

### Config Adjustments

If your T490 matches the specs listed above and you are installing macOS Sonoma or newer, only minimal changes to `config.plist` are required.

At minimum, generate valid SMBIOS data.

* Download the **latest release** of this EFI and extract it.
* Open `config.plist` using ProperTree or OCAT.
* Make the following adjustments:

**PlatformInfo → Generic**

* Generate `MLB`, `SystemSerialNumber`, and `ROM` for `MacBookPro15,2` (using GenSMBIOS or OCAT).

**Graphics**
`Devices → Properties → Add → PciRoot(0x0)/Pci(0x2,0x0)`

* For macOS ≤ 13.3:
  Disable/remove `enable-backlight-registers-alternative-fix` and use `enable-backlight-registers-fix` instead (prevents black screen).
* If display issues occur, try a different framebuffer patch from `Additional_Files/Framebuffer_Patches/UHD620_Framebuffer_Patches.plist`.

**Wi-Fi** (&rarr; Check [AirpotItlwm vs. Itlwm](AirportItlwm_vs_itlwm.md) for more details)

* **Sonoma**: `AirportItlwm_Sonoma` (no root patches required).
* **Sequoia**/**Tahoe**: `AirportItlwm_Sequoia` (requires root patching with OCLP-Mod).
* **Optional**: `itlwm.kext` is present but disabled. If you want to use it, enabled it but disable  `AirportItlwm` kexts.

**Kernel → Quirks**

* `AppleXcpmCfgLock` is not required on my system. Enable only if your machine fails to boot.

**NVRAM → Add → 7C436110-AB2A-4BBB-A880-FE41995C9F82**

* Optional debug boot arguments:
  `-v debug=0x100 keepsyms=1`

**UEFI → APFS**

* For installing macOS Catalina or older, set `MinVersion` and `MinDate` to `-1`.

Save the changes and test the EFI from USB before installing it to the internal disk.

> [!IMPORTANT]
>
> - Do not change the SMBIOS model unless you also update the `model` property inside the `USBMap.kext` because the USB port mapping is SMBIOS-dependent; if mismatched, Bluetooth will not work.
> - This Wi-FI and BT kexts in this EFI are slimmed and only contain firmware for the Intel AC-9560. If your T490 uses a different Wi-Fi card, use the official itlwm and BT Firmware kexts.

### Recommended configuration (until further notice)

Since macOS Tahoe 26.4 beta, root-patching audio leads to a bricked, undbootable system. Therefore, I would recommend staying on **macOS Sequoia** and using **itlwm** kexts instead of **AirportItwm_Sequoia** for WiFi since it doesn't require root patching at all.

**Nceessary Config adjustment**:

- **Kernel/Block**:
	- Disable `com.apple.iokit.IOSkywalkFamily`
- **Kernel/Add**:
	- Disable `IOSkywalkFamily.kext`
	- Disbale `IO80211FamilyLegacy.kext`
	- Disable `AirportItlwm_Sequoia.kext`
	- Enable `itlwm.kext`
- Use [**Heliport**](https://github.com/OpenIntelWireless/HeliPort/releases) App to connect to Wi-Fi APs. There's also a [fork](https://github.com/sambow23/HeliPort) with an updated version with some qualitiy-of-life improvements

---

## Deployment

### If macOS is installed already
- Put the EFI folder on a FAT32 formatted USB flash drive
- Reboot from said USB flash drive for testing
- If it works, mount your system's ESP (EFI System Partiton), replace the BOOT and OC folders in the EFI folder
- Continue with Post-Install

### If macOS is not installed
- Follow Dortania's [**OpenCore Install Guide**](https://dortania.github.io/OpenCore-Install-Guide/installer-guide/#making-the-installer) to prepare a USB Installer
- Download the latest version of [**HeliPort**](https://github.com/diepeterpan/HeliPort/releases) and copy the .dmg to your USB Installer (only required for macOS Tahoe since it requires `itlwm.kext` for WiFi)
- Next, mount the ESP (EFI System Partiton), of the USB Installer – you can use [**MountEFI**](https://github.com/corpnewt/MountEFI) for this
- Place the EFI folder in the EFI partition
- Restart your system and boot from the USB installer.
- Install macOS.
- Once macOS is installed, copy the bootloader files from the USB Installer to the internal disk in order to boot without the USB flash drive (&rarr; [Instructions](https://dortania.github.io/OpenCore-Post-Install/universal/oc2hdd.html#grabbing-opencore-off-the-usb))
- Disconnect the USB Installer and reboot into macOS
- Continue with Post-Install

> [!CAUTION]
> 
> Upgrading from to macOS 14.3.1 to 14.4 or newer via `System Update` causes a Kernel Panic during install! Disable `AiportItlwm` and enable `itlwm.kext` instead. Set `SecureBootModel` to `Disabled`, reset NVRAM and run the update again. If this does not work, use this [workaround](https://github.com/5T33Z0/OC-Little-Translated/blob/main/W_Workarounds/macOS14.4.md) to install macOS 14.4 on a new APFS volume. Use Migration Manager afterwards to get your data onto the new volume!

## Post-Install

### Disable Gatekeeper (optional)
Gatekeeper can be really annoying and wants to stop you from running python scripts from Github, etc. Do the following to disable it:

- Open Terminal and run: `sudo spctl --master-disable`
- The process has slightly changed in macOS Sequoia 15.1.1. and newer [more info](https://github.com/5T33Z0/OC-Little-Translated/blob/main/14_OCLP_Wintel/Guides/Disable_Gatekeeper.md)

### macOS Tahoe fixes (Audio)
In order for Audio to work you need to apply root-pateches with [**OCLP-Mod**](https://github.com/laobamac/OCLP-Mod/) since the offial OCLP version is not available yet. Make sure that you are connected to the internet before attempting to apply root patches because the patcher needs to download additional files.

- Open the app's settings:<br><img width="609" height="331" alt="oclpmod02" src="https://github.com/user-attachments/assets/ecc08229-e0f2-4e0b-bd99-d3787a3fcf70" />
- Click on the highlighted Tab and enable the following setting before patching and press "OK" at the bottom:<br><img width="604" height="410" alt="Bildschirmfoto 2026-01-02 um 19 24 50" src="https://github.com/user-attachments/assets/568cae6d-066d-4cde-8b9c-a94b0b16d76a" />
- Press the upper right button for root patching:<br>![oclp_mod01](https://github.com/user-attachments/assets/ad42427a-3726-480e-89a3-d2bd98754c3c)
- Next, press the upper button to install patches and wait until patching is completed:<br>![oclp_mod02](https://github.com/user-attachments/assets/25e5fc28-05de-4cdd-ac3d-d5a28d06d1db)
- Once patching is complete, reboot.

Audio and Bluetooth should work now. If there's no sound, you have to go into system settings to change the output to "Internal Speakers"

### WiFi

#### Option 1: enable `AirportItlwm.kext` in macOS Sequoia+

Apply Root-Patches with OCLP-Mod. [More details](https://github.com/5T33Z0/OCLP4Hackintosh/blob/main/Enable_Features/AirportItllwm_Sequoia.md)

#### Option 2: For `Itlwm.kext` users

- Mount **HeliPort.dmg**, drag the app into the "Programs" folder and run it.
- Use it to connect to your WiFI hotspot.
- Add HeliPort to "Login Items", so it stars with macOS and connects to your WiFi network automatically.

### Enable YogaSMC (optional, not recommended)

Starting with Release 1.0.5 v1.0 of my OC EFI folder, I've disabled YogaSMC and the required SSDTs due to reported [CPU performance issues](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/issues/44#issuecomment-2798489637). You can still re-enable it if you want to but I won't support it.

- **Config Settings**: 
  - Enable `SSDT-ECRW.aml`, `SSDT-THINK.aml` and `YogaSMC.kext`
  - Disable `SSDT-T490-KBRD.aml` and ACPI patches for the Keyboard Shortcuts
- Download [**YogaSMC.7z**](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Additional_Files/YogaSMC) and extract it.
- Double-click the YogaSMC **prefPane** to install it
- Drag the `YogaSMC` app into the "Programs" folder and run it
- Click on the icon (⌥) in the menu bar and select "Start at Login"
- Now you can control performance profiles, fan speed and other settings

### Configure CPUFriend
- Use [**CPUFriendFriend**](https://github.com/corpnewt/CPUFriendFriend) to generate your own `CPUFriendDataProvider.kext` to optimize CPU Power Management if your T490 uses a different CPU than mine.

### Configure Hibernation
Open Terminal and enter the following commands, to enable Hibernation (=`hibernatemode 25`). If you don't want to use Hibernation, use `hibernatemode 3` (= regukar S3 Sleep) instead:

```shell
# Enable hibernatemode 25 (sleep to disk, power off RAM)
sudo pmset -a hibernatemode 25

# Enable standby (required for hibernation to actually work)
sudo pmset -a standby 1

# Set standby delays (time before entering hibernation)
sudo pmset -a standbydelayhigh 900    # 15 minutes when battery > 50%
sudo pmset -a standbydelaylow 900     # 15 minutes when battery < 50%

# Sleep timings (optional - adjust to preference)
sudo pmset -a displaysleep 10         # Display sleeps after 10 minutes
sudo pmset -a disksleep 10            # Hard disk sleeps after 10 minutes
sudo pmset -a sleep 1                 # System sleeps after 1 minute of inactivity

# Disable wake-causing features
sudo pmset -a powernap 0              # Disable Power Nap
sudo pmset -a tcpkeepalive 0          # Prevent network from waking system
sudo pmset -a proximitywake 0         # Disable wake when iPhone/iPad nearby
sudo pmset -a ttyskeepawake 0         # Prevent remote login from preventing sleep
sudo pmset -a womp 0                  # Disable wake-on-LAN
```

> [!TIP]
> 
> For more details, have a look at my [Hibernation Configuration Guide](https://github.com/5T33Z0/OC-Little-Translated/blob/main/04_Fixing_Sleep_and_Wake_Issues/Changing_Hibernation_Modes/README.md).

### Install MonitorControl (optional)
[**MonitorControl**](https://github.com/MonitorControl/MonitorControl) is a helpful little tool that lets you control the brightness and contrast of external displays from the menubar.

## Understanding YogaSMC Settings
Open the YogaSMC preference pane. You will find the following options (among others):

- `DYTC`: DYTC stands for `Dynamic Thermal Control`. It allows the OS or firmware to manage the thermal characteristics of a device or component dynamically, adjusting power and performance to maintain safe operating temperatures. 3 profiles are available: "Quiet", "Balanced", and "Performance"
- If you tick the `PSC support`, the control for the slider becomes more nuanced. Instead of 3 positions it gets more increments. I think `PSC` refers to `Power State Current` in the `DSDT` and is used to control different levels of performance via the slider.

### Disabling YogaSMC
If you don't want to use YogaSMC, do the following:

- In macOS:
	- Open System Preferences
	- Right-Click on `YogaSMCPane` and remove it
	- Under "Login items" (or similar) remove the YogaSMC App from the list
- Config.plist: 
	- Under `ACPI`, disable `SSDT-THINK.aml` and `SSDT-ECRW.aml`
	- Under `Kernel`, disable `YogaSMC.kext`

> [!NOTE]
> 
> After disabling YogaSMC, fan and performance controls are no longer available. F-keys besides Volume and Brightness will no longer work either.

## Compiling Intel Wi-Fi and Bluetooth Firmware kexts easily

Chris1111 has created a helpful little app called [**Wifi-Intel-KextsBuilder**](https://github.com/chris1111/Wifi-Intel-KextsBuilder) which automates the process of compiling Intel Wi-Fi and Bluetooth Firmware kexts. It only requires you to have Xcode installed and will handle the rest on its own once you run it.

Wifi-Intel-KextsBuilder downloads the source code of itlwm, IntelBluetoothFirmware, MacKernelSDK and Lilu and then compiles itlwm, AirportItlwm and Intel Bluetooth Firmware kexts. They will be located under "Users/YOUR_USERNAME/Developer/Wifi-Intel-KextsBuilder/ in the "build/Release" folder of each repo.

These kexts won't be slimmed like the ones present in my EFI folders but at least you now have a simple option to compile them on your own in the future. For compiling slimmed kexts, you can [follow my guide](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Additional_Files/Slimmed_Kexts/Intel_AC-9650) to do so.

## Links
[T490 Thunderbolt EEPROM Fix](https://github.com/SkippyHub/Lenovo-thinkpad-T490-thunderbolt-eeprom-fix)

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
