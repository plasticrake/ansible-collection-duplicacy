#!/usr/bin/env bash

# Arguments:
# 1: ROLE_NAME
# ...rest: if spcified, runs molecule with these args (if not specified will not run)

# exit when any command fails
set -e

# cwd to script directory
dir=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
cd $dir

echo "CWD: $dir"

export ROLE_NAME=$1
shift 1
distro_name=$1
shift 1

echo "Executing: generate.sh $ROLE_NAME"
./roles/molecule-template/generate.sh $ROLE_NAME $distro_name

echo "CWD: ./roles/$ROLE_NAME"
cd ./roles/$ROLE_NAME

if [[ "$@" != "" ]]; then
  echo "Executing: molecule $@"
  molecule "$@"
fi
