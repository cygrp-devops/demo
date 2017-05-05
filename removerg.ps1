[string]$rg = Read-Host "Which rg?"
Remove-AzureRmResourceGroup -Name $rg
Write-Output "removed rg '$rg'"