#!/bin/bash

set -eu
#set -x

function fail() {
    echo "ERROR: $*"
    exit 1
}

WEBSITE_DIR="../mediators.github.io"
if [ ! -d "${WEBSITE_DIR}" ]; then
    fail "Unable to find local website repo checkout at ${WEBSITE_DIR}"
fi

git diff --exit-code >/dev/null 2>&1 || fail "You have unstaged changes"

git diff --cached --exit-code >/dev/null 2>&1 || fail "You have staged, uncommited changes"

UNPUSHED=$(git log origin/master..master)
if [ "${UNPUSHED}" != "" ]; then
    echo -n "You have unpushed commits. Push now? [Y/n]"
    read -r CHOICE
    if [ "${CHOICE}" == "Y" ] || [ "${CHOICE}" == "y" ] || [ "${CHOICE}" == "" ]; then
        git push
    else
        echo "ERROR: Refusing to run until you push"
        exit 1
    fi
fi

HEADREF=$(git rev-parse HEAD)

cp unreliable-mediator-guide.html "${WEBSITE_DIR}/index.html"
cp unreliable-mediator-guide.pdf "${WEBSITE_DIR}/TUMG.pdf"

pushd "${WEBSITE_DIR}"

git commit -am "Import files at ${HEADREF}"
git push -v

popd

