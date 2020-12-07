# AdventofCode 2020 - Day 1
# Answers: 1020084 & 295086480

$nummers = Get-Content -Path E:\source\github\RPaardekam\AdventOfCode\2020\input\2020-day01-input.txt | sort { [int]$_ }
$totalweneed = 2020

Function FindTotalSum {
    param (
        $left,
        $middle, 
        $right
    ) 

    # depending on the number of parameters: calculate with 2 or 3 inputs.

    if ($middle -ne $null) {
        if (([int]$left + [int]$middle + [int]$right) -eq $totalweneed) {
            Write-Host "We found it! " $left $middle $right
            Write-Host "Multiplied: " 
            Write-Host ([int]$left * [int]$middle * [int]$right)
        }
    } else {
        if (([int]$left + [int]$right) -eq $totalweneed) {
            Write-Host "We found it! " $left $right
            Write-Host "Multiplied: " 
            Write-Host ([int]$left * [int]$right)
        }
    }
}

# Assignment 1
ForEach ($singlenumber in $nummers) {
    Foreach ($othernumber in $nummers) {
        FindTotalSum -left $singlenumber -right $othernumber
    } 
} 

# Assignment 2
ForEach ($singlenumber in $nummers) {
    Foreach ($othernumber in $nummers) {
        ForEach ($lastnumber in $nummers) {
            FindTotalSum -left $singlenumber -middle $othernumber -right $lastnumber
        }
    }
} 