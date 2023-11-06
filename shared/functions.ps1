Function Show-Header {
	param (
        $year,
        $day
    )

    Write-Host "##############################################"
    Write-Host ("# AdventOfCode {0} day {1} - Robin Paardekam #" -f ($year, $day))
    Write-Host "##############################################"

}


Function Show-Details {
    param (
        $text,
        $color 
    )

    Write-Host $text -ForegroundColor $color
}