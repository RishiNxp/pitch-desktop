# Pitch Windows Desktop

## Download and run

1. [Download the latest Windows release](https://github.com/RishiNxp/pitch-desktop/releases/latest/download/Pitch-Windows-x64.zip).
2. In File Explorer, right click the ZIP and choose **Extract All**.
3. Open the extracted **Pitch** folder and run **Pitch.exe**.

Keep the extracted folder intact. The ZIP includes the portable app runtime, and Pitch runs offline. The current Windows release is unsigned, so Windows may show a download warning.

## Build and release

Use Windows and Node.js 22.12 or newer. Clone this repository, install dependencies, run the logic checks, and build the portable ZIP:

~~~powershell
git clone https://github.com/RishiNxp/pitch-desktop.git
cd pitch-desktop
npm ci
npm test
.\Build-Windows.ps1
~~~

To publish an update, commit and push your changes to **main**, then push a new, unused version tag. For example:

~~~sh
git add -A
git commit -m "Describe the desktop update"
git push origin main
git tag v1.1.2
git push origin v1.1.2
~~~

The version tag starts the Windows packaging workflow. After it succeeds, the new ZIP appears on the [releases page](https://github.com/RishiNxp/pitch-desktop/releases). Use the next unused tag for each later release. You need write access to the repository to push to it.

## Build from source without packaging

~~~sh
npm ci
npm run dev
~~~
