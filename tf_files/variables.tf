variable "region" {
  default = "us-east-1"
}

variable "rules" {
  type = list(object({
    port        = number
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["5.146.192.101/32"]
    }
  ]
}

variable "rules_nodes" {
  type = list(object({
    port        = number
    port        = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["5.146.192.101/32"]
    },
    {
      port        = 53
      protocol    = "tcp"
      cidr_blocks = ["5.146.192.101/32"]
    }
  ]
}