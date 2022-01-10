variable "instance_type"{
    type     = string
    default  = "t2.micro"
}


variable "ami" {
 default  = "ami-0851b76e8b1bce90b "  
}

variable "key_name" {
    default = "MY-AWS-KEY.pem"
  
}