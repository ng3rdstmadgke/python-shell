#!/bin/bash

set -e

# HOST_UID=${変数名:-デフォルト値}
HOST_UID=${LOCAL_UID:-1000}
HOST_GID=${LOCAL_GID:-1000}

# ホスト側の実行ユーザーと同一のUID, GIDを持つユーザーを作成
echo "Starting with UID : $HOST_UID, GID: $HOST_GID"
UNAME="user1"
groupadd -g $HOST_GID $UNAME
useradd -u $HOST_UID -o -m -g $HOST_GID -s /bin/bash $UNAME
usermod -aG sysadmin $UNAME
export HOME=/home/$UNAME

ln -s /mnt/projects /home/$UNAME/projects
chown -R $UNAME:$UNAME /mnt/projects /home/$UNAME/projects
echo 'alias ll="ls -alF"' >> /home/$UNAME/.bashrc

# 作成したユーザーでコマンドを実行
exec su - $UNAME
