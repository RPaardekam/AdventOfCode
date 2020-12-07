# AdventofCode 2020 - Day 2
# Answers: 636 & 

$passwords = Get-Content -Path E:\source\github\RPaardekam\AdventOfCode\2020\input\2020-day02-input.txt
$validcounter = 0

ForEach ($passwordline in $passwords) {
    $policy = $passwordline.split(':')[0].Trim()
    $thepass = $passwordline.split(':')[1].Trim()

    $validplus = VerifyPolicyIsValid $policy $thepass
    Write-Host $validplus

    $validcounter = $validcounter + $validplus
}

write-host $validcounter

Function VerifyPolicyIsValid {
 param (
    $inputpolicy,
    $inputpass
 )

 $policymin = $inputpolicy.Split('-')[0] 
 $policymax = $inputpolicy.Split('-')[1].Split(' ')[0] 
 $policylet = $inputpolicy.Split(' ')[1] 

 write-host $policymin $policymax, $policylet 

 $charCountInPass = ($inputpass.ToCharArray() | Where-Object {$_ -eq $policylet} | Measure-Object).Count

 write-host "char $charCountInPass"


 if (([int]$charCountInPass -ge [int]$policymin) -and ([int]$charCountInPass -le [int]$policymax)) {
    return 1
 }
 else {
    return 0
 }
}