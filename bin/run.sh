#!/bin/bash
function usage {
cat >&2 <<EOS
python shell を起動する

[usage]
 $0 [options]

[options]
 -h | --help:
   ヘルプを表示
 -v | --version <VERSION>:
   pythonバージョン指定
   38, 3.8
 --rm:
   終了と同時にコンテナを削除
 --root:
   rootユーザーで起動
EOS
exit 1
}

SCRIPT_DIR="$(cd $(dirname $0); pwd)"
PROJECT_ROOT="$(cd ${SCRIPT_DIR}/..; pwd)"

args=()
OPTIONS=
CMD="/usr/local/bin/entrypoint.sh"
while [ "$#" != 0 ]; do
  case $1 in
    -h | --help      ) usage;;
    -v | --version   ) shift;VERSION="$(echo $1 | sed -e 's/[^0-9]//g')";;
    --rm             ) OPTIONS="$OPTIONS --rm";;
    --root           ) CMD="/bin/bash";;
    --               ) shift; args+=($@); break;;
    -* | --*         ) error "$1 : 不正なオプションです" ;;
  esac
  shift
done

[ "${#args[@]}" != 0 ] && usage
if [ -z "$VERSION" ]; then
  echo "-v | --version オプションを指定してください (ex 38"
  exit 1
fi

CONTAINER_ID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n1)
CONTAINER_NAME=python${VERSION}-shell-$(date +"%Y%m%d.%H%M%S")
mkdir -p ${PROJECT_ROOT}/mnt/${CONTAINER_NAME}/user1
mkdir -p ${PROJECT_ROOT}/mnt/${CONTAINER_NAME}/root

docker run \
  $OPTIONS \
  -ti \
  -e LOCAL_UID=$(id -u) \
  -e LOCAL_GID=$(id -g) \
  -v "${PROJECT_ROOT}/mnt/${CONTAINER_NAME}/user1:/mnt/projects" \
  -v "${PROJECT_ROOT}/mnt/${CONTAINER_NAME}/root:/root/projects" \
  --name $CONTAINER_NAME \
  python${VERSION}-shell:latest \
  $CMD

