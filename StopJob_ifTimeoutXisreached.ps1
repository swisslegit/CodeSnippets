$MyJob = Start-Job -ScriptBlock {Get-Process -Name *Power*}
 
$timeout = 30
$EndTime = (Get-Date).AddMinutes($timeout)
#(New-TimeSpan -Start (Get-Date) -End $EndTime).Minutes

$jobStatus = Get-Job -Name $MyJob

While (($jobStatus.State -ne "Completed") -and ((New-TimeSpan -Start (Get-Date) -End $EndTime).Minutes -gt 0))
{
     Write-Host "Waiting for job to finish..."
     Start-Sleep -Seconds 30
     $jobStatus = Get-Job -Name $MyJob
}

if ($jobStatus.State -ne "Completed")
{

    "Fehler"
    Get-Job -Name $MyJob | Stop-Job

}
else 
{

    "Success"

    Receive-Job -Name  $MyJob                      # Get Jobresults
    Get-Job  -Name  $MyJob | Remove-Job            # Unless you need the output of these script then use receive-job first
        
}