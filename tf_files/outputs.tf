output "cluster_id" {
  value = aws_eks_cluster.cluster.id
}

output "endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}
output "vpc_config" {
  value = aws_eks_cluster.cluster.vpc_config
}

output "cluster_node_id" {
  value = aws_eks_node_group.rock_node_group.id
}

output "info_resources" {
  value = aws_eks_node_group.rock_node_group.resources
}
