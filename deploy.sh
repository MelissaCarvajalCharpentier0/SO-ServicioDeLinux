#!/bin/bash

export PATH=/usr/bin:/bin:/usr/local/bin

cd /home/meli/expressExample || exit

git checkout Deployment 2>/dev/null || git checkout -b Deployment origin/Deployment

git fetch origin

LOCAL=$(git rev-parse Deployment)
REMOTE=$(git rev-parse origin/Deployment)

if [ "$LOCAL" != "$REMOTE" ]; then
    echo "[$(date)] Updating Deployment..." >> deploy.log
    git pull origin Deployment >> deploy.log 2>&1

    echo 'tu_contraseña' | sudo -S systemctl restart app.service >> deploy.log 2>&1

    echo "[$(date)] Deployment complete." >> deploy.log
else
    echo "[$(date)] There is no changes on Deployment branch" >> deploy.log
fi
