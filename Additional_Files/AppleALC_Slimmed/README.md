# Slimmed AppleALC kext

**Mainboard**: Lenovo ThinkPad T490 Vision G</br>
**Codec**: Realtek ALC257 </br>
**Included Layouts**: `97`</br>
**AppleALC Version**: 1.8.4 (86 kb) </br>

## Codec Structure

## PinConfig

## How to
- Download and extract the **Latest AppleALC-Release**
- Replace the existing AppleALC.kext in your `EFI/OC/Kexts` folder
- Change the Layout-ID in boot-args or Device Properties to `17`
- Save and Reboot 

## Notes

- If you update AppleALC with OCAT or similar, this kext will be overwritten and you're back to stock.
- Don't use this kext with any other Layout-Id than `97` – it won't work!
- If you want to compile your own slimmed down AppleALC kext, you can follow my tutorial [**here**](https://github.com/5T33Z0/AppleALC-Guides/tree/main/Slimming_AppleALC)
