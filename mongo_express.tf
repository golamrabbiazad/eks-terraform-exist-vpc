resource "kubernetes_deployment" "mongo_express" {
  depends_on = [module.eks]

  metadata {
    name = "mongo-express"
    labels = {
      app = "mongo-express"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mongo-express"
      }
    }

    template {
      metadata {
        labels = {
          app = "mongo-express"
        }
      }

      spec {
        container {
          name  = "mongo-express"
          image = "mongo-express"

          port {
            container_port = 8081
          }

          env {
            name  = "ME_CONFIG_MONGODB_SERVER"
            value = local.mongodb_config_server
          }

          env {
            name  = "ME_CONFIG_MONGODB_PORT"
            value = local.mongodb_config_port
          }

          env {
            name  = "ME_CONFIG_MONGODB_ADMINUSERNAME"
            value = local.mongodb_config_admin_username
          }

          env {
            name  = "ME_CONFIG_MONGODB_ADMINPASSWORD"
            value = local.mongodb_config_admin_password
          }

          env {
            name  = "ME_CONFIG_MONGODB_AUTH_DATABASE"
            value = local.mongodb_config_auth_db
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mongo_express" {
  depends_on = [kubernetes_deployment.mongo_express]

  metadata {
    name = "mongo-express"
  }

  spec {
    selector = {
      app = "mongo-express"
    }

    port {
      port        = 80
      target_port = 8081
    }

    type = "LoadBalancer"
  }
}
