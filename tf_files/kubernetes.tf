
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
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_service" "kanban-lb" {
  metadata {
    name = "kanban-lb"
  }
  spec {
    selector = {
      app = kubernetes_deployment.rock-deploy.spec.0.template.0.metadata.0.labels.app
    }
    #external_traffic_policy = "Local"
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }

}



/*
# Create a local variable for the load balancer name.
locals {
  lb_name = split("-", split(".", kubernetes_service.kanban-lb.status.0.load_balancer.0.ingress.0.hostname).0).0
}

# Read information about the load balancer using the AWS provider.
data "aws_elb" "rock-elb" {
  name = local.lb_name
}*/

