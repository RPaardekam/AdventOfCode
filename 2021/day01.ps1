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
$greaterCounter = 0
$lowerCounter = 0

ForEach ($depth in $depths)
{
    if ($previous -ne $null) 
    {
        if ($depth -gt $previous) 
        {
            $greaterCounter++

            $showText = "gt $greaterCounter $previous to $depth"
            
            Show-Details -text $showText -color Green            
        }
        else {
            $lowerCounter++
            $showText = "lt $lowerCounter $previous to $depth"
            
            Show-Details -text $showText -color Red
        }
    }

    $previous = $depth
}

Show-Details -text " " -color White
Show-Details -text "The answer to the question is: $greaterCounter" -color White
Show-Details -text "The validation counter contains: $lowerCounter" -color White
Show-Details -text "Together they should be 1999: $lowerCounter + $greaterCounter" -color White