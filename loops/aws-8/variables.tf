## variables

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "private_subnet" {
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet" {
    default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "subnet_number" {
  type = number
  default = 2
}

variable "env" {
  type = string
  default = "prod"
  
}


variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0f387434d1dfc4cc2"
    eu-west-1 = "ami-00622de605b25a7d6"
    ap-south-1 = "ami-0f733fbd96037f20b"
  }
}

variable "REGION" {
  default = "us-east-1"
}

variable "inbound_ports" {
  type = list(number)
  default = [ 443,80,8080,10250,53 ] 
}

variable "enable_private" {
  type = bool
  default = true
}


variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}