$functions = {
    Function Huber {
        param([int]$number)

        Write-Host "Hey Marcel" -ForegroundColor Cyan
        Write-host $number -ForegroundColor Cyan
    }

    Function Huber2 {
        Write-Host "Hey Second" -ForegroundColor Cyan
    }
}

Invoke-Expression "$functions"


Start-Job -InitializationScript $functions -ArgumentList($number) -ScriptBlock {
    Huber 5
    Huber2
}  |  Wait-Job| Receive-Job

Huber 3
