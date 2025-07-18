# Applications I never asked for...
Function Applications {

# Applications to remove via Winget
$WingetRemove = @(
    'Copilot',
    'Dev Home',
    'Game Bar',
    'Game Speech Window',
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
    'Windows Notepad', # AI in my Notepad? Not today!
    'Xbox',  # One too many pop-ups for 'Rewards'.
    'Xbox TCUI',
    'Xbox Console Companion',
    'Xbox Game Bar Plugin',
    'Xbox Identity Provider'
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

# Registry entries grouped into .reg files...
Function Registry {

# Registry files
$RegFiles = Get-ChildItem -Path ".\reg\*.reg"

# Import registry files
$i = 0
Foreach ($rf in $RegFiles) {
    $i++
    Write-Progress "Importing registry entries from $($rf.Name)" -PercentComplete ($i / $RegFiles.Count * 100)

    regedit /s $rf.FullName
}

}

# Good ol' LGPO. Wait, can I distribute this on GitHub?! We'll roll with it for now...
Function GroupPolicy {
    .\LGPO.exe /g .\gpo
}

# Run the functions
Applications
Registry
GroupPolicy