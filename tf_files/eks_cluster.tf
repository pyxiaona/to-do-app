resource "aws_eks_cluster" "cluster" {
  name     = local.cluster_name
  role_arn = aws_iam_role.rock_role.arn

  vpc_config {
    #subnet_ids              = data.aws_subnets.sub_ids.ids
    subnet_ids              = ["subnet-039d7bd1c43f973cc", "subnet-0639992b937e38085"]
    endpoint_private_access = true
    endpoint_public_access  = true
    security_group_ids      = [aws_security_group.sg_cluster.id]
  }
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy
  ]
}
/*
data "aws_subnet_ids" "sub_ids" {
  vpc_id = aws_vpc.rock_vpc.id
}*/
/*
data "aws_subnets" "sub_ids" {
  filter {
    name   = "rock_vpc"
    values = [aws_vpc.rock_vpc.id]
  }
}*/

resource "aws_iam_role" "rock_role" {
  name = "eks-cluster-role-kanban-app"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.rock_role.name
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = local.cluster_name
}

