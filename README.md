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
