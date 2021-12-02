# AdventofCode 2021 - Day 01
# Answers: 1752 (site says it is NOT the correct answer!)

# region Include required files
$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
try {
    . ("$ScriptDirectory\shared\functions.ps1")
}
catch {
    Write-Error "Error while loading supporting PowerShell Scripts" 
}
#endregion

Show-Header -year 2021 -day "01"

$depths = Get-Content -Path $PSScriptRoot\input\day01.txt
$previous = $null
$answerCounter = 0

ForEach ($depth in $depths)
{
    if ($previous -ne $null) 
    {
        if ($depth -gt $previous) 
        {
            $answerCounter++
            Write-Output "$answerCounter Increased: $depth -gt $previous"
        }
    }

    $previous = $depth
}

Write-Output "The answer to the first question is: $answerCounter"