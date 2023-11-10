variable acr-server {}
variable acr-username {}
variable acr-password {}
variable acr-auth {}

data "template_file" "docker_config_script" {
  template = "${file("${path.module}/config.json")}"
  vars = {
    acr-server = "${var.acr-server}"
    acr-username = "${var.acr-username}"
    acr-password = "${var.acr-password}"
    acr-auth = "${var.acr-auth}"
  }
}

resource "kubernetes_namespace" "explore-docker-namespace" {
  metadata {
    name = "explore-docker"
  }
}

resource "kubernetes_secret" "explore-docker-acr-secret" {
  metadata {
    name = "acr-secret"
    namespace = kubernetes_namespace.explore-docker-namespace.metadata[0].name
  }
  data = {
    ".dockerconfigjson" = "${data.template_file.docker_config_script.rendered}"
  }
  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_deployment" "explore-docker-webapi-deploy" {
  metadata {
    name      = "webapi"
    namespace = kubernetes_namespace.explore-docker-namespace.metadata[0].name
    labels    = {
      app = "weather-forecast"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        service = "webapi"
      }
    }
    template {
      metadata {
        labels = {
          test = "weather-forecast"
          service = "webapi"
        }
      }
      spec {
        container {
          name  = "webapi"
          image = "exploredockerducciomugnaini.azurecr.io/webapi:v3"
          image_pull_policy = "IfNotPresent"
          port {
            protocol = "TCP"
            container_port = 80
          }
          env {
            name = "ASPNETCORE_URLS"
            value = "http://+:80"
          }
        }
        image_pull_secrets {
          name = kubernetes_secret.explore-docker-acr-secret.metadata[0].name
        }
      }
    }
  }
}

resource "kubernetes_service" "explore-docker-webapi-service" {
  metadata {
    name = "webapi"
    namespace = kubernetes_namespace.explore-docker-namespace.metadata[0].name
    labels = {
      app = "weather-forecast"
      service = "webapi"
    }
  }
  spec {
    port {
      port = 80
      target_port = 80
      protocol = "TCP"
    }
    selector = {
      service = "webapi"
    }
  }
}