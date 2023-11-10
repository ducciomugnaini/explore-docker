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