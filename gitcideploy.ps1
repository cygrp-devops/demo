Get-AzureRmSubscription –SubscriptionName "Taha Visual Studio Enterprise" | Select-AzureRmSubscription

$gitrepo="https://github.com/cygrp-devops/demo.git"
$gittoken="6a6055338031b0811402987abdf54ec081057691"
$webappname="tahaWebApplication1"
$location="SouthCentralUS"

# Create a resource group.
New-AzureRmResourceGroup -Name demo-rg -Location $location

# Create an App Service plan in Free tier.
New-AzureRmAppServicePlan -Name $webappname -Location $location `
-ResourceGroupName demo-rg -Tier Free

# Create a web app.
New-AzureRmWebApp -Name $webappname -Location $location -AppServicePlan $webappname `
-ResourceGroupName demo-rg

# SET GitHub
$PropertiesObject = @{
	token = $token;
}
Set-AzureRmResource -PropertyObject $PropertiesObject `
-ResourceId /providers/Microsoft.Web/sourcecontrols/GitHub -ApiVersion 2015-08-01 -Force

# Configure GitHub deployment from your GitHub repo and deploy once.
$PropertiesObject = @{
    repoUrl = "$gitrepo";
    branch = "master";
}
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGroupName demo-rg `
-ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName $webappname/web `
-ApiVersion 2015-08-01 -Force