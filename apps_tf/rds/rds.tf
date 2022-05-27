 resource "aws_db_instance" "rds" {
  # Name of instance
  identifier = join("-", [var.loc["group"], var.specrds_rds["name"]])

  # Storage Specs
  allocated_storage     = var.specrds_rds["allocated_storage"]
  storage_type          = var.specrds_rds["storage_type"]
  #iops                  = var.specrds_rds["iops"]
  storage_encrypted     = var.specrds_rds["encrypt"]
  max_allocated_storage = var.specrds_rds["max_allocated_storage"]

  #mssql
  engine         = var.specrds_rds["engine"]
  engine_version = var.specrds_rds["engine_version"]
  instance_class = var.specrds_rds["Instance_class"]
  username       = var.specrds_rds["user"]
  password       = var.specrds_rds["pass"]
  license_model  = var.specrds_rds["license_model"]

  backup_retention_period = var.specrds_rds["backup_retention"]
  maintenance_window      = var.specrds_rds["maint_window"]
  deletion_protection     = true

  db_subnet_group_name = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [ aws_security_group.data.id]

  #parameter_group_name = aws_db_parameter_group.rds.id
  option_group_name    = aws_db_option_group.rds.id
  #monitoring_interval  = 60 # setting it to 0 will disable enhanced monitoring
  #monitoring_role_arn  = data.aws_iam_role.rds-monitoring.arn

  multi_az                     = false
  auto_minor_version_upgrade   = false
  copy_tags_to_snapshot        = true
  final_snapshot_identifier    = join("-", [var.specrds_rds["name"], "final"])
  skip_final_snapshot          = false
  performance_insights_enabled = false

  tags = {
    Name          = join("-", [var.loc["group"], var.specrds_rds["name"]])
    CreatedWith   = join(":", ["TF", var.loc["path"]])
    Group         = var.loc["group"]
    Deployment    = var.loc["deploy"]
    Expires       = var.loc["expire"]
    owner         = var.loc["owner"]
    Documentation = var.loc["url"]
    Product       = var.loc["product"]
    Environment   = var.loc["environment"]
   # Sitestatus    = var.loc["sitestatus"]
  }
}

  resource "aws_db_subnet_group" "rds" {
  name       = join("-", ["sng", var.specrds_rds["name"], var.loc["id"]])
  subnet_ids = data.aws_subnet.data.*.id
}

resource "aws_db_option_group" "rds" {
  name                     = join("-", ["og", var.specrds_rds["name"], var.loc["id"]])
  option_group_description = "${var.loc["group"]}-${var.specrds_rds["name"]} Option Group"
  engine_name              = var.specrds_rds["engine"]
  major_engine_version     = var.specrds_rds["major_engine_version"]
}

/*resource "aws_db_parameter_group" "rds" {
  name   = join("-", ["pg", var.specrds_rds["name"], var.loc["id"]])
  family = "mssql${var.specrds_rds["major_engine_version"]}"

  # character_set_client = utf8mb4
  }*/
