# AdventofCode 2022 - Day 03
# Answers: 8123 and 2620

# region Include required files
$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

try {
    . ("$ScriptDirectory\..\shared\functions.ps1")
}
catch {
    Write-Error "Error while loading supporting PowerShell Scripts" 
}
#endregion

Show-Header -year 2022 -day "03"

$inputLines = Get-Content -Path $PSScriptRoot\input\day03.txt

if ($inputLines -ne $null) {
    Show-Details -text "Input read successfully" -color Yellow
}
else {
    Show-Details -text "Input could not be read" -color DarkYellow
} 

Function Get-RucksackScore{
    param (
        [string]$partA,
        [string]$partB
    )

    if ($partA.Length -ne $partB.Length) {
        Show-Details -text "There is a problem with your input. Strings are not the same length" -color Red
    }
    $byteCodeSum = 0
    $partAarray = $partA.ToCharArray()
    $partBarray = $partB.ToCharArray()

    foreach ($charA in $partAarray) {
        if ($partBarray.Contains($charA)) {
            $byteCode = [byte][char]$charA
            if ($byteCode -lt 97)
            {
                #UCase
                return ($byteCode-38)
            }
            else {
                #LCase
                return ($byteCode-96)
            }
        }
    }
    return $byteCodeSum
}

Function Get-RucksackAuthenticitySticker{
    param (
        [array]$rucksack
    )

    $rucksack = $rucksack | Sort-Object { $_.Length } -Descending

    $byteCodeSum = 0
    $partAarray = $rucksack[0].ToCharArray()
    $partBarray = $rucksack[1].ToCharArray()
    $partCarray = $rucksack[2].ToCharArray()

    foreach ($charA in $partAarray) {
        if (($partBarray.Contains($charA)) -and ($partCarray.Contains($charA))){
            $byteCode = [byte][char]$charA
            if ($byteCode -lt 97)
            {
                #UCase
                return ($byteCode-38)
            }
            else {
                #LCase
                return ($byteCode-96)
            }
        }
    }
    return $byteCodeSum
}

$linecounter = 0
$linelength = 0 
$totalPrio = 0

ForEach ($line in $inputLines)
{
    if (($line -ne $null) -and ($line -ne '')) {
        # We have content from the line
        $linecounter++
        $linelength = $line.length
        $compartmentA = $line.Substring(0, $linelength/2)
        $compartmentB = $line.Substring($linelength/2)
        $priority = (Get-RucksackScore -partA $compartmentA -partB $compartmentB)

        Show-Details -text ("Line: " + $linecounter + ", Length: " + $linelength +", A: " + $compartmentA + ", B: " + $compartmentB + ", priority " + $priority) -color Yellow
        $totalPrio = $totalPrio + $priority
    }
}

Write-Host "a: " + ([byte][char]'a') + ", A: " + ([byte][char]'A')

Show-Details -text " " -color White
Show-Details -text ("The answer to PART I is " + $totalPrio) -color Green




# PART II here
$priorityScore = 0
$lineindex = 0
ForEach ($line in $inputLines) {
    if ($lineindex -eq 0) {
        $currentArrayOfRucksacks = @($null, $null, $null)
    }

    # put this line in the array of 3
    $currentArrayOfRucksacks[$lineindex] = $line

    $lineindex++
    if ($lineindex -eq 3) {

        $priorityScore = $priorityScore + (Get-RucksackAuthenticitySticker -rucksack $currentArrayOfRucksacks)
        #this is the last one
        $lineindex = 0
    }
}

Show-Details -text ("The answer to PART II is " + $priorityScore) -color Green

