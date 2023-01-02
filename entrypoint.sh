#!/usr/bin/env bash

set -e


[[ -z $SOURCE_ENDPOINT ]] && exit
[[ -z $SOURCE_USER ]] && exit
[[ -z $SOURCE_PASSWORD ]] && exit
[[ -z $SOURCE_BUCKET ]] && exit
[[ -z $TARGET_ENDPOINT ]] && exit
[[ -z $TARGET_USER ]] && exit
[[ -z $TARGET_PASSWORD ]] && exit
[[ -z $TARGET_BUCKET ]] && exit

mc alias set source $SOURCE_ENDPOINT $SOURCE_USER $SOURCE_PASSWORD
mc alias set target $TARGET_ENDPOINT $TARGET_USER $TARGET_PASSWORD

mc mirror --watch source/$SOURCE_BUCKET target/$TARGET_BUCKET
