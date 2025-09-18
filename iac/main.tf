provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "devops" {
  ami           = "ami-08e5424edfe926b43" # Amazon Linux 2 (ap-south-1)
  instance_type = "t3.micro"
  key_name      = "demo.pem"              # replace with your EC2 key pair

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              # Install Node.js
              curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
              yum install -y nodejs git
              # Install Jenkins
              amazon-linux-extras install java-openjdk11 -y
              wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
              rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
              yum install -y jenkins
              systemctl enable jenkins && systemctl start jenkins
              # Install Prometheus
              useradd --no-create-home --shell /bin/false prometheus
              mkdir /etc/prometheus /var/lib/prometheus
              cd /tmp
              curl -LO https://github.com/prometheus/prometheus/releases/download/v2.55.1/prometheus-2.55.1.linux-amd64.tar.gz
              tar xvf prometheus-2.55.1.linux-amd64.tar.gz
              mv prometheus-2.55.1.linux-amd64/prometheus /usr/local/bin/
              mv prometheus-2.55.1.linux-amd64/promtool /usr/local/bin/
              mv prometheus-2.55.1.linux-amd64/consoles /etc/prometheus
              mv prometheus-2.55.1.linux-amd64/console_libraries /etc/prometheus
              mv prometheus-2.55.1.linux-amd64/prometheus.yml /etc/prometheus/
              chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
              cat <<EOT > /etc/systemd/system/prometheus.service
              [Unit]
              Description=Prometheus
              After=network.target

              [Service]
              User=prometheus
              ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus
              Restart=always

              [Install]
              WantedBy=multi-user.target
              EOT
              systemctl daemon-reload
              systemctl enable prometheus
              systemctl start prometheus
              EOF

  tags = {
    Name = "devops-demo"
  }
}

resource "aws_security_group" "allow" {
  name        = "allow_web"
  description = "Allow HTTP, Jenkins, Prometheus, SSH"
  vpc_id      = "default"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp" # Jenkins
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp" # Prometheus
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
