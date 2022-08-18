# python-shell
まっさらなdebian x python環境を気軽に使うためのツール
利用できるpython versionは 3.6, 3.7, 3.8, 3.9, 3.10

# Quick Start

## ビルド
```bash
./bin/build.sh
```

## python環境起動

```bash
# python3.8環境を起動する (ホスト側のユーザーと同じuid, gidで起動します)
# ホストの ./mnt/{CONTAINER_ID}/user1 がコンテナの /home/user1//projects にマウントされます
./bin/run.sh -v 38
```

別のターミナルからログイン

```bash
docker exec -ti {CONTAINER_ID} su - user1
```

## オプション

```bash
# ヘルプ
./bin/run.sh -h

# 終了後に自動的にコンテナを削除する
./bin/run.sh -v 38 --rm

# ルートユーザーで利用する
# ホストの ./mnt/{CONTAINER_ID}/root がコンテナの /root/projects にマウントされます
./bin/run.sh -v 38 --root
```
