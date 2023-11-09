# AdventofCode 2022 - Day 04
# Answers: 444 and 801

#region start every day with this snippet
$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

try {
    . ("$ScriptDirectory\..\shared\functions.ps1")
}
catch {
    Write-Error "Error while loading supporting PowerShell Scripts" 
}

# When using the shared functions, always start by getting inputLines
$inputLines = Get-InputData -year 2022 -day 04
#endregion

# PART I starts here
$hitCounter = 0
ForEach ($line in $inputLines)
{
    # Every line contains 2 items, separated by a comma.
    $assignments = $line.split(',')
    $hit = $false

    # Get the assignments for each Elf
    $elfArange = $assignments[0].split('-')
    $elfBrange = $assignments[1].split('-')

    # Now process the min and max values

    # First check if both assignments are IDENTICAL
    if (($elfArange[0] -eq $elfBrange[0]) -and ($elfArange[1] -eq $elfBrange[1])){
        $hitCounter++
        $hit = $true
        Show-Details -text ("HIT " + $hitCounter + "! Identical assignments: " + $line) -color Blue
    }
    else {
        if ([int]$elfArange[0] -ge [int]$elfBrange[0]) {
            # min A is larger or equal than min B, go check the max

            if ([int]$elfArange[1] -le [int]$elfBrange[1]) {
                # this is a hit: A is within B
                $hitCounter++
                $hit = $true
                Show-Details -text ("HIT " + $hitCounter + "! A is in B: $line") -color Green
            }
        }

        if ([int]$elfBrange[0] -ge [int]$elfArange[0]) {
            # min B is larger or equal than min A, go check the max
            if ([int]$elfBrange[1] -le [int]$elfArange[1]) {
                # this is a hit: B is within A
                $hitCounter++
                $hit = $true
                Show-Details -text ("HIT " + $hitCounter + "! B is in A: $line") -color Magenta
            }
        }
    }

    if (-not $hit) {
        Show-Details -text ("NO HIT " + $line) -color Red
    }
}

Show-Details -text " " -color White
Show-Details -text ("The answer to PART I is " + $hitCounter) -color Green

# PART II starts here
$hitCounter = 0
ForEach ($line in $inputLines)
{
    # Every line contains 2 items, separated by a comma.
    $assignments = $line.split(',')
    $hit = $false

    # Get the assignments for each Elf
    $elfArange = $assignments[0].split('-')
    $elfBrange = $assignments[1].split('-')

    # Now process the min and max values

    # First check if both assignments are IDENTICAL
    if (($elfArange[0] -eq $elfBrange[0]) -and ($elfArange[1] -eq $elfBrange[1])){
        $hitCounter++
        $hit = $true
        Show-Details -text ("HIT " + $hitCounter + "! Identical assignments: " + $line) -color Blue
    }
    else {
        if ([int]$elfArange[0] -in ([int]$elfBrange[0]..[int]$elfBrange[1])) {
            # min A is within the range of B
            $hitCounter++
            $hit = $true
            Show-Details -text ("HIT " + $hitCounter + "! Min A is in range of B: $line") -color Green
        }
        else {
            if ([int]$elfArange[1] -in ([int]$elfBrange[0]..[int]$elfBrange[1])) {
                # max A is within the range of B
                $hitCounter++
                $hit = $true
                Show-Details -text ("HIT " + $hitCounter + "! Max A is in range of B: $line") -color Green
            }
            else {
                if ([int]$elfBrange[0] -in ([int]$elfArange[0]..[int]$elfArange[1])) {
                    # min B is within the range of A
                    $hitCounter++
                    $hit = $true
                    Show-Details -text ("HIT " + $hitCounter + "! Min B is in range of A: $line") -color Magenta
                }
                else {
                    if ([int]$elfBrange[1] -in ([int]$elfArange[0]..[int]$elfArange[1])) {
                        # max B is within the range of A
                        $hitCounter++
                        $hit = $true
                        Show-Details -text ("HIT " + $hitCounter + "! Max A is in range of B: $line") -color Magenta
                    }
                }
            }
        }
    }

    if (-not $hit) {
        Show-Details -text ("NO HIT " + $line) -color Red
    }
}

Show-Details -text ("The answer to PART II is " + $hitCounter) -color Green
