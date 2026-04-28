#!/bin/bash

# ==============================================================================
# Script de déploiement (Mise à jour) - ERP Sylla (Version Aplatie)
# ==============================================================================
# PRÉREQUIS : Faire le 'git pull' manuellement avant de lancer ce script.
# Usage : ./Resources/deploy.sh
# ==============================================================================

set -e

# Couleurs pour les messages
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🚀 Démarrage du processus de mise à jour...${NC}"

# On travaille directement à la racine /var/www/erp_sylla
echo -e "📂 Dossier de travail : $(pwd)"

# 1. Installation des dépendances
echo -e "\n${CYAN}📦 Mise à jour des dépendances avec Poetry...${NC}"
poetry install --only main
echo -e "${GREEN}✅ Dépendances à jour !${NC}"

# 2. Application des migrations
echo -e "\n${CYAN}🗄️ Migration de la base de données...${NC}"
poetry run python manage.py migrate --no-input
echo -e "${GREEN}✅ Base de données à jour !${NC}"

# 3. Collecte des fichiers statiques
echo -e "\n${CYAN}🎨 Collecte des fichiers statiques...${NC}"
poetry run python manage.py collectstatic --no-input
echo -e "${GREEN}✅ Fichiers statiques collectés !${NC}"

# 4. Redémarrage des services
echo -e "\n${CYAN}♻️ Redémarrage des services systemd...${NC}"
sudo systemctl restart gunicorn
sudo systemctl restart celery
sudo systemctl restart celerybeat
echo -e "${GREEN}✅ Services redémarrés avec succès !${NC}"

echo -e "\n${GREEN}====================================================${NC}"
echo -e "${GREEN}✨ DÉPLOIEMENT TERMINÉ AVEC SUCCÈS ! ✨${NC}"
echo -e "${GREEN}====================================================${NC}"
