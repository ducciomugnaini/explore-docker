resource "kubernetes_deployment" "explore-docker-webapp-deploy" {
  metadata {
    name      = "webapp"
    namespace = kubernetes_namespace.explore-docker-namespace.metadata[0].name
    labels    = {
      app = "weather-forecast"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        service = "webapp"
      }
    }
    template {
      metadata {
        labels = {
          test = "weather-forecast"
          service = "webapp"
        }
      }
      spec {
        container {
          name  = "webapp"
          image = "exploredockerducciomugnaini.azurecr.io/webapp:v3"
          image_pull_policy = "IfNotPresent"
          port {
            protocol = "TCP"
            container_port = 80
          }
          env {
            name = "ASPNETCORE_URLS"
            value = "http://+:80"            
          }
          env {
            name = "WebApiBaseAddress"
            value = "http://webapi"
          }
          env {
            name = "HelloFrontendPhrase"
            value = "HELLO_FRONTEND_PHRASE"
          }
        }
        image_pull_secrets {
          name = kubernetes_secret.explore-docker-acr-secret.metadata[0].name
        }
      }
    }
  }
}

resource "kubernetes_service" "explore-docker-webapp-service" {
  metadata {
    name = "webapp"
    namespace = kubernetes_namespace.explore-docker-namespace.metadata[0].name
    labels = {
      app = "weather-forecast"
      service = "webapp"
    }
  }
  spec {
    type = "LoadBalancer"
    port {
      port = 80
      target_port = 80
      protocol = "TCP"
    }
    selector = {
      service = "webapp"
    }
  }
}