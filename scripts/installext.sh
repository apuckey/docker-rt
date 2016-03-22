#!/bin/sh

set -eu

REPO=$1
cd /usr/src
git clone "$REPO"
cd "$(basename "$REPO")"
perl Makefile.PL
make
make install
