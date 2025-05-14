#!/bin/bash

export PATH=/usr/bin:/bin:/usr/local/bin

cd /home/meli/expressExample || exit

git checkout Deployment 2>/dev/null || git checkout -b Deployment origin/Deployment

git fetch origin

LOCAL=$(git rev-parse Deployment)
REMOTE=$(git rev-parse origin/Deployment)

if [ "$LOCAL" != "$REMOTE" ]; then
    echo "[`date`] Updating Deployment..." >> deploy.log
    git pull origin Deployment >> deploy.log
    sudo systemctl restart app.service
else
    echo "[`date`] There is no changes on Deployment branch" >> deploy.log
fi
