#!/bin/bash
# ==============================================================================
# Script d'installation complète VPS - ERP Sylla (Version Aplatie)
# ==============================================================================

set -e

# Couleurs pour les logs
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}🚀 Début de l'installation du serveur ERP Sylla...${NC}"

# 1. Variables Globales
GIT_REPO="https://github.com/Le-dev-du-coin/ERP-Sylla---Solution-de-Gestion-Int-gr-e-pour-Quincaillerie-Moderne.git" 
DOMAIN="erpsyllamadjou.com"
SERVER_IP=$(curl -s ifconfig.me)
DB_NAME="erp_sylla"
DB_USER="sylla_admin"
DB_PASS="Sylla.ERP@2026" 
USER_ACCOUNT="syll-admin"
SYSTEM_PASS="SyllaERP@2026@" 
USER_HOME="/home/$USER_ACCOUNT"

# Tout est à la racine maintenant
PROJECT_DIR="/var/www/erp_sylla"

echo -e "\n${GREEN}[1/8] Mise à jour du système Ubuntu...${NC}"
sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y curl wget git build-essential \
    libpq-dev python3.12-venv python3.12-dev \
    nginx postgresql postgresql-contrib redis-server supervisor \
    pkg-config libcairo2-dev libpango1.0-dev libffi-dev zlib1g-dev

echo -e "\n${GREEN}[1.5/8] Création de l'utilisateur dédié...${NC}"
if ! id "$USER_ACCOUNT" &>/dev/null; then
    sudo useradd -m -s /bin/bash "$USER_ACCOUNT"
    echo "$USER_ACCOUNT:$SYSTEM_PASS" | sudo chpasswd
    sudo usermod -aG sudo "$USER_ACCOUNT"
    sudo usermod -aG www-data "$USER_ACCOUNT"
fi

echo -e "\n${GREEN}[2/8] Configuration PostgreSQL...${NC}"
sudo -u postgres psql -c "SELECT 1 FROM pg_roles WHERE rolname='$DB_USER'" | grep -q 1 || sudo -u postgres psql -c "CREATE USER $DB_USER WITH PASSWORD '$DB_PASS';"
sudo -u postgres psql -c "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'" | grep -q 1 || sudo -u postgres psql -c "CREATE DATABASE $DB_NAME OWNER $DB_USER;"

echo -e "\n${GREEN}[3/8] Installation de Node.js...${NC}"
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs
fi

echo -e "\n${GREEN}[4/8] Installation de Poetry...${NC}"
sudo -i -u $USER_ACCOUNT bash -c 'curl -sSL https://install.python-poetry.org | python3 -'

echo -e "\n${GREEN}[5/8] Clonage du Projet...${NC}"
sudo mkdir -p $PROJECT_DIR
sudo chown $USER_ACCOUNT:www-data $PROJECT_DIR
if [ ! -d "$PROJECT_DIR/.git" ]; then
    sudo -u $USER_ACCOUNT git clone $GIT_REPO $PROJECT_DIR
else
    echo -e "${YELLOW}Le projet est déjà cloné.${NC}"
fi

echo -e "\n${GREEN}[6/8] Génération des Services Systemd...${NC}"

# Gunicorn
cat << EOF | sudo tee /etc/systemd/system/gunicorn.service > /dev/null
[Unit]
Description=Gunicorn daemon pour ERP Sylla
Requires=gunicorn.socket
After=network.target

[Service]
User=$USER_ACCOUNT
Group=www-data
WorkingDirectory=$PROJECT_DIR
ExecStart=$USER_HOME/.local/bin/poetry run gunicorn \\
          --access-logfile - \\
          --workers 3 \\
          --bind unix:/run/gunicorn.sock \\
          config.wsgi:application

[Install]
WantedBy=multi-user.target
EOF

cat << EOF | sudo tee /etc/systemd/system/gunicorn.socket > /dev/null
[Unit]
Description=gunicorn socket
[Socket]
ListenStream=/run/gunicorn.sock
[Install]
WantedBy=sockets.target
EOF

# Celery
cat << EOF | sudo tee /etc/systemd/system/celery.service > /dev/null
[Unit]
Description=Celery Service pour ERP Sylla
After=network.target

[Service]
Type=simple
User=$USER_ACCOUNT
Group=www-data
WorkingDirectory=$PROJECT_DIR
ExecStart=$USER_HOME/.local/bin/poetry run celery -A config.celery_app worker -l info
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Celery Beat
cat << EOF | sudo tee /etc/systemd/system/celerybeat.service > /dev/null
[Unit]
Description=Celery Beat Service pour ERP Sylla
After=network.target celery.service

[Service]
Type=simple
User=$USER_ACCOUNT
Group=www-data
WorkingDirectory=$PROJECT_DIR
ExecStart=$USER_HOME/.local/bin/poetry run celery -A config.celery_app beat -l info
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo mkdir -p /var/log/celery
sudo chown -R $USER_ACCOUNT:www-data /var/log/celery

echo -e "\n${GREEN}[7/8] Configuration Nginx...${NC}"
cat << EOF | sudo tee /etc/nginx/sites-available/erp_sylla > /dev/null
server {
    listen 80;
    server_name $DOMAIN $SERVER_IP;

    location = /favicon.ico { access_log off; log_not_found off; }

    location /static/ {
        alias $PROJECT_DIR/staticfiles/;
    }

    location /media/ {
        alias $PROJECT_DIR/media/;
    }

    location / {
        include proxy_params;
        proxy_pass http://unix:/run/gunicorn.sock;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/erp_sylla /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

echo -e "\n${GREEN}[8/8] Démarrage des Services...${NC}"
sudo systemctl daemon-reload
sudo systemctl enable gunicorn.socket
sudo systemctl start gunicorn.socket || true
sudo systemctl restart nginx

echo -e "\n${GREEN}✅ Installation Terminée !${NC}"
echo -e "Le fichier manage.py se trouve directement dans : ${GREEN}$PROJECT_DIR${NC}"
