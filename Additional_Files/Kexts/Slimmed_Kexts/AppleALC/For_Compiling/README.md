# Compiling slimmed AppleALC Kext
This guide is for compiling AppleALC for your Codec and the audio layout(s) of your choice only. This reduces the size of the kext from 3.8 MB to about 90 KB! That's a reduction of over 97 %!

## Preparations

### Install Xcode
- Download the [correct version](https://developer.apple.com/support/xcode/) of [**Xcode**](https://developer.apple.com/download/all/?q=xcode) supported by your version of macOS. The download is about 10 GB and the installed application is about 30 GB in total, so make sure you have enough disk space.
- Move the Xcode app to the "Programs" folder – otherwise compiling fails.

### Prepare AppleALC
- Download [**AppleALC**](https://github.com/acidanthera/AppleALC) (click on "Code" and "Download Zip") and extract it. An "AppleALC-Master" folder will be created
- In Terminal, enter: <kbd>cd</kbd>, hit <kbd>Spacebar</kbd>, drag the AppleALC-Master folder into the Terminal window and press <kbd>Enter</kbd>.
- Next, enter `git clone https://github.com/acidanthera/MacKernelSDK` and hit <kbd>Enter</kbd>. This downloads the **MacKernelSDK** to the AppleALC-Master folder.
- Add the **Debug** version of [**Lilu.kext**](https://github.com/acidanthera/Lilu/releases) to the AppleALC-Master folder.
- Download [R**esources_ALC257.zip**](https://github.com/5T33Z0/Thinkpad-T490-Hackintosh-OpenCore/raw/main/Additional_Files/Slimmed_Kexts/AppleALC/For_Compiling/Resources_ALC257.zip) and extract it. This creates a "Resources" folder.
- Take that "Resources" folder and move it into the AppleALC-Master folder, replacing the existing one.
- The resulting folder structure should look like this:</br>![](https://user-images.githubusercontent.com/76865553/173291777-9bc1285d-1ffa-479f-b7bf-b74cda6f23ae.png)

## Compile the Kext
- In Terminal, <kbd>cd</kbd> into the AppleALC folder (as described previously)
- Type `xcodebuild` and hit <kbd>Enter</kbd>
- Wait until compiling finishes
- Your custom AppleALC kext will be present under `AppleALC-Master/build/Release`
- Add the kext to your `EFI/OC/Kexts` folder, replacing the existing one.
- Adjust the Layout-ID to `97`
- Reboot and enjoy your slimmed AppleALC kext for the ALC257 for your Lenovo T490.

> [!NOTE]
>
> If you are running the `xcodebuild` command for the very first time on your machine, the will be a pop-up, to download Command Line Developer Tools. Once the tools are downloaded and installed, run the command again to build the kext.

## Credits and further resources
- Apple for [XCode](https://developer.apple.com/xcode/)
- Acidanthera for [AppleALC](https://github.com/acidanthera/AppleALC), [Lilu](https://github.com/acidanthera/Lilu) and [MacKernelSDK](https://github.com/acidanthera/MacKernelSDK)
- Reduce Xcode to about a fifth of its regular size by [deleting unused platforms](https://github.com/5T33Z0/AppleALC-Guides/blob/main/Slimming_AppleALC/Slimming_Xcode_for_Kexts.md#readme)
