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
 --retain:
   終了と同時にコンテナを削除しない
EOS
exit 1
}

SCRIPT_DIR="$(cd $(dirname $0); pwd)"
PROJECT_ROOT="$(cd ${SCRIPT_DIR}/..; pwd)"

args=()
OPTION_REMOVE="--rm"
while [ "$#" != 0 ]; do
  case $1 in
    -h | --help      ) usage;;
    -v | --version   ) shift;VERSION="$(echo $1 | sed -e 's/[^0-9]//g')";;
    --retain         ) OPTION_REMOVE="";;
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

docker run \
  $OPTION_REMOVE \
  -ti \
  --name python${VERSION}-shell \
  python${VERSION}-shell:latest \
  /bin/bash