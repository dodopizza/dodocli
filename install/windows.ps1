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
$profilePath = [Environment]::GetFolderPath("UserProfile")
$userProfileScript = Join-Path -Path $profilePath -ChildPath "Documents\WindowsPowerShell\profile.ps1"
$addToPath = "`$env:PATH += `";$env:USERPROFILE\dodocli`""

if (!(Test-Path $userProfileScript -PathType Leaf) -or !(Select-String -Path $userProfileScript -Pattern "dodocli" -Quiet)) {
    Add-Content -Path $userProfileScript -Value $addToPath
}

# Setup config
$configFile = Join-Path -Path $destDir -ChildPath ".dodocli"
$configContent = @"
[default]
tenantId = "585ca83d-87b8-4ca9-8a30-98085370c548"
clientId = "8f27073c-3b4e-4700-a67c-a761778ef581"
subscriptionId = "f5954335-be33-4b17-9f4f-e12d152f5ebe"
"@
$configContent | Out-File -FilePath $configFile

# Clean up
Remove-Item -Path $tempDir -Recurse -Force

# Final message
Write-Host "Installation complete. Restart your terminal or run `$profile to start using dodo CLI"