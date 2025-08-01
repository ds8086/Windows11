# Windows 11
You thought Vista was bad?! Buckle up buttercup, you've never been *less* in control of what your operating system is doing than with Windows 11. Back in the day, we all turned to [Black Viper](https://www.blackviper.com/) for Windows tuning tips, this repo is an homage to that lost art. Settings will be configured via local GPO whenever possible as I feel group policy changes have the best chance of surviving revert via a patch. What cannot be configured via local GPO, will be set via registry. Native PowerShell cmdlets will be used for app removal and the like.

# Script Execution
1. Clone this repo or otherwise download it in its entirety.
2. Launch an administrative PowerShell session, navigate to the downloaded repo directory.
3. Run the PowerShell script via the *dot-slash filename* syntax below.

`.\Optimize-Windows11.ps1`

> [!WARNING]
> If you receive errors regarding execution policy run the line below, then the script! <br>
> `Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process`

## Applications
Currently a short list of unwanted applications removed via winget.

- Copilot
- Dev Home
- Feedback Hub
- Game Bar
- Game Speech Window
- Microsoft Bing Search
- Microsoft News
- Microsoft Photos
- Microsoft Sticky Notes
- Microsoft To Do
- Microsoft.Teams
- OneDrive
- Outlook for Windows
- Power Automate
- Quick Assist
- Windows Notepad
- Xbox
- Xbox Console Companion
- Xbox Game Bar Plugin
- Xbox Identity Provider
- Xbox TCUI

> [!IMPORTANT]
> If you use the Xbox & Game Bar/Speech features, run script with the `-GameOn` switch.

`.\Optimize-Windows11.ps1 -GameOn`

## Registry
Explorer, tasksbar, and themes settings. A mix of personal preferences and attempts to increase UI responsiveness.

## GPO
Group policies configured with the understanding that...
- I never asked Windows to connect to the **cloud** or anything **online** unless *I* tell it to.
- I do not want **Cortana** nor **Search** connected to the internet.
- I do not use **OneDrive**.
- I will not beta test patches via Windows **update**.

> [!TIP]
> After running the script, use the *Keyword Filter* in group policy editor with the **bold** keywords above.

 # Log
- **2025.02.09:** Day 1 of trying to make Windows 11 usable.
- **2025.02.12:** More policies controlling unwanted online services.
- **2025.02.18:** Removed 'Windows Notepad' after finding AI "features".
- **2025.02.20:** Removed 'Sticky Notes' and 'Photos'. Reg entries for old school photo viewer.
- **2025.03.01:** Updated registry entry function and reg file organization.
- **2025.03.12:** Modified Windows Update policies following 2nd unexpected install & reboot.
- **2025.03.17:** Modified Windows Update policies after compare with JS.
- **2025.07.18:** Removed XBox bloatware. Added reg entry for 'old' right-click context menu.
- **2025.07.21:** Reallowed consumer account (Minecraft). Disabled AI (recall). Removed reg for photo viewer.
- **2025.07.23:** Further HKCU reg entries. Updated script name and readme. Added script help.
- **2025.07.28:** Folders added to explorer. "Recommended" removed from Start. Logic for skipping steps.