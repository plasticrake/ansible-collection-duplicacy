#!/usr/bin/env bash

role_name=$1
distro_name=$2

echo "Generating molecule directory for role: $role_name"

# exit when any command fails
set -e

# cwd to script directory
dir=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
echo "CWD: $dir"
cd $dir


echo "Removing: ../$role_name/molecule"
rm -rf ../$role_name/molecule
echo "Creating: ../$role_name/molecule"
mkdir ../$role_name/molecule

echo "Creating: ../$role_name/molecule/default"
cp -a ../$role_name/molecule-role/common/ ../$role_name/molecule/default
echo "Creating: ../$role_name/molecule/vagrant"
cp -a ../$role_name/molecule-role/common/ ../$role_name/molecule/vagrant
echo "Creating: ../$role_name/molecule/local"
cp -a ../$role_name/molecule-role/common/ ../$role_name/molecule/local

role_common_molecule=../$role_name/molecule-role/common/molecule.yml

vagrant_distro=./vagrant/$distro_name.yml

if [ -e $role_common_molecule ]; then
  echo "Creating: ../$role_name/molecule/default/molecule.yml via yq"
  yq m -x ./default/molecule.yml $role_common_molecule > ../$role_name/molecule/default/molecule.yml

  echo "Creating: ../$role_name/molecule/local/molecule.yml via yq"
  yq m -x ./local/molecule.yml $role_common_molecule > ../$role_name/molecule/local/molecule.yml

  if [ -e $vagrant_distro ]; then
    echo "Creating: ../$role_name/molecule/vagrant/molecule.yml via yq"
    yq m -x ./vagrant/molecule.yml $vagrant_distro $role_common_molecule > ../$role_name/molecule/vagrant/molecule.yml
  fi
else
  echo "Copying: ../$role_name/molecule/default/molecule.yml"
  cp -a ./default/molecule.yml ../$role_name/molecule/default/molecule.yml
  
  echo "Copying: ../$role_name/molecule/local/molecule.yml"
  cp -a ./local/molecule.yml ../$role_name/molecule/local/molecule.yml

  if [ -e $vagrant_distro ]; then
    echo "Creating: ../$role_name/molecule/vagrant/molecule.yml via yq"
    yq m -x ./vagrant/molecule.yml $vagrant_distro > ../$role_name/molecule/vagrant/molecule.yml
  fi
fi

