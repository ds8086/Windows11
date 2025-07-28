<#
.SYNOPSIS
Optimizes Windows 11.

.DESCRIPTION
Optimizes Windows 11.

.NOTES
Author:
    DS
Notes:
    Revision 04
Revision:
    V01: 2025.02.09 by DS :: First revision.
    V02: 2025.07.18 by DS :: Initial removal of Xbox & gaming apps.
    V03: 2025.07.23 by DS :: Added logic for optionally keeping Xbox & gaming apps. Added this helpful header.
    V04: 2025.07.28 by DS :: Expanded logic for optionally keeping gaming registry entries. Added 'Skip' parameter and logic.
Call From:
    PowerShell v5.1 or higher

.PARAMETER GameOn
Switched parameter which, when specified, will leave Xbox and gaming "features" in place and will not add registry entries to disable game recording and capture.

.PARAMETER Skip
Specify this parameter along with any combination of 'Applications', 'Registry', and/or 'GroupPolicy' to skip processing the steps(s).

.EXAMPLE
.\Optimize-Windows11.ps1
Optimizes Windows 11.

.EXAMPLE
.\Optimize-Windows11.ps1 -GameOn
Optimizes Windows 11 as much as possible while leaving Xbox and Gaming applications installed.

.EXAMPLE
.\Optimize-Windows11.ps1 -Skip GroupPolicy
Optimizes Windows 11 but skips applying group policy objects.

.EXAMPLE
.\Optimize-Windows11.ps1 -Skip GroupPolicy, Registry
Optimizes Windows 11 but skips applying group policy objects and adding registry entries.
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)]
    [switch]$GameOn = $false,
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("Applications", "Registry", "GroupPolicy")]
    [string[]]$Skip
)

# Applications I never asked for...
Function Applications {

# Applications to remove via Winget
$WingetRemove = @(
    'Copilot',
    'Dev Home',
    'Feedback Hub',
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

# Also remove Xbox, Game Bar, and Game Speech
If ($GameOn -eq $False) {
    $WingetRemove += @(
        'Game Bar',
        'Game Speech Window',
        'Microsoft Edge Game Assist',
        'Xbox',
        'Xbox TCUI',
        'Xbox Console Companion',
        'Xbox Game Bar Plugin',
        'Xbox Identity Provider'
    )
}

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
If ($GameOn -eq $False) {
    $RegFiles += Get-ChildItem -Path ".\reg\gaming\*.reg"
}

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
$Functions = "Applications","Registry","GroupPolicy"
$Functions | ForEach-Object {
    If ($Skip -notcontains $_) {
        Write-Verbose "Processing $_"
        & $_
    }
    Else {
        Write-Verbose "Skipping $_"
    }
}