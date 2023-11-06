# AdventofCode 2022 - Day 01
# Answers: 69912 and 208180

# region Include required files
$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

try {
    . ("$ScriptDirectory\..\shared\functions.ps1")
}
catch {
    Write-Error "Error while loading supporting PowerShell Scripts" 
}
#endregion

Show-Header -year 2022 -day "01"

$calories = Get-Content -Path $PSScriptRoot\input\day01.txt

if ($calories -ne $null) {
    Show-Details -text "Input read successfully" -color Yellow
}
else {
    Show-Details -text "Input could not be read" -color DarkYellow
} 

$sumOfCalories = 0
$lastSum = 0
$elfCounter = 0

$caloriesArrayList = [System.Collections.ArrayList]::new()

ForEach ($cal in $calories)
{
    if (($cal -ne $null) -and ($cal -ne '')) {
        # We have a number. 
        $sumOfCalories += $cal
    }
    else {
        $lastSum = $sumOfCalories
        $elfCounter += 1
        $sumOfCalories = 0

        #Show-Details -text ("Elf " + $elfCounter + " has " + $lastSum + " calories.") -color Green
        
        #Do not display the following output by adding Out-Null
        $caloriesArrayList.Add($lastSum) | Out-Null
    }
}

$theAnswerA = ($caloriesArrayList | Sort-Object -Descending)[0] 

Show-Details -text " " -color White
Show-Details -text ("The answer to PART I is " + $theAnswerA) -color Green

$theAnswerB = ($caloriesArrayList | Sort-Object -Descending)[1] 
$theAnswerC = ($caloriesArrayList | Sort-Object -Descending)[2] 

$totalPartTwo = ($theAnswerA+$theAnswerB+$theAnswerC)

Show-Details -text ("The answer to PART II is " + $totalPartTwo) -color Green
Show-Details -text " " -color White
