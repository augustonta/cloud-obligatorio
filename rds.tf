##Def DB
resource "aws_db_subnet_group" "subnet_db" {
 name       = "subnet_db_obl"
 subnet_ids = [aws_subnet.subnet_public_1.id, aws_subnet.subnet_public_2.id]
 tags = {
   Name = "subnet myql"
 }
}
##Aws DB
resource "aws_db_instance" "mysqlecomme" {
  identifier = "mysqlecomme"
  allocated_storage    = 10
  max_allocated_storage    = 15
  engine               = "mysql"
  engine_version       = "5.7.17"
  instance_class       = "db.t2.micro"
  name                 = "ecome"
  username             = "admin"
  password             = "adminadmin"
 # maintenance_window   = "Fri:03:00-Fri:03:30"
  backup_window        = "05:00-06:00"
  backup_retention_period = 7
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.subnet_db.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
  Name = "mysql_ecomme"
}
}


###Backup RDS
resource "aws_db_snapshot" "BackupRDS" {
  db_instance_identifier = aws_db_instance.mysqlecomme.id
  db_snapshot_identifier = "BackupRDS"
}