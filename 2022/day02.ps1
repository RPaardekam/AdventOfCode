# AdventofCode 2022 - Day 02
# Answers: 10994 and 12526

# region Include required files
$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

try {
    . ("$ScriptDirectory\..\shared\functions.ps1")
}
catch {
    Write-Error "Error while loading supporting PowerShell Scripts" 
}
#endregion

Show-Header -year 2022 -day "02"

$inputLines = Get-Content -Path $PSScriptRoot\input\day02.txt

if ($inputLines -ne $null) {
    Show-Details -text "Input read successfully" -color Yellow
}
else {
    Show-Details -text "Input could not be read" -color DarkYellow
} 

enum AnswerTypes {
    rock = 1
    paper = 2
    sciccors = 3
}

class Game {
    [string]$AnswerLetterPlayerOne
    [string]$AnswerLetterPlayerTwo
    [AnswerTypes]$AnswerPlayerOne
    [AnswerTypes]$AnswerPlayerTwo
    [int16]$ScorePlayerOne
    [int16]$ScorePlayerTwo
    [int16]$SecondScorePlayerOne
    [int16]$SecondScorePlayerTwo
    [int16]$Winner
    [int16]$WinnerTwo
}

Function translatePlay {
    param (
        $theGivenGesture
    )

    if (($theGivenGesture -eq "A") -or ($theGivenGesture -eq "X")) { [AnswerTypes]::rock }
    if (($theGivenGesture -eq "B") -or ($theGivenGesture -eq "Y")) { [AnswerTypes]::paper }
    if (($theGivenGesture -eq "C") -or ($theGivenGesture -eq "Z")) { [AnswerTypes]::sciccors }
}

Function playGame {
    param (
        [AnswerTypes]$throwPlayerOne,
        [AnswerTypes]$throwPlayerTwo
    )

    if ($throwPlayerOne -eq [AnswerTypes]::rock) {
        if ($throwPlayerTwo -eq [AnswerTypes]::sciccors) {
            return 1
        }
        if ($throwPlayerTwo -eq [AnswerTypes]::paper) {
            return 2
        }
    }
    if ($throwPlayerOne -eq [AnswerTypes]::paper) {
        if ($throwPlayerTwo -eq [AnswerTypes]::rock) {
            return 1
        }
        if ($throwPlayerTwo -eq [AnswerTypes]::sciccors) {
            return 2
        }
    }
    if ($throwPlayerOne -eq [AnswerTypes]::sciccors) {
        if ($throwPlayerTwo -eq [AnswerTypes]::paper) {
            return 1
        }
        if ($throwPlayerTwo -eq [AnswerTypes]::rock) {
            return 2
        }
    }
    return 0
}

# The next few functions are only used in PART II of the puzzle.

Function playGameTwo {
    param (
        [AnswerTypes]$throwPlayerOne,
        [string]$letterPlayerTwo
    )

    if ($letterPlayerTwo -eq "X") {
        # Player 2 needs to lose
        if ($throwPlayerOne -eq [AnswerTypes]::rock) {
            return [AnswerTypes]::sciccors
        }
        if ($throwPlayerOne -eq [AnswerTypes]::paper) {
            return [AnswerTypes]::rock
        }
        if ($throwPlayerOne -eq [AnswerTypes]::sciccors) {
            return [AnswerTypes]::paper
        }
    }

    if ($letterPlayerTwo -eq "Y") {
        # Player 2 needs to draw
        return $throwPlayerOne
    }

    if ($letterPlayerTwo -eq "Z") {
        # Player 2 needs to win
        if ($throwPlayerOne -eq [AnswerTypes]::rock) {
            return [AnswerTypes]::paper
        }
        if ($throwPlayerOne -eq [AnswerTypes]::paper) {
            return [AnswerTypes]::sciccors
        }
        if ($throwPlayerOne -eq [AnswerTypes]::sciccors) {
            return [AnswerTypes]::rock
        }
    }
}

# Set players and scores
$answerOpponent = $null
$answerMe = $null
$scoreOpponent = 0
$scoreMe = 0
$scoreMeTwo = 0

ForEach ($line in $inputLines)
{
    if (($line -ne $null) -and ($line -ne '')) {
        # We have content from the line

        $thisGame = [Game]::new()
        $thisGame.AnswerLetterPlayerOne = $line.split(' ')[0]
        $thisGame.AnswerLetterPlayerTwo = $line.split(' ')[1]
        $thisGame.AnswerPlayerOne = translatePlay -theGivenGesture $line.split(' ')[0]
        $thisGame.AnswerPlayerTwo = translatePlay -theGivenGesture $line.split(' ')[1]
        $thisGame.Winner = (playGame -throwPlayerOne $thisGame.AnswerPlayerOne -throwPlayerTwo $thisGame.AnswerPlayerTwo)

        if ($thisGame.Winner -eq 0) 
        {
            $thisGame.ScorePlayerOne = 3
            $thisGame.ScorePlayerTwo = 3
        }

        if ($thisGame.Winner -eq 1) 
        {
            $thisGame.ScorePlayerOne = 6
            $thisGame.ScorePlayerTwo = 0
        }

        if ($thisGame.Winner -eq 2) 
        {
            $thisGame.ScorePlayerOne = 0
            $thisGame.ScorePlayerTwo = 6
        }

        $thisGame.ScorePlayerOne = $thisGame.ScorePlayerOne + [int]$thisGame.AnswerPlayerOne
        $thisGame.ScorePlayerTwo = $thisGame.ScorePlayerTwo + [int]$thisGame.AnswerPlayerTwo

        $scoreOpponent = $scoreOpponent + $thisGame.ScorePlayerOne
        $scoreMe = $scoreMe + $thisGame.ScorePlayerTwo

        Show-Details -text ("PART I - Opponent " + $thisGame.AnswerLetterPlayerOne + " (" + $thisGame.AnswerPlayerOne + "), me " + $thisGame.AnswerLetterPlayerTwo + " (" + $thisGame.AnswerPlayerTwo + "). Winner: " + $thisGame.Winner + ", score1 " + $thisGame.ScorePlayerOne + ", score2 " + $thisGame.ScorePlayerTwo) -color Yellow

        # Everything below is intended for PART II of this puzzle.
        $thisGame.AnswerPlayerTwo = (playGameTwo -throwPlayerOne $thisGame.AnswerPlayerOne -letterPlayerTwo $thisGame.AnswerLetterPlayerTwo)
        $thisGame.WinnerTwo = (playGame -throwPlayerOne $thisGame.AnswerPlayerOne -throwPlayerTwo $thisGame.AnswerPlayerTwo)

        if ($thisGame.WinnerTwo -eq 0) 
        {
            $thisGame.SecondScorePlayerOne = 3
            $thisGame.SecondScorePlayerTwo = 3
        }

        if ($thisGame.SecondWinnerTwo -eq 1) 
        {
            $thisGame.SecondScorePlayerOne = 6
            $thisGame.SecondScorePlayerTwo = 0
        }

        if ($thisGame.WinnerTwo -eq 2) 
        {
            $thisGame.SecondScorePlayerOne = 0
            $thisGame.SecondScorePlayerTwo = 6
        }

        $thisGame.SecondScorePlayerOne = $thisGame.SecondScorePlayerOne + [int]$thisGame.AnswerPlayerOne
        $thisGame.SecondScorePlayerTwo = $thisGame.SecondScorePlayerTwo + [int]$thisGame.AnswerPlayerTwo
        
        $scoreMeTwo = $scoreMeTwo + $thisGame.SecondScorePlayerTwo

        Show-Details -text ("PART II - Me " + $thisGame.SecondScorePlayerTwo) -color Yellow
    }
}

Show-Details -text " " -color White
Show-Details -text ("The answer to PART I is " + $scoreMe) -color Green
Show-Details -text ("The answer to PART II is " + $scoreMeTwo) -color Green

