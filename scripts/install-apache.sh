#!/bin/bash
# Update packages
yum update -y

# Install Apache (httpd)
yum install -y httpd

# Enable Apache at boot and start the service
systemctl enable httpd
systemctl start httpd

# Add a basic Hello World page with instance metadata
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
echo "<h1>Hello World from $INSTANCE_ID</h1>" > /var/www/html/index.html
