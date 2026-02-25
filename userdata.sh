#!/bin/bash

yum update -y

# ----------------------------
# Install Docker
# ----------------------------
yum install -y docker
systemctl start docker
systemctl enable docker

docker run -d -p 8080:5678 --name namaste \
  hashicorp/http-echo \
  -text="${print1}"

# ----------------------------
# Install NGINX
# ----------------------------
yum install -y nginx
systemctl start nginx
systemctl enable nginx

rm -f /etc/nginx/conf.d/default.conf

cat <<EOF > /etc/nginx/conf.d/app.conf

# Instance domain HTTP
server {
    listen 80;
    server_name ${instance_domain};

    location / {
        default_type text/plain;
        return 200 "${print2}";
    }
}

# Docker domain HTTP
server {
    listen 80;
    server_name ${docker_domain};

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
server {
    listen 80;
    server_name ec2-alb-instance.${domain};

    location / {
        default_type text/plain;
        return 200 "${print2}";
    }
}

server {
    listen 80;
    server_name ec2-alb-docker.${domain};

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}

EOF

nginx -t
systemctl restart nginx

# ----------------------------
# Install Certbot
# ----------------------------
yum install -y certbot python3-certbot-nginx


#installl cloud watch agent for nginx logs
yum install -y amazon-cloudwatch-agent