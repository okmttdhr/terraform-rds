name    = "main"
region  = "ap-northeast-1"
profile = "your-aws-profile"

az          = "ap-northeast-1a"
vpc_cidr    = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"

sg_name        = "22_pxy"
sg_description = "Permit ssh from proxy server."
sg_cidrs       = ["0.0.0.0/0"]
