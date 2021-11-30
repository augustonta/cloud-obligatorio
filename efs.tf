resource "aws_efs_file_system" "efs-img" {
   creation_token = "efs-img"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "false"
 tags = {
     Name = "efs-for-img"
   }
 }
 resource "aws_efs_mount_target" "efs-mt-img" {
   file_system_id  = aws_efs_file_system.efs-img.id
   subnet_id = aws_subnet.subnet_public_1.id
   security_groups = [aws_security_group.efs_sg.id]
 }
 resource "aws_efs_access_point" "efs-ap-img" {
  file_system_id = aws_efs_file_system.efs-img.id
}

resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.efs-img.id

  backup_policy {
    status = "ENABLED"
  }
}