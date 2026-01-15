#! /usr/bin/env bash

SCRIPTPATH=$(dirname "$(realpath "$0")")

rm -f $SCRIPTPATH/Notes.md

rm -rf $SCRIPTPATH/.git

git init $SCRIPTPATH

rm -f $SCRIPTPATH/setup.sh
