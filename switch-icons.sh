#!/usr/bin/env bash

set -e

if [[ ! -d "monocle/static" ]]; then
	echo "monocle/static not found, are you in the right folder?"
	exit 1
fi

if [[ -z "$1" ]]; then
	URL="https://github.com/Imaginum/monocle-icons.git"
else
	URL="$1"
fi

if [[ ! -e ".gitmodules" ]]; then
	BRANCH=$(git rev-parse --abbrev-ref HEAD)

	if [[ "$BRANCH" = 'develop' ]]; then
		echo ".gitmodules not present, pulling"
		git pull
	else
		echo ".gitmodules not present, exiting"
		exit 1
	fi
fi

git config --file=.gitmodules submodule.monocle-icons.url "$URL"
git submodule sync
git submodule update --init --remote

exit
