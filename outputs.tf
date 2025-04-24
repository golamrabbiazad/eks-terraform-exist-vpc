output "mongo_express_url" {
  value       = kubernetes_service.mongo_express.status[0].load_balancer[0].ingress[0].hostname
  description = "The URL of the Mongo Express service load balancer"
}

output "wiz_node_app_url" {
  value       = kubernetes_service.wiz_node_app_service.status[0].load_balancer[0].ingress[0].hostname
  description = "The URL of the wiz node.js mongo authentication app service load balancer"
}
