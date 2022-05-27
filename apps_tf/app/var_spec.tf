variable "spec_amara" {
default = {
cnt = 1
cnt0 = 1
cnt1 = 1
cnt2 = 0
type = "t2.micro"
monitoring = true
public_ip = false
ebs_optimized = true

# DNS
ttl = 120

# Root EBS
ebs0_delete = true # boolean
ebs0_iops = 0 # num
ebs0_size = 10 # num (GB)
ebs0_type = "standard" # num (GB)

# Deploy
manifest_version = "v0_0_1"
manifest_type = "amara"
}
} 

variable "spec_asg" {
  default = {
    hosttype      = "amara"
    cnt_min       = 1
    cnt_max       = 1
    type          = "t2.micro"
    monitoring    = true
    public_ip     = false
    ebs_optimized = false
    # DNS
    ttl = 120
    # Root EBS
    ebs0_delete = true       # boolean
    ebs0_iops   = 0          # num
    ebs0_size   = 10         # num (GB)
    ebs0_type   = "gp2" # num (GB)
    # Secondary EBS
    ebs1_delete = true # boolean
    ebs1_device = "/dev/xvdb"
    ebs1_iops   = 0          # num
    ebs1_size   = 4         # num (GB)
    ebs1_type   = "standard" # num (GB)
    # User Data
    manifest_type    = "amara"
    manifest_version = "v0_0_1"
  }
}

# 
variable "speclb_euronics" {
  default = {
    # LB
    albname  = "euronics"
    internal = false
    # LB Health
    idle_timeout = 60
    # Public Connections
    enable_http  = true
    enable_https = true
    # Target Group 
    deregistration_delay = 300 # default 300 seconds
    nodes = 0
    port                 = 443
    protocol             = "HTTP"
    stickiness           = 86400 # default 86400 seconds
    sticky               = false
    # Target Group Health
    interval            = 30        # Default 30 sec
    path                = "/index.html" # path to target
    health_port         = 443     # 
    health_protocol     = "HTTP"    # Default is HTTP
    timeout             = 25        # Default 5 sec
    healthy_threshold   = 2         # Default 3 sec
    unhealthy_threshold = 2         # Default 3 sec
    matcher             = "200"     # Must specifiy a return code. Multiples can be designated with list "200,202" or range "200-209"
    # LB Logging
    logging = true
  }
}