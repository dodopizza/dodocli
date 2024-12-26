# Define temporary and destination directories
$tempDir = Join-Path -Path $env:TEMP -ChildPath "first"
$destDir = Join-Path -Path $env:USERPROFILE -ChildPath "dodocli"

# Create temporary directory
New-Item -Path $tempDir -ItemType Directory -Force | Out-Null

# Determine OS and platform
$os = "windows"  # Since this is a PowerShell script for Windows
$platform = if ([Environment]::Is64BitProcess) { "amd64" } else { "arm64" }

# Download the dodo CLI zip file
$zipFile = Join-Path -Path $tempDir -ChildPath "dodo.zip"
Invoke-WebRequest -Uri "https://github.com/dodopizza/dodocli/releases/latest/download/dodo_${os}_${platform}.zip" -OutFile $zipFile

# Extract the zip file
Expand-Archive -Path $zipFile -DestinationPath $tempDir -Force

# Mark dodo as executable (not necessary in Windows, but setting ACL could be considered)
$dodoExe = Join-Path -Path $tempDir -ChildPath "dodo.exe"

# Print dodo version
& $dodoExe --version

# Create destination directory
New-Item -Path $destDir -ItemType Directory -Force | Out-Null

# Move dodo.exe to the destination directory
Move-Item -Path $dodoExe -Destination $destDir

# Add dodocli to PATH if not already present
$oldPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
if ($oldPath -notcontains $destDir) {
    $newPath = "$oldPath;$destDir"
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::User)
}

# Clean up
Remove-Item -Path $tempDir -Recurse -Force

# Final message
Write-Host "Installation complete. Restart your terminal or run `$profile to start using dodo CLI"