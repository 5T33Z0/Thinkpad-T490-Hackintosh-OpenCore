# Slimmed AppleALC kext
**System**: Lenovo ThinkPad T490</br>
**Codec**: Realtek ALC257 </br>
**Included Layouts**: `97`</br>
**Size**: 86 kb <br>
**Latest Version**: 1.9.3

## Codec Structure
![](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/blob/main/Additional_Files/SysReport/Audio/Codec-Dump.png?raw=true)

## How to
- Download and unzip the **Latest AppleALC-Release**
- Replace the existing AppleALC.kext in your `EFI/OC/Kexts` folder
- Change the Layout-ID in boot-args or Device Properties to `97`
- Save and Reboot

## Compile your own
- [**Follow my guide**](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/blob/main/Additional_Files/Slimmed_Kexts/AppleALC/For_Compiling/)

## Notes
- When using OCAT to update your kexts, exclude AppleALC. Otherwise this kext will be replaced by the stock version
- Don't use this kext with any other Layout-Id than `97` – it won't work!
