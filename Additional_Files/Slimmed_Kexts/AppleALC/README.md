# Slimmed AppleALC kext
**Mainboard**: Lenovo ThinkPad T490</br>
**Codec**: Realtek ALC257 </br>
**Included Layouts**: `97`</br>
**Size**: 86 kb <br>
**Version**: 1.8.4

## Codec Structure
![](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/blob/main/Additional_Files/SysReport/Audio/Codec-Dump.png?raw=true)

## How to
- Download and unzip the **Latest AppleALC-Release**
- Replace the existing AppleALC.kext in your `EFI/OC/Kexts` folder
- Change the Layout-ID in boot-args or Device Properties to `97`
- Save and Reboot

## Compile your own
- Download the [**AppleALC**](https://github.com/acidanthera/AppleALC) Source Code and unzip it
- Download the "Resources_ALC257" folder from my repo and unzip it
- Replace the "Resources" folder in the "AppleALC-Master" folder with mine
- [**Compile the kext**](https://github.com/5T33Z0/AppleALC-Guides/tree/main/Slimming_AppleALC) (requires Xcode)

## Notes
- When using OCAT to update your kexts, exclude AppleALC. Otherwise this kext will be replaced by the stock version
- Don't use this kext with any other Layout-Id than `97` – it won't work!
