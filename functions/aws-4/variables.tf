## variables


variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}


variable "zone" {
    type = list(string)
    default = [ "us-east-1a", "us-east-1b" ] 
}


variable "subnet_number" {
    type = number
    default = 2
}

variable "private_subnet" {
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet" {
    default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}