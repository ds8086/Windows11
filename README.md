# Windows 11
You thought Vista was bad?! Buckle up buttercup, you've never been *less* in control of what your operating system is doing than with Windows 11. Back in the day, we all turned to [Black Viper](https://www.blackviper.com/) for Windows tuning tips, this repo is an homage to that lost art. Settings will be configured via local GPO whenever possible as I feel group policy changes have the best chance of surviving revert via a patch. What cannot be configured via local GPO, will be set via registry. Native PowerShell cmdlets will be used for app removal and the like.

# Script Execution
1. Clone this repo or otherwise download it in its entirety.
2. Launch an administrative PowerShell session, navigate to the downloaded repo directory.
3. Run the PowerShell script via the *dot-slash filename* syntax below.

`.\script.ps1`

> [!WARNING]
> If you receive errors regarding execution policy run `Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process` then the script!

## Applications
Currently a short list of unwanted applications removed via winget. AppX package logic coming soon...

## Registry
Explorer, tasksbar, and themes settings. A mix of personal preferences and attempts to increase UI responsiveness.

## GPO
Group policies configured with the understanding that...
- I never asked Windows to connect to the **cloud** or anything **online** unless *I* tell it to.
- I will not connect Windows to my **consummer** Microsoft account.
- I do not want **Cortana** nor **Search** connected to the internet.
- I do not use **OneDrive**.
- I will not beta test patches via Windows **update**.

> [!TIP]
> After running the script, use the *Keyword Filter* in group policy editor with the **bold** keywords above.

 # Log
- **2025.02.09:** Day 1 of trying to make Windows 11 usable.
- **2025.02.12:** More policies controlling unwanted online services.
- **2025.02.18:** Removed 'Windows Notepad' after finding AI "features".