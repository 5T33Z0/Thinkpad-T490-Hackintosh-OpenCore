# Compile a slimmed itlwm.kext


## Preparations

### Install Xcode
- Download the [correct version](https://developer.apple.com/support/xcode/) of [**Xcode**](https://developer.apple.com/download/all/?q=xcode) supported by your version of macOS. The download is about 10 GB and the installed application is about 30 GB in total, so make sure you have enough disk space.
- Move the Xcode app to the "Programs" folder – otherwise compiling fails.

### Prepare itlwm

- Download [**itlwm**](https://github.com/OpenIntelWireless/itlwm) source code (click on "Code" and select "Download zip")
- Unzip the file – "itlwm-master" folder will be created
- Run terminal
- Enter `cd`
- Hit <kbd>Spacebar</kbd>
- Drag in the itlwm-master folder and press <kbd>Enter</kbd>
- Enter `git clone https://github.com/acidanthera/MacKernelSDK` to downlo MacKernelSDK into the "itlwm-master" folder
- Navigate to `itlwm-master/itlwm/firmware`
- Delete every file except `iwm-9000-46`

## Compilig slimmed itlwm

- Double-click `itlwm.xcodeproj`
- Click on the Play button to run the process
- Next, return to the terminal window and type `xcodebuild` and hit Enter to comple the itlwm.kext
- It will be stored under /itlwm-master/build/Release

Done. Copy the kext to your EFI/OC/Kext folder, replacing the existing one and reboot.