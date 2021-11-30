###ssh servidor backup
resource "aws_security_group" "allow_ssh" {
  name        = "ssh-sg"
  description = "Allow ssh"
  vpc_id      = aws_vpc.ecomme-ae-mh.id

  ingress = [
    {
      description      = "Allow ssh from any"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "egress any"
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = {
    Name = "allow_ssh"
  }
}

##############################load balancer##############################

resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "load-balancer-sg"
  vpc_id      = aws_vpc.ecomme-ae-mh.id

  ingress = [
    {
      description      = "Allow http"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "egress any"
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = {
    Name = "allow_http"
  }
}

####################para task ecs######################################

resource "aws_security_group" "app_80" {
  name        = "app_80"
  description = "app_80"
  vpc_id      = aws_vpc.ecomme-ae-mh.id

  ingress = [
    {
      description      = "app_80"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [aws_security_group.lb_sg.id]
      self             = false
    }
  ]

  egress = [
    {
      description      = "egress any"
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = {
    Name = "allow_http"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "rds-sg"
  vpc_id      = aws_vpc.ecomme-ae-mh.id

  ingress = [
    {
      security_groups = [aws_security_group.app_80.id]
      description      = "Allow rds"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
     }
  ]

  egress = [
    {
      description      = "egress any"
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = {
    Name = "allow_rds"
  }
}

resource "aws_security_group" "efs_sg" {
  name        = "efs_sg"
  description = "efs-sg"
  vpc_id      = aws_vpc.ecomme-ae-mh.id

  ingress = [
    {
      security_groups = [aws_security_group.app_80.id]
      description      = "Allow rds"
      from_port        = 2049
      to_port          = 2049
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/16"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "egress any"
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  tags = {
    Name = "allow_efs"
  }
}
