#!/bin/bash
set -xueo pipefail

date +"%F %T"

echo "::group::Install build tools"
apt-get update
apt-get install --yes --no-install-recommends build-essential qt5-qmake qtbase5-dev qttools5-dev-tools ccache
export CCACHE_DIR=$(realpath .ccache)
echo "::endgroup::"

echo "::group::Check available tools"
date +"%F %T"
uname -a
qmake --version
make --version
g++ --version
ccache --version
echo "::endgroup::"

echo "::group::QMake"
date +"%F %T"
mkdir build
cd build
qmake ../trikCheckApp.pro CONFIG+=release CONFIG+=ccache
echo "::endgroup::"

echo "::group::Make"
date +"%F %T"
make -j $(nproc)
echo "::endgroup::"
date +"%F %T"
