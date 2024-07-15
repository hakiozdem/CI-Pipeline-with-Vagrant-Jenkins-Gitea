#!/bin/bash
echo "git.mypipeline.local" | sudo tee /etc/hostname
echo "127.0.0.1   git.mypipeline.local" | sudo tee -a /etc/hosts
sudo yum update -y
sudo yum install git wget sqlite -y
useradd -rms /bin/bash gitea
wget -O gitea https://dl.gitea.com/gitea/1.21.7/gitea-1.21.7-linux-amd64
sudo chmod +x gitea
sudo mv gitea /usr/local/bin
sudo mkdir -p /var/lib/gitea/{custom,data,log}
sudo mkdir /etc/gitea
sudo chmod -R 750 /var/lib/gitea
sudo chown -R gitea: /var/lib/gitea
sudo chown root:gitea /etc/gitea
sudo chmod 770 /etc/gitea
cat <<EOT>> /etc/systemd/system/gitea.service
[Unit]
Description=Gitea (Git with a cup of tea)
After=syslog.target
After=network.target

[Service]
RestartSec=2s
Type=simple
User=gitea
Group=gitea
WorkingDirectory=/var/lib/gitea/
ExecStart=/usr/local/bin/gitea web --config /etc/gitea/app.ini
Restart=always
Environment=USER=gitea HOME=/home/gitea GITEA_WORK_DIR=/var/lib/gitea

[Install]
WantedBy=multi-user.target
EOT

sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
sudo systemctl start gitea
sudo systemctl enable gitea
sudo firewall-cmd --permanent --zone=public --add-port=3000/tcp
sudo firewall-cmd --reload
reboot