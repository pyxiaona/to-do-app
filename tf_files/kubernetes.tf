
resource "kubernetes_deployment" "rock-deploy" {
  metadata {
    name = "rock-deploy"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "kanban-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "kanban-app"
        }
      }
      spec {
        container {
          image = "nananainfra1/kanban:v2"
          name  = "kanban-pod"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "kanban-svc" {
  metadata {
    name = "kanban-svc"
  }
  spec {
    selector = {
      app = kubernetes_deployment.rock-deploy.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port   = 30015
      port        = 3001
      target_port = 80
    }
  }
}