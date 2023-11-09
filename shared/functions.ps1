# Read all contents of the specific txt-file for this date
Function Get-InputData {
    param (
        [string]$year,
        [string]$day
    )
    Show-Header -year $year -day $day

    $inputPath = "{0}\..\{1}\input\day{2}.txt" -f ($PSScriptRoot, $year, $day)
    $inputLines = Get-Content -Path $inputPath

    if ($inputLines -ne $null) {
        Show-Details -text "Input read successfully" -color Yellow
    }
    else {
        Show-Details -text "Input could not be read" -color DarkYellow
    }

    return $inputLines
}

# Show a header in ASCII format 
Function Show-Header {
	param (
        $year,
        $day
    )

    Write-Host "##############################################"
    Write-Host ("# AdventOfCode {0} day {1} - Robin Paardekam #" -f ($year, $day))
    Write-Host "##############################################"

}

# Output text onto the console in a color of your preference.
Function Show-Details {
    param (
        $text,
        $color 
    )

    Write-Host $text -ForegroundColor $color
}