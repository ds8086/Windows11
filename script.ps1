# Applications I never asked for...
Function Applications {

# Applications to remove via Winget
$WingetRemove = @(
    'Copilot',
    'Dev Home',
    'Microsoft Bing Search',
    'Microsoft News',
    'Microsoft Photos', # How about a photo viewer without online integrations?
    'Microsoft Sticky Notes', # Outbound network traffic from Sticky Notes? On port 80?!
    'Microsoft To Do',
    'Microsoft.Teams',
    'OneDrive',
    'Outlook for Windows',
    'Power Automate',
    'Quick Assist',
    'Windows Notepad' # AI in my Notepad? Not today!
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

# Registry entries, settings will be grouped into .reg files at some point...
Function Registry {

# Taskbar alignment left... it's always been left
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

# Restore Photo Viewer
# https://www.tenforums.com/tutorials/14312-restore-windows-photo-viewer-windows-10-a.html
regedit /s ".\Restore_Windows_Photo_Viewer_ALL_USERS.reg"
}

# Good ol' LGPO. Wait, can I distribute this on GitHub?! We'll roll with it for now...
Function GroupPolicy {
    .\LGPO.exe /g .\gpo
}

# Run the functions
Applications
Registry
GroupPolicy