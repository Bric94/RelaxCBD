#!/bin/bash
set -euo pipefail

###########################
# Configuration projet
###########################

# Chemin vers la racine du projet
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

# Repo Git distant
GIT_REPO="git@github.com:Bric94/RelaxCBD.git"

# Chemin vers ton binaire Composer 2 local (ou global : composer)
# On tente d'abord le phar local, sinon on tombe sur composer global
if [ -f "$PROJECT_DIR/composer.phar" ]; then
  COMPOSER="php $PROJECT_DIR/composer.phar"
else
  COMPOSER="composer"
fi

###########################
# 1) Mise à jour du code
###########################

echo "📥 Mise à jour du dépôt Git…"
if [ -d .git ]; then
  git stash push -m "deploy-temp" --keep-index || true
  git pull origin main
  git stash pop || true
else
  echo "⚠️ Pas de repo Git détecté, j'initialise…"
  git init
  git remote add origin "$GIT_REPO"
  git fetch --all
  git checkout main
fi

###########################
# 2) PHP : composer install
###########################

echo "📦 Installation des dépendances PHP (prod)…"
# --no-dev enlève les dépendances dev, --optimize-autoloader accélère l'autoload
COMPOSER_MEMORY_LIMIT=-1 $COMPOSER install --no-dev --optimize-autoloader

###########################
# 3) JS/CSS : build assets
###########################

echo "⚙️ Compilation des assets (production)…"
# selon que tu utilises npm ou yarn
if [ -f package-lock.json ]; then
  npm ci
  npm run build
elif [ -f yarn.lock ]; then
  yarn install --frozen-lockfile
  yarn encore production
else
  echo "ℹ️ Aucun lockfile JS trouvé, je passe la compilation des assets."
fi

###########################
# 4) Env Prod & cache
###########################

echo "🔧 Passage en environnement de production…"
# On s'assure que Symfony utilise APP_ENV=prod et désactive le debug
export APP_ENV=prod
export APP_DEBUG=0
export DATABASE_URL="mysql://u495628816_bric:RouckyDoja94@srv1704.hstgr.io:3306/u495628816_relax_cbd_shop?serverVersion=8.0.32&charset=utf8mb4"

echo "🗑️ Vider le cache prod…"
php bin/console cache:clear --env=prod --no-debug
php bin/console cache:warmup --env=prod --no-debug

###########################
# 5) Base de données
###########################

# On lit DATABASE_URL depuis l\'environnement (ou .env.local)
# Création de la BDD si besoin
echo "🗄️ Vérification / création de la base de données…"
if php bin/console doctrine:database:exists --env=prod; then
  echo "✅ Base existe."
else
  echo "🚀 Création de la base…"
  php bin/console doctrine:database:create --env=prod
fi

echo "🔄 Lancement des migrations…"
php bin/console doctrine:migrations:migrate --no-interaction --env=prod

###########################
# 6) Permissions & fin
###########################

echo "🔐 Ajustement des permissions cache/logs…"
# selon ton serveur, adapte l\'utilisateur www-data ou autre
HTTP_USER="www-data"
sudo chown -R $HTTP_USER:$HTTP_USER var/cache var/log

echo "🎉 Déploiement terminé ! Visite ton site en prod sans debug !"
