#!/bin/sh

set -eu

DIR="$(dirname $0)"
cd "${DIR}"

for f in $(ls | grep -v ${0##*/}); do
  ln -s "${PWD}/${f}" ~/.${f}
done
