# Script made by azurejoga, https://github.com/azurejoga
# From the accessibility group in games for the blind, Eternal Legend, https://eternal-legend.com.br

# Configure execution policy to allow all scripts
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force

# Initial message
Write-Host "Script made by azurejoga, https://github.com/azurejoga"
Write-Host "From the accessibility group in games for the blind, Eternal Legend, https://eternal-legend.com.br"
Start-Sleep -Seconds 3

# Function to disable Windows Defender and add exclusions
function Disable-WindowsDefender {
    Write-Host "Disabling Windows Defender..." -ForegroundColor Green
    Set-MpPreference -DisableRealtimeMonitoring $true
    Write-Host "Adding exclusions for Downloads and Balatro directories..." -ForegroundColor Green
    $downloadsPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')
    Add-MpPreference -ExclusionPath $downloadsPath
    Add-MpPreference -ExclusionPath "C:\Program Files (x86)\Steam\steamapps\common\Balatro"
    $balatroAppDataPath = [System.IO.Path]::Combine($env:APPDATA, 'Balatro')
    Add-MpPreference -ExclusionPath $balatroAppDataPath
}

# Function to reactivate Windows Defender
function Enable-WindowsDefender {
    Write-Host "Re-enabling Windows Defender..." -ForegroundColor Green
    Set-MpPreference -DisableRealtimeMonitoring $false
}

# Function to download files
function Download-File {
    param (
        [string]$url,
        [string]$output
    )
    Write-Host "Downloading $url ..." -ForegroundColor Green
    Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing
}

# Function to extract zip files
function Extract-Zip {
    param (
        [string]$zipPath,
        [string]$destination
    )
    Write-Host "Extracting $zipPath to $destination ..." -ForegroundColor Green
    Expand-Archive -Path $zipPath -DestinationPath $destination -Force
    Remove-Item $zipPath -Force
    Write-Host "$zipPath extracted and deleted." -ForegroundColor Green
}

# Function to install Lovely Injector
function Install-LovelyInjector {
    $downloadsPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')
    $url = "https://github.com/ethangreen-dev/lovely-injector/releases/download/v0.5.0-beta3/lovely-x86_64-pc-windows-msvc.zip"
    $zipPath = "$($downloadsPath)\lovely.zip"
    $extractPath = "$($downloadsPath)\lovely"

    Download-File -url $url -output $zipPath
    Extract-Zip -zipPath $zipPath -destination $extractPath

    $versionDll = "$($extractPath)\version.dll"
    $balatroDir = "C:\Program Files (x86)\Steam\steamapps\common\Balatro"
    Copy-Item -Path $versionDll -Destination $balatroDir -Force
    Write-Host "Lovely Injector installed successfully." -ForegroundColor Green
    Remove-Item -Recurse -Force $extractPath
}

# Function to install Steamodded
function Install-Steamodded {
    $downloadsPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')
    $url = "https://github.com/Steamopollys/Steamodded/archive/refs/heads/main.zip"
    $zipPath = "$($downloadsPath)\steamodded.zip"
    $extractPath = "$($downloadsPath)\Steamodded-main"

    Download-File -url $url -output $zipPath
    Extract-Zip -zipPath $zipPath -destination $downloadsPath

    $modDir = [System.IO.Path]::Combine($env:APPDATA, 'Balatro', 'Mods')
    if (-not (Test-Path $modDir)) {
        New-Item -Path $modDir -ItemType Directory
    }
    Copy-Item -Path $extractPath -Destination $modDir -Recurse
    Write-Host "Steamodded installed successfully." -ForegroundColor Green
    Remove-Item -Recurse -Force $extractPath
}

# Function to install BlackHole
function Install-BlackHole {
    $downloadsPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')
    $url = "https://github.com/Aurelius7309/BlackHole/archive/refs/heads/main.zip"
    $zipPath = "$($downloadsPath)\blackhole.zip"
    $extractPath = "$($downloadsPath)\BlackHole-main"

    Download-File -url $url -output $zipPath
    Extract-Zip -zipPath $zipPath -destination $downloadsPath

    $modDir = [System.IO.Path]::Combine($env:APPDATA, 'Balatro', 'Mods')
    if (-not (Test-Path $modDir)) {
        New-Item -Path $modDir -ItemType Directory
    }
    Copy-Item -Path $extractPath -Destination $modDir -Recurse
    Write-Host "BlackHole mod files copied to $modDir." -ForegroundColor Green

    $balatroDir = "C:\Program Files (x86)\Steam\steamapps\common\Balatro"
    $binPath = "$($extractPath)\bin\*"
    Copy-Item -Path $binPath -Destination $balatroDir -Recurse
    Write-Host "BlackHole bin files copied to $balatroDir." -ForegroundColor Green

    Remove-Item -Recurse -Force $extractPath
}

# Function to install Achievements Enabler
function Install-AchievementsEnabler {
    $url = "https://raw.githubusercontent.com/Steamopollys/Steamodded/main/example_mods/Mods/AchievementsEnabler.lua"
    $achievementsFilePath = [System.IO.Path]::Combine($env:APPDATA, 'Balatro', 'Mods', 'AchievementsEnabler.lua')

    Write-Host "Downloading Achievements Enabler mod..." -ForegroundColor Green
    Invoke-WebRequest -Uri $url -OutFile $achievementsFilePath -UseBasicParsing
    Write-Host "Achievements Enabler mod installed successfully." -ForegroundColor Green
}

# Function to install the Nopeus mod
function Install-Nopeus {
    $downloadsPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')
    $url = "https://codeload.github.com/jenwalter666/JensBalatroCollection/zip/refs/heads/main"
    $zipPath = "$($downloadsPath)\JensBalatroCollection-main.zip"
    $extractPath = "$($downloadsPath)\JensBalatroCollection-main"

    Download-File -url $url -output $zipPath
    Extract-Zip -zipPath $zipPath -destination $downloadsPath

    $nopeusModPath = [System.IO.Path]::Combine($extractPath, 'Nopeus')
    $modDir = [System.IO.Path]::Combine($env:APPDATA, 'Balatro', 'Mods')
    if (-not (Test-Path $modDir)) {
        New-Item -Path $modDir -ItemType Directory
    }
    Copy-Item -Path $nopeusModPath -Destination $modDir -Recurse
    Write-Host "Nopeus mod installed successfully." -ForegroundColor Green

    Remove-Item -Recurse -Force $extractPath
}

# Main Script Execution
try {
    # Step 1: Disable Windows Defender and set exclusions
    Disable-WindowsDefender

    # Step 2: Install Lovely Injector
    Install-LovelyInjector

    # Step 3: Install Steamodded
    Install-Steamodded

    # Step 4: Install BlackHole
    Install-BlackHole

    # Step 5: Install Achievements Enabler
    Install-AchievementsEnabler

    # Step 6: Install Nopeus mod
    Install-Nopeus

    Write-Host "All installations completed successfully." -ForegroundColor Green
} catch {
    Write-Error "An error occurred: $_"
} finally {
    # Step 7: Reactivate Windows Defender
    Enable-WindowsDefender
}
