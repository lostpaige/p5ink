#!/bin/bash

# Exit immediately on error
set -e

# 1. Clone the package from GitHub
if [ ! -d "/home/$USER/p5ink" ]; then
  git clone https://github.com/lostpaige/p5ink.git /home/$USER/p5ink
else
  echo "Repository already exists at /home/$USER/p5ink. Pulling latest changes."
  cd /home/$USER/p5ink
  git pull
  cd -
fi

# 2. Create virtual environment and install requirements
cd /home/$USER/p5ink

# Create photos directory if it doesn't exist
if [ ! -d "photos" ]; then
  mkdir photos
fi

if [ ! -d "venv" ]; then
  python3 -m venv venv
fi

source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
deactivate

# 3. Install systemd service

# Stop and disable any existing service
if systemctl is-active --quiet p5ink.service; then
  echo "Stopping and disabling old p5ink.service..."
  sudo systemctl stop p5ink.service
  sudo systemctl disable p5ink.service
fi

SERVICE_FILE="/etc/systemd/system/p5ink.service"

cat << EOF | sudo tee "$SERVICE_FILE" > /dev/null
[Unit]
Description=P5InkyDiffusion Service
After=network.target

[Service]
User=$USER
WorkingDirectory=/home/$USER/p5ink
ExecStart=/home/$USER/p5ink/venv/bin/python /home/$USER/p5ink/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable p5ink.service
sudo systemctl start p5ink.service

echo "Installation complete. Service p5ink.service started."