#!/bin/bash

sudo yum install mysql -y && yum install git -y
sudo git clone https://github.com/augustonta/dump-rds.git
mysql -u admin -p -h $1 ecome
