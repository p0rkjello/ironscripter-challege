<#
Intermediate
For this level, you are challenged to write something in PowerShell that willl go through a directory of your scripts
and count the number of lines of code you have written. This should include .ps1 and .psm1 files.
Don’t worry about filtering out comments because those comments should be just as valuable as the code.
But you should filter out blank and empty lines.

Your code should produce a result object that displays these property values:

The parent path
The total number of files
The total lines of code and comments
The report date

Naturally, you want to write the most efficient PowerShell code that you can to accomplish this goal.
#>

function Get-CmdInventory {
    [CmdletBinding()]
    param(
        [string]
        $Path = 'Y:\PowerShell\scripts'
    )

    $Scripts = Get-ChildItem -Path $Path -Filter "*.ps*1" -File -Recurse

    [pscustomobject]@{
        "Parent Path" = $Path
        "File Count"  = $Scripts.Count
        "Total Lines" = (($Scripts | Get-Content | Where-Object { $_.Trim() -ne '' -and $_.Trim() -notmatch '^#' })).Count
        "Date"        = (Get-Date)
    }
}

<#
Advanced
For advanced users who have finished the previoius task, your challenge is a bit more daunting.
Using the same list of files, write a PowerShell tool that will generate a list of all the cmdlet and functions that you have used in your scripts.
The list should be ordered with the most used commands at the top of the list.
In other words, what commands do you use the most in your PowerShell scripts.

There are few caveats and guidelines.

It is OK to include commands found in comments.
This isn’t expected to be an absolute analysis as you may have used commands in modules that you no longer have installed.
Be cautious about performance. You are looking for X number of command names in every file.
The result at a minimum should include the count and command name.
Extra credit if you can detect and expand aliases.
If you want an extra challenge, include a property that is an array of all the file names that contain the command.

Good Hunting!
#>
