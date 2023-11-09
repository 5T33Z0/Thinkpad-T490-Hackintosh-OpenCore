# How to compile a slimmed version of `itlwm.kext`

## Preparations

### Install Xcode
- Download the correct version of [**Xcode**](https://xcodereleases.com/?scope=release) for your system. 
- Move the Xcode app to the "Programs" folder – otherwise compiling might fail.

### Prepare the `itlwm` source code
- Download [**itlwm**](https://github.com/OpenIntelWireless/itlwm) source code (click on "Code" and select "Download zip")
- Unzip the file – "itlwm-master" folder will be created
- Run Terminal
- Enter `cd ~/Downloads/itlwm-master`
- Next, enter `git clone https://github.com/acidanthera/MacKernelSDK` to download MacKernelSDK into the "itlwm-master" folder
- Leave the Terminal window open for later use
- In Finder, navigate to `~/Downloads/itlwm-master/itlwm/firmware`
- Delete every file except `iwm-9000-46`

## Compiling the kext
- Double-click `itlwm.xcodeproj`
- Click on the Play button to run the process
- Ignore all the warnings
- Return to the terminal window 
- Type `xcodebuild` and hit Enter to comple the `itlwm.kext`
- Once compiling is done, the kext will be located under `~/Downloads/itlwm-master/build/Release`
- Mount your EFI folder
- Copy the kext to `EFI/OC/Kexts`, replacing the existing one 
- Reboot.
- Done.

> [!NOTE]
> 
> If you are having issues with the slimmed kext, use the pre-cpmpiled version from the OpenIntelWireless repo.