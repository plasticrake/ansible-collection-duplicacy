#!/usr/bin/env bash

INSTALL_TYPE=$1
INSTALL_FULLPATH="${2:-/usr/local/bin/${1}}"
INSTALL_TAG="${3:-latest}"

OS=`uname -s`
ARCH=`uname -m`

case "$OS" in
  'FreeBSD')
    DUPLICACY_DL='freebsd_x64'
    DUPLICACY_UTIL_DL='freebsd_x64'
    ;;

  'Linux')
    case "$ARCH" in
      x86_64|amd64)
        DUPLICACY_DL="linux_x64"
        DUPLICACY_UTIL_DL='linux_x64'
        ;;
      i?86)
        DUPLICACY_DL="linux_i386"
        DUPLICACY_UTIL_DL='linux_i386'
        ;;
      arm*)
        if [${ARCH:4:1} -gt 7]; then
          # armv8 or greater
          DUPLICACY_DL="arm64"
          DUPLICACY_UTIL_DL="arm"
        else
          DUPLICACY_DL="arm"
          DUPLICACY_UTIL_DL="arm"
        fi
    esac
    ;;
    
  'Darwin')
    DUPLICACY_DL='osx_x64'
    DUPLICACY_UTIL_DL='osx_x64'
    ;;
esac

if [ -z $DUPLICACY_DL ] || [ -z $DUPLICACY_UTIL_DL ]; then
    echo "Could not determine correct download for system ${OS} ${ARCH}"
    exit 1
fi

function get_release_url() {
  local repo=$1
  local arch=$2
  local tag=$3

  if [ "$tag" == 'latest' ]; then
    download_stdout "https://api.github.com/repos/${repo}/releases/latest" \
      | jq -r ".assets[] | select(.name | contains(\"${arch}\")).browser_download_url"
  else 
    download_stdout "https://api.github.com/repos/${repo}/releases/tags/${tag}" \
      | jq -r ".assets[] | select(.name | contains(\"${arch}\")).browser_download_url"
  fi
}

function download_stdout() {
  if hash curl 2>/dev/null; then
    curl --silent "$@"
  else
    wget --quiet -O - "$@"
  fi
}

function download_and_install() {
  local url=$1
  local dest=$2
  if hash curl 2>/dev/null; then
    echo "curl -silent --location $url --output $dest"
    curl --silent --location $url --output $dest
  else
    echo "wget --quiet -O $dest $url"
    wget --quiet -O $dest $url
  fi
  echo "chmod +x $dest"
  chmod +x $2
}

case "$INSTALL_TYPE" in
  'duplicacy')
    REPO='gilbertchen/duplicacy'
    DL=$DUPLICACY_DL
    URL=$(get_release_url $REPO $DL $INSTALL_TAG)
    ;;
  'duplicacy-util')
    REPO='jeffaco/duplicacy-util'
    DL=$DUPLICACY_UTIL_DL
    URL=$(get_release_url $REPO $DL $INSTALL_TAG)
    ;;
  *)
    echo "Invalid install_type specified: \"${INSTALL_TYPE}\". Valid values: \"duplicacy\", \"duplicacy-util\""
    exit 1
esac

if [ -z "$URL" ]; then
  echo "Could not find release on GitHub!" 1>&2
  echo "REPO:${REPO} DL:${DL} TAG:${INSTALL_TAG}" 1>&2
  exit 1
fi

download_and_install $URL $INSTALL_FULLPATH