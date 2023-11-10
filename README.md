# explore-docker
ASP.NET Core applications which can be deployed as Linux containers

https://learn.microsoft.com/en-us/dotnet/architecture/containerized-lifecycle/design-develop-containerized-apps/build-aspnet-core-applications-linux-containers-aks-kubernetes

https://github.com/dotnet-architecture/explore-docker

## Debug settings

Debug | Any CPU  
docker-compose  
Debug  

WebApp  
http://localhost:5001/  
WebApi  
http://localhost:5000/weatherforecast  
WebApi Swagger  
https://localhost:5000/swagger/index.html


## To Deploy

Remember to automatize:
- remove from `launchSettings.json` the key `"ASPNETCORE_ENVIRONMENT": "Development"` of both WebApp and WebApi

## To Dockerize and push image




## K8s settings

To deploy application

~~~
kubectl deploy -f deploy-webapi
kubectl deploy -f deploy-webapp
~~~

For minikube

~~~
minikube service webapp
~~~


# Terraform References

:: [Deploy Kubernetes Resources in Minikube cluster using Terraform](https://dev.to/chefgs/deploy-kubernetes-resources-in-minikube-cluster-using-terraform-1p8o)
:: [K8s secret](https://stackoverflow.com/questions/62137632/create-kubernetes-secret-for-docker-registry-terraform)

To deploy application

~~~
terraform plan -var-file .\environment-dev.tfvars
terraform apply -var-file .\environment-dev.tfvars
~~~

To destroy all
~~~
terraform destroy -var-file .\environment-dev.tfvars
~~~

