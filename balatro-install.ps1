# PowerShell script to download, run and delete balatro-automatic.ps1 script
# Function to ensure the script is running as administrator
function Ensure-Admin {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host "This script requires administrator permissions. Restarting as administrator..."
        Start-Process -FilePath "powershell" -ArgumentList "-Command & {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"' -Verb RunAs}" -Verb RunAs
        Exit
    }
}
Ensure-Admin

# Configure execution policy to allow all scripts
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force


# 2. Define variables for file paths
$downloadFolder = "$env:USERPROFILE\Downloads"
$scriptUrl = "https://github.com/azurejoga/balatro-automatic/raw/master/balatro-automatic.ps1"
$scriptPath = "$downloadFolder\balatro-automatic.ps1"
$exePath = "$downloadFolder\balatro-install.exe"

# 3. Download the script using WebClient
Write-Output "Downloading the script..."
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($scriptUrl, $scriptPath)
Write-Output "Script downloaded successfully!"

# 4. Run the downloaded PowerShell script
Write-Output "Running the script..."
$process = Start-Process powershell.exe -ArgumentList "-File `"$scriptPath`"" -PassThru

Write-Output "Process concluded!"
