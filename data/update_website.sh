#!/bin/bash

set -eu
#set -x

function fail() {
    echo "ERROR: $*"
    exit 1
}

function isGitClean() {
    rc=0
    git diff --exit-code >/dev/null 2>&1 || rc=1
    git diff --cached --exit-code >/dev/null 2>&1 || rc=1
    return $rc
}

WEBSITE_DIR="../mediators.github.io"
if [ ! -d "${WEBSITE_DIR}" ]; then
    fail "Unable to find local website repo checkout at ${WEBSITE_DIR}"
fi

isGitClean || fail "Your git repo is not clean. Commit!"

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

make

needsCommit=0
isGitClean || needsCommit=1
if [ $needsCommit -eq 1 ]; then
    git commit -am "Update output files at ${HEADREF}"
    git push -v
fi

cp unreliable-mediator-guide.html "${WEBSITE_DIR}/index.html"
cp unreliable-mediator-guide.pdf "${WEBSITE_DIR}/TUMG.pdf"

pushd "${WEBSITE_DIR}"

needsCommit=0
isGitClean || needsCommit=1

if [ $needsCommit -eq 1 ]; then
    git commit -am "Import files at ${HEADREF}"
    git push -v
fi

popd

