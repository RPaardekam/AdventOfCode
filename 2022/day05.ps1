# AdventofCode 2022 - Day 05
# Answers: 

#region start every day with this snippet
$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

try {
    . ("$ScriptDirectory\..\shared\functions.ps1")
}
catch {
    Write-Error "Error while loading supporting PowerShell Scripts" 
}

# When using the shared functions, always start by getting inputLines
$inputLines = Get-InputData -year 2022 -day 05
#endregion

class Stack {
    [int]$Number
    [System.Collections.ArrayList]$Crates
}

class Supplies {
    [Stack[]]$Stacks
}
# PART I starts here

$Supplies = [Supplies]::new()
$Supplies.Stacks = New-Object Stack[] 10


#                [B]     [L]     [S]
#        [Q] [J] [C]     [W]     [F]
#    [F] [T] [B] [D]     [P]     [P]
#    [S] [J] [Z] [T]     [B] [C] [H]
#    [L] [H] [H] [Z] [G] [Z] [G] [R]
#[R] [H] [D] [R] [F] [C] [V] [Q] [T]
#[C] [J] [M] [G] [P] [H] [N] [J] [D]
#[H] [B] [R] [S] [R] [T] [S] [R] [L]
# 1   2   3   4   5   6   7   8   9 


$Stack1 = [Stack]::new()
$Stack1.Number = 1 
$Stack1.Crates = [System.Collections.ArrayList]@("H", "C", "R")
$Supplies.Stacks[$Stack1.Number] = $Stack1

$Stack2 = [Stack]::new()
$Stack2.Number = 2 
$Stack2.Crates = [System.Collections.ArrayList]@("B", "J", "H", "L", "S", "F")
$Supplies.Stacks[$Stack2.Number] = $Stack2

$Stack3 = [Stack]::new()
$Stack3.Number = 3
$Stack3.Crates = [System.Collections.ArrayList]@("R", "M", "D", "H", "J", "T", "Q")
$Supplies.Stacks[$Stack3.Number] = $Stack3

$Stack4 = [Stack]::new()
$Stack4.Number = 4
$Stack4.Crates = [System.Collections.ArrayList]@("S", "G", "R", "H", "Z", "B", "J")
$Supplies.Stacks[$Stack4.Number] = $Stack4

$Stack5 = [Stack]::new()
$Stack5.Number = 5
$Stack5.Crates = [System.Collections.ArrayList]@("R", "P", "F", "Z", "T", "D", "C", "B")
$Supplies.Stacks[$Stack5.Number] = $Stack5

$Stack6 = [Stack]::new()
$Stack6.Number = 6
$Stack6.Crates = [System.Collections.ArrayList]@("T", "H", "C", "G")
$Supplies.Stacks[$Stack6.Number] = $Stack6

$Stack7 = [Stack]::new()
$Stack7.Number = 7
$Stack7.Crates = [System.Collections.ArrayList]@("S", "N", "V", "Z", "B", "P", "W", "L")
$Supplies.Stacks[$Stack7.Number] = $Stack7

$Stack8 = [Stack]::new()
$Stack8.Number = 8
$Stack8.Crates = [System.Collections.ArrayList]@("R", "J", "Q", "G", "C")
$Supplies.Stacks[$Stack8.Number] = $Stack8

$Stack9 = [Stack]::new()
$Stack9.Number = 9
$Stack9.Crates = [System.Collections.ArrayList]@("L", "D", "T", "R", "H", "P", "F", "S")
$Supplies.Stacks[$Stack9.Number] = $Stack9

Write-Host $Supplies.Stacks | Out-GridView

$lineCounter = 0
ForEach ($line in $inputLines)
{
    # Lets skip the first 10 lines, we manually created our objects.
    if ($lineCounter -gt 9)
    {
        # Each line contains some info about the crate-move
        $instructionLineAsArray = $line.Split(' ')
        $actionAmount = $instructionLineAsArray[1]
        $actionFrom = $instructionLineAsArray[3]
        $actionTo= $instructionLineAsArray[5]

        # Actions on crates.
        if ($actionFrom -ne $null)
        {
            for($i=1;$i -le $actionAmount; $i++) {
                Write-Host "$i van stapel $actionFrom naar stapel $actionTo"
                # Find the right crate to move 
                $topCrate = $Supplies.Stacks[$actionFrom].Crates[$Supplies.Stacks[$actionFrom].Crates.Length]

                # Put the crate "top-from-stack" on the "top-to-stack"
                $Supplies.Stacks[$actionTo].Crates.Add($topCrate)

                # Remove the original crate from the top of the "from-stack"
                $Supplies.Stacks[$actionFrom].Crates.Remove($Supplies.Stacks[$actionFrom].Crates.Length)

                Write-Host "done $topCrate was removed "
                Write-Host 'new from-upper ' + $Supplies.Stacks[$actionFrom].Crates.Length
            }
        }
    }
    $lineCounter++
}