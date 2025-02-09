# Applications I never asked for
Function Applications {

# Applications to remove via Winget
$WingetRemove = @(
    'OneDrive',
    'Microsoft.Teams',
    'Copilot',
    'Quick Assist',
    'Dev Home',
    'Microsoft To Do',
    'Power Automate',
    'Microsoft Bing Search',
    'Microsoft News',
    'Outlook for Windows'
)

# Winget source agreements
winget list --accept-source-agreements | Out-Null

# Remove applications in array above
$i = 0
foreach ($wr in $WingetRemove) {
    $i++
    Write-Progress "Removing bloatware: $wr" -PercentComplete ($i / $WingetRemove.Count * 100)
    winget uninstall $wr
}

}

Function Registry {

# Taskbar alignment left... it's always been left
$taskbarAl = 0000000
New-ItemProperty `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
    -Name "TaskbarAl" `
    -Value "0" `
    -PropertyType "DWORD" `
    -Force

# Disable transparency
New-ItemProperty `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
    -Name "EnableTransparency" `
    -Value "0" `
    -PropertyType "DWORD" `
    -Force

# Disable animations
New-ItemProperty `
    -Path "HKCU:\Control Panel\Desktop" `
    -Name "AnimationDuration" `
    -Value "0" `
    -PropertyType "DWORD" `
    -Force
}

Function GroupPolicy {
    .\LGPO.exe /g .\gpo
}

Applications
Registry
GroupPolicy