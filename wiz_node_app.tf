resource "kubernetes_deployment" "wiz_node_app" {
  depends_on = [module.eks]

  metadata {
    name = local.wiz_node_app_name
    labels = {
      app = local.wiz_node_app_name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.wiz_node_app_name
      }
    }

    template {
      metadata {
        labels = {
          app = local.wiz_node_app_name
        }
      }

      spec {
        container {
          name  = local.wiz_node_app_name
          image = local.wiz_node_app_docker_image

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "wiz_node_app_service" {
  depends_on = [kubernetes_deployment.wiz_node_app]

  metadata {
    name = "${local.wiz_node_app_name}-service"
  }

  spec {
    selector = {
      app = local.wiz_node_app_name
    }

    port {
      port        = 80
      target_port = 3000
      protocol    = "TCP"
    }

    type = "LoadBalancer"
  }
}

