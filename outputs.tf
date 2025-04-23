output "mongo_express_url" {
  value       = kubernetes_service.mongo_express.status[0].load_balancer[0].ingress[0].hostname
  description = "The URL of the Mongo Express service load balancer"
}
