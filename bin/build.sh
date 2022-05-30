#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
PROJECT_DIR=$(cd $(dirname $0)/..; pwd)

cd $PROJECT_DIR

for dockerfile in $(find $PROJECT_DIR -type f | grep "Dockerfile"); do
  dockerdir=$(dirname $dockerfile)
  cd $dockerdir
  docker build --rm -f $dockerfile -t $(basename $dockerdir)-shell:latest . || exit 1

done