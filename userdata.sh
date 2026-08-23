#!/bin/bash

set -e

echo "===== Updating system ====="
dnf update -y

echo "===== Installing required packages ====="
dnf install -y \
    java-21-amazon-corretto \
    git \
    wget \
    unzip \
    jq \
    fontconfig

echo "===== Verifying Java ====="
    java --version

echo "===== Installing Docker ====="
dnf install -y docker

systemctl enable docker
systemctl start docker

echo "===== Verifying Docker ====="
docker --version

echo "===== Adding ec2-user to docker group ====="
usermod -aG docker ec2-user

echo "===== Installing Jenkins repository ====="

wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/rpm-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2026.key

echo "===== Installing Jenkins ====="
dnf install -y jenkins

echo "===== Adding Jenkins user to docker group ====="
usermod -aG docker jenkins

echo "===== Starting Jenkins ====="
systemctl enable jenkins
systemctl start jenkins

echo "===== Restarting Jenkins to apply Docker group ====="
systemctl restart jenkins

echo "===== Checking Jenkins ====="
systemctl status jenkins --no-pager

echo "===== Checking AWS CLI ====="
aws --version

echo "===== Installed versions ====="

echo "Java:"
java -version

echo "Git:"
git --version

echo "Docker:"
docker --version

echo "AWS CLI:"
aws --version

echo "Jenkins:"
systemctl is-active jenkins

echo "===== Jenkins Initial Admin Password ====="

if [ -f /var/lib/jenkins/secrets/initialAdminPassword ]; then
    cat /var/lib/jenkins/secrets/initialAdminPassword
else
    echo "Jenkins password file not available yet."
fi

echo "===== Setup completed ====="