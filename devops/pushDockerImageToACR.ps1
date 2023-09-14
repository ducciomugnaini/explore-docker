
Function Push-Image-To-ACR($ResourceGroupName, $DockerImageName, $ImageTagVersion){    
    try
    {
        Write-Output "Pushing to $ResourceGroupName $DockerImageName $ImageTagVersion"        
        Write-Output "ErrorActionPreference is: $ErrorActionPreference" 

        #$acrName = (az acr list --resource-group $ResourceGroupName --query "[].{acrLoginServer:loginServer}" | convertfrom-json).acrLoginServer

        $acr = (az acr list --resource-group $ResourceGroupName | convertfrom-json)[0]
        $acrLoginServer = $acr.loginServer
        $acrName = $acr.name
        
        $localTag = "${DockerImageName}:latest"
        $remoteTag = "${acrLoginServer}/${DockerImageName}:${ImageTagVersion}"
        Write-Output "Image Tags: $localTag $remoteTag"

        #docker tag "${DockerImageName}:latest" "${acrLoginServer}/${DockerImageName}:${ImageTagVersion}"
        docker tag $localTag $remoteTag
        if ($LASTEXITCODE -ne 0) {
            #Send error details to Slack
            Write-Output "An error occurred during docker tag"
            Exit 1
        }

        az acr login --name $acrName

        #docker push "${acrLoginServer}/${DockerImageName}:${ImageTagVersion}"
        docker push $remoteTag
        if ($LASTEXITCODE -ne 0) {
            #Send error details to Slack
            Write-Output "An error occurred during docker push"
            Exit 1
        }        
        
    } catch {
        "An error occurred that could not be resolved."
    }
}


# -----------------------------
$ErrorActionPreference = "Stop"
# -----------------------------

$ResourceGroupName = 'explore-docker-aks-rg'
$DockerImageName_webapi = 'webapi'
$DockerImageName_webapp = 'webapp'
$ImageTagVersion = 'v3'

Push-Image-To-ACR $ResourceGroupName $DockerImageName_webapi $ImageTagVersion
Push-Image-To-ACR $ResourceGroupName $DockerImageName_webapp $ImageTagVersion




