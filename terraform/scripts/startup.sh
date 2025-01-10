#!/bin/bash

apt-get update -y && apt-get install -y nginx

systemctl enable nginx
systemctl start nginx

cat <<EOF > /var/www/html/index.html
<html>
  <head>
    <title>Welcome</title>
  </head>
  <body>
    <h1>Hello from Terraform Deployed Server (GCP MIG)!</h1>
  </body>
</html>
EOF
