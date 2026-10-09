# Lenovo ThinkPad T490 Hackintosh OpenCore

[![OpenCore](https://img.shields.io/badge/OpenCore-1.0.9-cyan.svg?style=flat-square&title=OpenCore%20Bootloader)](https://github.com/acidanthera/OpenCorePkg/releases/latest)
[![macOS](https://img.shields.io/badge/macOS-14.x--26.x-005BB5.svg?style=flat-square&title=Supported%20macOS%20Versions)](https://www.apple.com/macos/)
[![Release](https://img.shields.io/badge/Download-Latest-success.svg?style=flat-square&title=Latest%20Release)](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/releases/latest)
![ThinkPad T490 Hackintosh](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/assets/76865553/ed932a1a-8205-4b81-a4e2-f68d7d8a7178)

---

## About
OpenCore EFI folder and config for running macOS Sonoma and newer on the Lenovo ThinkPad T490. Read the following documentation carefully in order to install/boot macOS successfully!

> [!CAUTION]
>
> The **Samsung PM981a NVMe** that comes with the system is NOT compatible with macOS. You **_must_** use a different, compatible NVMe drive! 

---

## ✨ Notable Features

- [x] 📶 **Native Wi-Fi support** — Use the native AirPort Utility in macOS Sequoia/Tahoe without requiring Root Patches
- [x] 🔌 **Working Thunderbolt 3** — Thunderbolt 3 over USB-C is fully functional
- [x] 🔗 **Updated USB mapping** — New USB port mapping with docking station support
- [x] 💤 **Proper hibernation** — Supports hibernation modes `3` and `25`
- [x] 🖥️ **Working clamshell mode** — Functions correctly when connected to AC power and an external display
- [x] ⚡ **Disable BDPROCHOT** — Prevents performance issues after waking from S3/S4 sleep
- [x] 🧩 **Cleaner `_OSI` implementation** — Improved handling of ACPI OS detection
- [x] 🖥️ **Optimized framebuffer patch** — Smoother handshaking with external displays
- [x] 🌍 **3D Maps globe** — Working 3D globe in Apple Maps on macOS 12 and later
- [x] 🪟 **Windows-safe PlatformInfo** — `PlatformInfo` data is not injected into Microsoft Windows
- [x] 🪶 **Lean EFI** — Reduced from 62 MB to 18 MB by removing unnecessary firmware and resources

---

## ⚠️ Known Issues

- [ ] 🔐 **Fingerprint reader** → Incompatible with macOS
- [ ] 💾 **SD card reader** → Only works when a card is inserted before booting. See [issue #59](https://github.com/0xFireWolf/RealtekCardReader/issues/59).
- [ ] 📷 **IR camera** → The infrared portion of the integrated camera is unsupported by macOS. The physical camera switch controls the camera hardware: **moving the switch to the left cuts power/disconnects the camera, so the regular webcam is also disabled in macOS**. This allows you to disable the camera without disabling it in the BIOS.
- [ ] 🛠️ **YogaSMC** → Hasn't been updated in years, causes issues, and is incompatible with macOS Tahoe. It is therefore disabled by default.

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
**UEFI BIOS** | v1.85
**EC** | v1.28
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
**SD Card Reader** | Realtek MicroSD Card Reader (RTS522A)
**Dock** | [**ThinkPad Ultra Docking Station**](https://support.lenovo.com/us/en/solutions/pd500173-thinkpad-ultra-docking-station-overview-and-service-parts)

---

## BIOS Settings
After powering on the machine, spam <kbd>F1</kbd> until you hear a beep to enter the BIOS. Change the following settings:

Category | Setting
:-------:|------------
**Config** | **Display** <ul> <li>Shared Display Priority: `HDMI` <li> Total Graphics Memory: irrelevant for macOS </ul> **CPU** <ul> <li> Intel Hyperthreading Technology: `ON` 
**Security** | **Fingerprint** <ul><li>Predesktop Authentication: `OFF` </ul> **Security Chip** <ul><li>Security Chip`ON` or `OFF` (enable for Windows 11) </ul> **Memory Protection** <ul> <li> Execution Prevention: `ON`</ul></ul> **Virtualization** <ul><li> Kernel DMA Protection: `ON` (enables `VT-D` by design)</ul> **I/O Port Access** <ul> <li> Ethernet LAN: `ON` <li> Wireless LAN: `ON` <li> Bluetooth: `ON` <li> USB Port: `ON` <li> Memory Card Slot: `ON` <li> Smart Card Slot: `OFF` <li> Integrated Camera: `ON` <li> Integrated Audio: `ON` <li> Microphone: `ON` <li> Fingerprint Reader: `ON` (works in Windows only) or `OFF` <li> Thunderbolt 3: `ON` </ul> **Absolute Persistance Module** <ul><li> Absolute Persistance Module Activation: `Disabled`</ul> **Secure Boot Configuration** <ul><li> Secure Boot: `OFF` </ul> **Intel SGX** <ul><li> Intel SGX Control: `Disabled`
**Startup** | <ul> <li> **UEFI/ Legacy Boot**: `UEFI Only` <li> **Boot Mode**: `Quick` (Skips Diagnostics)

---

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
│   │   ├── AirportItlwm_Tahoe.kext
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

---

## Preparations

### Config Adjustments

If your T490 matches the specifications listed above and you are installing **macOS Sonoma or newer**, only minimal changes to `config.plist` are required. At a minimum, you must generate valid SMBIOS data.

1. Download the **latest release** of this EFI and extract it.
2. Open `config.plist` using **ProperTree** or **OCAT**.
3. Make the following adjustments:

#### PlatformInfo → Generic

Generate the following values for `MacBookPro15,2` using **OCAT** or **GenSMBIOS**:

- `MLB`
- `SystemSerialNumber`
- `ROM`

#### DeviceProperties → Graphics

Navigate to:

`DeviceProperties → Add → PciRoot(0x0)/Pci(0x2,0x0)`

- **macOS ≤ 13.3:** Disable or remove `enable-backlight-registers-alternative-fix` and use `enable-backlight-registers-fix` instead. This prevents a black screen on affected versions.
- If you experience display issues, try one of the alternative framebuffer patches provided in `Additional_Files/Framebuffer_Patches/UHD620_Framebuffer_Patches.plist`.

#### Wi-Fi

See [AirPortItlwm vs. Itlwm](AirportItlwm_vs_itlwm.md) for a detailed comparison.

- **Default:** `AirportItlwm` kexts for **Sonoma, Sequoia, and Tahoe** are included and work without requiring Root Patches.
- **Alternative:** `itlwm.kext`
  - Disable `AirportItlwm` kexts.
  - Enable `itlwm.kext`.

#### Kernel → Quirks

- `AppleXcpmCfgLock` is **not required on my system**. Enable it only if your T490 fails to boot without it.

#### NVRAM → Add → `7C436110-AB2A-4BBB-A880-FE41995C9F82`

Optional debug boot arguments:

```text
-v debug=0x100 keepsyms=1
```

#### UEFI → APFS

When installing **macOS Catalina or older**, set:

- `MinVersion` → `-1`
- `MinDate` → `-1`

Save your changes and **test the EFI from a USB drive before installing it to the internal EFI partition**.

> [!IMPORTANT]
>
> - **Do not change the SMBIOS model** unless you also update the `model` property inside `USBMap.kext`. The USB port mapping is SMBIOS-dependent. A mismatched SMBIOS can cause **Bluetooth to stop working**.
> - The Wi-Fi and Bluetooth kexts included in this EFI are **slimmed down** and contain firmware only for the **Intel AC 9560**. If your T490 uses a different Wi-Fi card, use the **official, full versions** of `itlwm`/`AirportItlwm` and IntelBluetoothFirmware instead.

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

---

## Post-Install

### Disable Gatekeeper
Gatekeeper can be really annoying and wants to stop you from running python scripts or unsigned apps like Heliport, etc. Do the following to disable it:

- Open Terminal and run: `sudo spctl --master-disable`
- The process has slightly changed in macOS Sequoia 15.1.1. and newer [more info](https://github.com/5T33Z0/OC-Little-Translated/blob/main/14_OCLP_Wintel/Guides/Disable_Gatekeeper.md)

### macOS Tahoe: enable analog audio

&rarr; Follow [this guide](https://github.com/5T33Z0/OCLP4Hackintosh/blob/main/Enable_Features/Audio_Tahoe.md) to enable analog audio in macOS Tahoe

### WiFi

#### Option 1: `AirportItlwm.kext` in macOS Sonoma+

Just connect to your WiFi Accesspoint of your choise – no root patches required. 

> [!NOTE]
>
> My EFI contains `AirportItlwm.kext` builds for macOS Sonoma, Sequoia, and Tahoe. For older macOS versions, download the [7-Zip archive](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/raw/refs/heads/main/Additional_Files/Kexts/Slimmed_Kexts/Intel_AC-9650/itlwm/2.4.0/Release.7z) containing pre-compiled `AirportItlwm` builds for macOS High Sierra through Tahoe, with firmware specifically for the Intel AC-9650. Extract the archive and use the build matching your macOS version. Use [Keka](https://www.keka.io/de/) for extraction if the built-in unarchiver fails.

#### Option 2: For `Itlwm.kext` users

- Mount **HeliPort.dmg**, drag the app into the "Programs" folder and run it.
- Use it to connect to your WiFI hotspot.
- Add HeliPort to "Login Items", so it stars with macOS and connects to your WiFi network automatically.

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
> For more details, have a look at my [Hibernation Configuration Guide](https://github.com/5T33Z0/OC-Little-Translated/tree/main/Content/04_Fixing_Sleep_and_Wake_Issues/Changing_Hibernation_Modes).

### Tips for Firefox users

Firefox users should force H.264 video output to enable hardware decoding to reduce heat generated by software decoding ([Instructions](Enable_Firefox_Hardware-Acceleration.md))

### Configure CPUFriend
- Use [**CPUFriendFriend**](https://github.com/corpnewt/CPUFriendFriend) to generate your own `CPUFriendDataProvider.kext` to optimize CPU Power Management if your T490 uses a different CPU than mine.

### Install MonitorControl (optional)

[**MonitorControl**](https://github.com/MonitorControl/MonitorControl) is a helpful little tool that lets you control the brightness and contrast of external displays from the menubar.

---

## Why is YogaSMC Disabled?

Starting with **Release 1.0.5**, YogaSMC and its required SSDTs are disabled by default due to reported **CPU performance issues**. See [issue #44](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/issues/44#issuecomment-2798489637).

You can still enable YogaSMC if you need its additional controls, but **it is not recommended** since it has been years since it has been updated and the prep pane crashes in Sequoia/Tahoe.

### Enabling YogaSMC

> [!WARNING]
> 
> YogaSMC may cause CPU performance issues. Enable it at your own risk.

1. **Update `config.plist`:**
   - Enable `SSDT-ECRW.aml`
   - Enable `SSDT-THINK.aml`
   - Enable `YogaSMC.kext`
   - Disable `SSDT-T490-KBRD.aml`
   - Disable the ACPI patches related to keyboard shortcuts

2. Download [**YogaSMC.7z**](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Additional_Files/YogaSMC) and extract it.

3. Double-click the **YogaSMC preference pane** to install it.

4. Move the `YogaSMC` app to the **Applications** folder and launch it.

5. Click the YogaSMC icon in the menu bar and enable **Start at Login**.

You can then use YogaSMC to control performance profiles, fan speed, and other hardware settings.

### YogaSMC Settings

The YogaSMC preference pane provides several settings, including:

- **DYTC** — Dynamic Thermal Control. Provides three thermal/performance profiles:
  - `Quiet`
  - `Balanced`
  - `Performance`
- **PSC Support** — Provides finer-grained control over the performance slider instead of the default three positions.

### Removing YogaSMC

If you decide to disable YogaSMC again:

**In macOS:**

- Open **System Settings**.
- Remove `YogaSMCPane` from the installed preference panes.
- Remove the YogaSMC app from **Login Items**.

**In `config.plist`:**

- Under `ACPI`, disable:
  - `SSDT-THINK.aml`
  - `SSDT-ECRW.aml`
- Under `Kernel`, disable:
  - `YogaSMC.kext`

> [!NOTE]
> 
> After disabling YogaSMC, fan and performance controls provided by YogaSMC are no longer available. Function keys other than **volume** and **brightness** will also no longer work.

---

## Compiling Intel Wi-Fi and Bluetooth Firmware kexts easily

Chris1111 has created a helpful little app called [**Wifi-Intel-KextsBuilder**](https://github.com/chris1111/Wifi-Intel-KextsBuilder) which automates the process of compiling Intel Wi-Fi and Bluetooth Firmware kexts. It only requires you to have Xcode installed and will handle the rest on its own once you run it.

Wifi-Intel-KextsBuilder downloads the source code of itlwm, IntelBluetoothFirmware, MacKernelSDK and Lilu and then compiles itlwm, AirportItlwm and Intel Bluetooth Firmware kexts. They will be located under "Users/YOUR_USERNAME/Developer/Wifi-Intel-KextsBuilder/ in the "build/Release" folder of each repo.

These kexts won't be slimmed like the ones present in my EFI folders but at least you now have a simple option to compile them on your own in the future. For compiling slimmed kexts, you can [follow my guide](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/tree/main/Additional_Files/Slimmed_Kexts/Intel_AC-9650) to do so.

## Links
- [Lenovo Driver and Software Matrix](https://download.lenovo.com/cdrt/tools/drivermatrix/dm_2.html)
- [T490 Thunderbolt EEPROM Fix](https://github.com/SkippyHub/Lenovo-thinkpad-T490-thunderbolt-eeprom-fix)

## Credits and Thank Yous
- [**Acidanthera**](https://github.com/acidanthera) for OpenCore, Kexts and maciASL
- Chris1111 for [**Wifi-Intel-KextsBuilder**](https://github.com/chris1111/Wifi-Intel-KextsBuilder)
- [**CorpNewt**](https://github.com/corpnewt) for ProperTree, CPUFriendFriend and SSDTTime
- Dreamwhite for slimmed versions of [**itlwm.kext**](https://github.com/dreamwhite/Chonky-itlwm-Build/releases)
- [**ic005k**](https://github.com/ic005k/OCAuxiliaryTools) for OpenCore Auxiliary Tools
- [**benbaker76**](https://github.com/benbaker76/Hackintool) for Hackintool
- [**zxystd**](https://github.com/zxystd/BrcmPatchRAM) for Sonoma-compatible BrcmPatchRAM kext
- [**laobamac**](https://github.com/laobamac) for Sequoia/Tahoe compatibile AirportItlwm kext
- **Special Thx to**:
	- [1Revenger1](https://github.com/1Revenger1/) for VoodooRMI and fixing issues with the TrackPad
	-  deeveedee for advice when trying to optimize the framebuffer patch for connecting to my external display. 
	- **T490 OpenCore Repos** used for referencing and ACPI hotfixes:
	- [yusifsalam](https://github.com/yusifsalam/t490-macos)
	- [Krissh-C ](https://github.com/Krissh-C/T490-macOS)
	- [ganyuanzhen](https://github.com/ganyuanzhen/T490-Hackintosh-Opencore)
	- [laserdyke](https://github.com/laserdyke/t490-opencore)
	- [ZoR3oL](https://github.com/ZoR3oL/t490-hackintosh)
