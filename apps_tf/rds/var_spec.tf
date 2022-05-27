/**********
Specifications
**********/

variable "specrds_rds" {
  default = {
    name                 = "ms-appsdb" # rds instance name 
   Instance_class        = "db.t3.small"
    engine               = "sqlserver-se"
    engine_version       = "15.00.4073.23.v1"
    major_engine_version = "15.00"
    user                 = "admin"
    pass                 = "Mumbai123456"
    backup_retention     = 0                     # Integer for number of days
    maint_window         = "sat:09:05-sat:10:05" # Time span in UTC> ddd:HH:MM-ddd:HH:MM
    allocated_storage    = 20
    max_allocated_storage = 25
    storage_type         = "gp2"
    encrypt              = false
    license_model         = "license-included"
    
  }
}
