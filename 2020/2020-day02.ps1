# AdventofCode 2020 - Day 2
# Answers: 636 & 588

$passwords = Get-Content -Path E:\source\github\RPaardekam\AdventOfCode\2020\input\2020-day02-input.txt
$validcounter = 0

# Minimum and maximum supplied in the policy
Function VerifyPolicyIsValid {
 param (
    $inputpolicy,
    $inputpass
 )

 $policymin = $inputpolicy.Split('-')[0] 
 $policymax = $inputpolicy.Split('-')[1].Split(' ')[0] 
 $policylet = $inputpolicy.Split(' ')[1] 

 $charCountInPass = ($inputpass.ToCharArray() | Where-Object {$_ -eq $policylet} | Measure-Object).Count

 if (([int]$charCountInPass -ge [int]$policymin) -and ([int]$charCountInPass -le [int]$policymax)) {
    return 1
 }
 else {
    return 0
 }
}

# Position of letter must exist exactly once matching just ONE of the two numbers in the policy
Function VerifyNewPolicyIsValid {
 param (
    $inputpolicy,
    $inputpass
 )

 $policya = $inputpolicy.Split('-')[0] 
 $policyb = $inputpolicy.Split('-')[1].Split(' ')[0] 
 $policylet = $inputpolicy.Split(' ')[1] 

 $boolMatchA = ($inputpass.IndexOf($policylet, ([int]$policya)-1) -eq [int]$policya-1)
 $boolMatchB = ($inputpass.IndexOf($policylet, ([int]$policyb)-1) -eq [int]$policyb-1)

 if ((($boolMatchA) -and (-not $boolMatchB)) -or ((-not $boolMatchA) -and ($boolMatchB))) {
    #write-host "Matches letter $policylet for either $policya OR $policyb (policy $inputpolicy, password $inputpass) match results $boolMatchA and $boolMatchB"
    return 1
 }
 else {
    return 0
 }
}

# Assignment 1
ForEach ($passwordline in $passwords) {
    $policy = $passwordline.split(':')[0].Trim()
    $thepass = $passwordline.split(':')[1].Trim()

    $validplus = VerifyPolicyIsValid $policy $thepass

    $validcounter = $validcounter + $validplus
}

write-host "Assignment 1 answer: $validcounter"

# Assignment 2
$validcounter = 0
ForEach ($passwordline in $passwords) {
    $policy = $passwordline.split(':')[0].Trim()
    $thepass = $passwordline.split(':')[1].Trim()

    $validplus = VerifyNewPolicyIsValid $policy $thepass

    $validcounter = $validcounter + $validplus
}

write-host "Assignment 2 answer: $validcounter"

