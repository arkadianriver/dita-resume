#!/bin/bash

scriptdir=$(dirname -- "$0")
oxyplugdir="$HOME/Apps/Oxygen XML Editor 25/frameworks/dita/DITA-OT3.x/plugins/"

pushd $scriptdir/plugins
cp -r com.arkadianriver.resume "$oxyplugdir"
popd
