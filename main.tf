terraform {
  cloud {
    organization = "rajats"

    workspaces {
      name = "Terraform"
    }
  }
}

resource "aws_instance" "main"{
instance_type = "t2.micro"
ami    = "ami-0851b76e8b1bce90b"
key_name = "MY-AWS-KEY"
vpc_security_group_ids = [aws_security_group.prod-web-servers-sg.id]
root_block_device {
  volume_type = "gp2"
  volume_size = "8"
  delete_on_termination = false
}
tags = {
    Name = "Main1"
}
}

resource "aws_security_group" "prod-web-servers-sg" {
  name        = "prod-web-servers-sg"
  description = "security group for production grade web servers"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress  {
     from_port = 0
     to_port   = 0
     protocol  = "all"
     cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "RDS_Security_group"
    }
}


/*

resource "aws_instance" "main2"{
instance_type = "t2.micro"
ami    = "ami-0851b76e8b1bce90b"
key_name = "MY-AWS-KEY"
vpc_security_group_ids = [aws_security_group.prod-web-servers-sg.id]
root_block_device {
  volume_type = "gp2"
  volume_size = "8"
  delete_on_termination = false
  tags = {
      Name = "Main2"
  }
}
}




resource "aws_lb" "nlb" {
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id            = aws_instance.main.subnet_id

  }

  subnet_mapping {
    subnet_id            = aws_instance.main2.subnet_id

}
}


resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 80
  protocol          = "TCP"
  
  default_action {
    target_group_arn = aws_lb_target_group.targetgp.arn
    type             = "forward"
  }
}


output "subnet" {
value = aws_instance.main.id
}



resource "aws_lb_target_group" "targetgp" {
  vpc_id            = "vpc-09b71f7b570430c2e"
  port        = 80

  protocol    = "TCP"
  depends_on = [aws_lb.nlb]

}

resource "aws_lb_target_group_attachment" "test1" {
  target_group_arn = aws_lb_target_group.targetgp.arn
  target_id        = aws_instance.main.id
}

resource "aws_lb_target_group_attachment" "test2" {
  target_group_arn = aws_lb_target_group.targetgp.arn
  target_id        = aws_instance.main2.id
}


resource "aws_db_instance" "db_test" {
instance_class = "db.t2.micro"
identifier = "newtestdb"
username = "test"
password = "test12345"
engine   = "mysql"
skip_final_snapshot = false

publicly_accessible = true
allocated_storage = 100
vpc_security_group_ids = [aws_security_group.prod-web-servers-sg.id]
}*/
