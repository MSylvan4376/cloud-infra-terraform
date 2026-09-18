resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-subnet-group"
    Environment = var.environment
  }
}

resource "aws_security_group" "db_sg" {
  name        = "${var.project_name}-${var.environment}-db-sg"
  description = "DB security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL traffic from EC2 instances"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-sg"
    Environment = var.environment
  }
}

resource "aws_db_parameter_group" "this" {
  name   = "${var.project_name}-${var.environment}-mysql8"
  family = "mysql8.0"

  parameter {
    name  = "require_secure_transport"
    value = "1"
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-mysql8"
    Environment = var.environment
  }
}
resource "aws_db_instance" "this" {
  #checkov:skip=CKV_AWS_293:Deletion protection is disabled so the lab can be torn down
  #checkov:skip=CKV_AWS_157:Single-AZ deployment keeps this portfolio lab affordable
  #checkov:skip=CKV_AWS_129:CloudWatch database log exports are omitted to limit recurring lab costs
  #checkov:skip=CKV_AWS_118:Enhanced monitoring is omitted to avoid an additional monitoring role and recurring lab costs

  identifier                          = "${var.project_name}-${var.environment}-db"
  engine                              = "mysql"
  engine_version                      = "8.0"
  instance_class                      = var.db_instance_class
  allocated_storage                   = 20
  storage_encrypted                   = true
  auto_minor_version_upgrade          = true
  iam_database_authentication_enabled = true

  username                    = var.db_username
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.this.name
  parameter_group_name   = aws_db_parameter_group.this.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  publicly_accessible   = false
  copy_tags_to_snapshot = true
  skip_final_snapshot   = true
  multi_az              = false

  tags = {
    Name        = "${var.project_name}-${var.environment}-db"
    Environment = var.environment
  }
}

