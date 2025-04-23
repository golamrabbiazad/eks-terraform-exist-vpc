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
            value = "172.31.19.52"
          }

          env {
            name  = "ME_CONFIG_MONGODB_PORT"
            value = "27017"
          }

          env {
            name  = "ME_CONFIG_MONGODB_ADMINUSERNAME"
            value = "admin"
          }

          env {
            name  = "ME_CONFIG_MONGODB_ADMINPASSWORD"
            value = "6181Mongodb!"
          }

          env {
            name  = "ME_CONFIG_MONGODB_AUTH_DATABASE"
            value = "admin"
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
      port        = 8081
      target_port = 8081
    }

    type = "LoadBalancer"
  }
}
