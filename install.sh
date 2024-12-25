#!/bin/bash

# Exit immediately on error
set -e

# 1. Clone the package from GitHub
if [ ! -d "/home/pi/p5ink" ]; then
  git clone https://github.com/lostpaige/p5ink.git /home/pi/p5ink
else
  echo "Repository already exists at /home/pi/p5ink. Pulling latest changes."
  cd /home/pi/p5ink
  git pull
  cd -
fi

# 2. Create virtual environment and install requirements
cd /home/pi/p5ink

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
SERVICE_FILE="/etc/systemd/system/p5ink.service"

sudo bash -c "cat > \$SERVICE_FILE" << EOF
[Unit]
Description=P5InkyDiffusion Service
After=network.target

[Service]
User=pi
WorkingDirectory=/home/pi/p5ink
ExecStart=/home/pi/p5ink/venv/bin/python /home/pi/p5ink/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable p5ink.service
sudo systemctl start p5ink.service

echo "Installation complete. Service p5ink.service started."