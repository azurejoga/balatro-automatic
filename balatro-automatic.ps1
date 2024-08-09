# Script made by azurejoga, https://github.com/azurejoga
# From the accessibility group in games for the blind, Eternal Legend, https://eternal-legend.com.br

# Configure execution policy to allow all scripts
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force

# Function to display message with delay
function Show-Message {
    param (
        [string]$message
    )
    Write-Host $message -ForegroundColor Green
    Start-Sleep -Seconds 5
}

# Function to disable Windows Defender and add exclusions
function Disable-WindowsDefender {
    Show-Message "Disabling Windows Defender..."
    Set-MpPreference -DisableRealtimeMonitoring $true
    Show-Message "Adding exclusions for Downloads and Balatro directories..."
    $downloadsPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')
    Add-MpPreference -ExclusionPath $downloadsPath
    Add-MpPreference -ExclusionPath "$gameDir\Balatro"
    $balatroAppDataPath = [System.IO.Path]::Combine($env:APPDATA, 'Balatro')
    Add-MpPreference -ExclusionPath $balatroAppDataPath
}

# Function to reactivate Windows Defender
function Enable-WindowsDefender {
    Show-Message "Re-enabling Windows Defender..."
    Set-MpPreference -DisableRealtimeMonitoring $false
}

# Function to download files
function Download-File {
    param (
        [string]$url,
        [string]$output,
        [string]$itemName
    )
    Show-Message "Downloading $itemName from $url ..."
    Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing
}

# Function to extract zip files
function Extract-Zip {
    param (
        [string]$zipPath,
        [string]$destination
    )
    Show-Message "Extracting $zipPath to $destination ..."
    Expand-Archive -Path $zipPath -DestinationPath $destination -Force
    Remove-Item $zipPath -Force
    Show-Message "$zipPath extracted and deleted."
}

# Function to install Lovely Injector
function Install-LovelyInjector {
    $url = "https://github.com/ethangreen-dev/lovely-injector/releases/download/v0.5.0-beta3/lovely-x86_64-pc-windows-msvc.zip"
    $zipPath = [System.IO.Path]::Combine($downloadsPath, 'lovely.zip')
    $extractPath = [System.IO.Path]::Combine($downloadsPath, 'lovely')

    Download-File -url $url -output $zipPath -itemName "Lovely Injector"
    Extract-Zip -zipPath $zipPath -destination $extractPath

    $versionDll = [System.IO.Path]::Combine($extractPath, 'version.dll')
    Copy-Item -Path $versionDll -Destination $gameDir -Force
    Show-Message "Lovely Injector installed successfully."
    Remove-Item -Recurse -Force $extractPath
}

# Function to install Steamodded
function Install-Steamodded {
    $url = "https://github.com/Steamopollys/Steamodded/archive/refs/heads/main.zip"
    $zipPath = [System.IO.Path]::Combine($downloadsPath, 'steamodded.zip')
    $extractPath = [System.IO.Path]::Combine($downloadsPath, 'Steamodded-main')

    Download-File -url $url -output $zipPath -itemName "Steamodded"
    Extract-Zip -zipPath $zipPath -destination $downloadsPath

    $modDir = [System.IO.Path]::Combine($env:APPDATA, 'Balatro', 'Mods')
    if (-not (Test-Path $modDir)) {
        New-Item -Path $modDir -ItemType Directory
    }
    Copy-Item -Path $extractPath -Destination $modDir -Recurse -Force
    Show-Message "Steamodded installed successfully."
    Remove-Item -Recurse -Force $extractPath
}

# Function to install BlackHole
function Install-BlackHole {
    $url = "https://github.com/Aurelius7309/BlackHole/archive/refs/heads/main.zip"
    $zipPath = [System.IO.Path]::Combine($downloadsPath, 'blackhole.zip')
    $extractPath = [System.IO.Path]::Combine($downloadsPath, 'BlackHole-main')

    Download-File -url $url -output $zipPath -itemName "BlackHole"
    Extract-Zip -zipPath $zipPath -destination $downloadsPath

    $modDir = [System.IO.Path]::Combine($env:APPDATA, 'Balatro', 'Mods')
    if (-not (Test-Path $modDir)) {
        New-Item -Path $modDir -ItemType Directory
    }
    Copy-Item -Path $extractPath -Destination $modDir -Recurse -Force
    Show-Message "BlackHole mod files copied to $modDir."

    $binPath = [System.IO.Path]::Combine($extractPath, 'bin\*')
    Copy-Item -Path $binPath -Destination $gameDir -Recurse -Force
    Show-Message "BlackHole bin files copied to $gameDir."

    Remove-Item -Recurse -Force $extractPath
}

# Function to install Achievements Enabler
function Install-AchievementsEnabler {
    $url = "https://raw.githubusercontent.com/Steamopollys/Steamodded/main/example_mods/Mods/AchievementsEnabler.lua"
    $achievementsFilePath = [System.IO.Path]::Combine($env:APPDATA, 'Balatro', 'Mods', 'AchievementsEnabler.lua')

    Show-Message "Downloading Achievements Enabler mod from $url ..."
    Invoke-WebRequest -Uri $url -OutFile $achievementsFilePath -UseBasicParsing
    Show-Message "Achievements Enabler mod installed successfully."
}

# Function to install the Nopeus mod
function Install-Nopeus {
    $url = "https://codeload.github.com/jenwalter666/JensBalatroCollection/zip/refs/heads/main"
    $zipPath = [System.IO.Path]::Combine($downloadsPath, 'JensBalatroCollection-main.zip')
    $extractPath = [System.IO.Path]::Combine($downloadsPath, 'JensBalatroCollection-main')

    Download-File -url $url -output $zipPath -itemName "Nopeus"
    Extract-Zip -zipPath $zipPath -destination $downloadsPath

    $nopeusModPath = [System.IO.Path]::Combine($extractPath, 'Nopeus')
    $modDir = [System.IO.Path]::Combine($env:APPDATA, 'Balatro', 'Mods')
    if (-not (Test-Path $modDir)) {
        New-Item -Path $modDir -ItemType Directory
    }
    Copy-Item -Path $nopeusModPath -Destination $modDir -Recurse -Force
    Show-Message "Nopeus mod installed successfully."

    Remove-Item -Recurse -Force $extractPath
}

# Function to choose the game directory
function Choose-GameDirectory {
    param (
        [string]$defaultDir
    )

    Add-Type -AssemblyName System.Windows.Forms
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.Description = "Do you want to choose the game installation directory or use the default?"
    $folderBrowser.ShowNewFolderButton = $false

    $choice = Read-Host "Do you want to choose the game installation directory? 1: Default (C:\Program Files (x86)\Steam\steamapps\common\Balatro), 2: Custom directory of your choice"

    if ($choice -eq '1') {
        return $defaultDir
    } elseif ($choice -eq '2') {
        $dialogResult = $folderBrowser.ShowDialog()
        if ($dialogResult -eq 'OK') {
            return $folderBrowser.SelectedPath
        } else {
            Write-Host "No directory selected. Exiting script." -ForegroundColor Red
            exit
        }
    } else {
        Write-Host "Invalid choice. Exiting script." -ForegroundColor Red
        exit
    }
}

# Main Script Execution
try {
    # Step 1: Prompt user for the installation directory
    $defaultDir = "C:\Program Files (x86)\Steam\steamapps\common\Balatro"
    $gameDir = Choose-GameDirectory -defaultDir $defaultDir
    $downloadsPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')

    # Step 2: Disable Windows Defender and set exclusions
    Disable-WindowsDefender

    # Step 3: Install Lovely Injector
    Install-LovelyInjector

    # Step 4: Install Steamodded
    Install-Steamodded

    # Step 5: Install BlackHole
    Install-BlackHole

    # Step 6: Ask user about Achievements Enabler mod
    $installAchievements = Read-Host "Do you want to install the Achievements Enabler mod? (y/n)"
    if ($installAchievements -eq 'y') {
        Install-AchievementsEnabler
    }

    # Step 7: Ask user about Nopeus mod
    $installNopeus = Read-Host "Do you want to install the Nopeus mod? (y/n)"
    if ($installNopeus -eq 'y') {
        Install-Nopeus
    }

    # Step 8: Reactivate Windows Defender
    Enable-WindowsDefender

    Show-Message "Installation completed successfully."
} catch {
    Show-Message "An error occurred: $_"
    Enable-WindowsDefender
}
