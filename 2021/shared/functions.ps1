Function Show-Header {
    Param (
        $year, $day
    )

    Write-Output "####################################################################"
    Write-Output "#                Advent of Code - Year $year - Day $day               #"
    Write-Output "####################################################################"

}

Function Show-Details {
    Param (
        [string]$text, $color
    )

    $length = ("####################################################################".Length)-4
    $paddedText = $text.Trim().PadRight($length, ' ')

    Write-Host "# $paddedText #" -ForegroundColor $color

}