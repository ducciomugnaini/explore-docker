# Replaced by terraform configuration with data template

kubectl create secret docker-registry mugna-secret-acr-login `
    --docker-server=ACR-LOGIN-SERVER `
    --docker-username=AZ-ACR-USERNAME `
    --docker-password=AZ-ACR-PASSWORD `
    --namespace=K8S-NAMESPACE