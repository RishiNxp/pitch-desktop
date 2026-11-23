# Build the portable Windows x64 release from the repository root.
$ErrorActionPreference = 'Stop'
npm ci
if ($LASTEXITCODE) { throw 'Dependency installation failed' }
npm run build
if ($LASTEXITCODE) { throw 'Build failed' }
$version = '44.5.1'
$release = "https://github.com/electron/electron/releases/download/v$version"
$asset = "electron-v$version-win32-x64.zip"
$stage = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid().ToString())
New-Item -ItemType Directory $stage | Out-Null
Invoke-WebRequest "$release/$asset" -OutFile "$stage/runtime.zip"
$checks = (Invoke-WebRequest "$release/SHASUMS256.txt").Content
$expected = (($checks -split "`n" | Where-Object { $_.Trim().EndsWith(" $asset") }) -split '\s+')[0]
if ((Get-FileHash "$stage/runtime.zip").Hash -ne $expected) { throw 'Electron checksum mismatch' }
Expand-Archive "$stage/runtime.zip" "$stage/Pitch"
$app = New-Item -ItemType Directory "$stage/Pitch/resources/app"
Copy-Item desktop,dist -Destination $app -Recurse
Copy-Item desktop/application.json "$app/package.json"
Rename-Item "$stage/Pitch/electron.exe" 'Pitch.exe'
$editor = "$stage/rcedit-x64.exe"
Invoke-WebRequest 'https://github.com/electron/rcedit/releases/download/v2.0.0/rcedit-x64.exe' -OutFile $editor
& $editor "$stage/Pitch/Pitch.exe" --set-icon (Resolve-Path 'desktop/Pitch.ico').Path
if ($LASTEXITCODE) { throw 'Could not embed the Pitch icon' }
tar.exe -a -cf Pitch-Windows-x64.zip -C $stage Pitch
if ($LASTEXITCODE) { throw 'Archive creation failed' }
