# Pitch Desktop

Open **Releases** and download **Pitch-Windows-x64.zip**. Extract the entire folder and run **Pitch.exe**. The download includes the runtime and works offline. The portable executable is unsigned.

Pitch supports gear trains, belts, tensioners, shared axles, dimensions, and independent drive ratios. Use Save file to share layouts with the web edition.

## Build a Windows release

From the repository root on Windows with Node.js 22.12 or newer, run `./Build-Windows.ps1`. The script builds the renderer, downloads the pinned Electron runtime, verifies its checksum, and writes the portable ZIP. Run `npm test` for the drivetrain logic suite.
