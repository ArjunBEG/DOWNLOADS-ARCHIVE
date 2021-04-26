#!/bin/bash

# Usage:
#  bash download-node-nightly.sh

hasxz=$(which xzcat)
os=$(uname | tr '[A-Z]' '[a-z]')
arch=$(uname -m)
pwd=$(PWD)

[[ "$arch" == "x86_64" ]] && arch=x64
[[ "$arch" == "x686" ]] && arch=x32

type=nightly

echo -e "Getting latest list of nightlies…\n"
latest=$(curl -sL https://nodejs.org/download/${type}/index.tab | head -2 | tail -1 | awk '{ print $1 }')

while true; do
  echo -n "Download Node.js ${latest} (${os}/${arch})? [y/n] "
  yorn=""
  read yorn

  if [ "X${yorn}" == "Xn" ]; then
    break
  fi

  if [ "X${yorn}" == "Xy" ]; then
    echo -e "Downloading…\n\n"
    url="https://nodejs.org/download/${type}/$latest/node-${latest}-${os}-x64.tar"
    if [ "X${hasxz}" == "X" ]; then
      url="${url}.gz"
      pipecmd="| tar -zx -C ./"
    else
      url="${url}.xz"
      pipecmd="| xzcat | tar -x -C ./"
    fi
    bash -c "curl -L --progress-bar '${auth}' '${url}' ${pipecmd}"
    echo ""
    echo "Downloaded and extracted to ${pwd}/node-${latest}-${os}-x64/"
    echo ""  
    echo "The new node binary is located here:"
    echo "    ./node-${latest}-${os}-x64/bin/node"
    break
  fi
done