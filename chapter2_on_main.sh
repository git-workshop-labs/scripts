#!/bin/env bash

# This script does the following
#
# 1. It copies the current repository (directory) to /tmp
# 2. It creates commits in main with chapters/chapter2.adoc
# 3. It addes chapter2.adoc to the end of index.adoc
# 4. It pushes main

# store current directory
pushd

# find the git root directortory
ROOT_DIR=$(git rev-parse --show-toplevel)

# change to tmp and copy the git repository
cd /tmp
cp -r "${ROOT_DIR}" .

# change into it
cd "$(basename \"${ROOT_DIR}\")"

# commit to main!
git checkout .
git clean -f
git checkout main

# set name!
git config user.name "Hans Schreiberling"
git config user.email "hans@wintercloud.de"

# create commits
chapters/chapter2.adoc << EOF
= Kapitel 2

Rotkäppchen war gerne zuhause, und so blieb es auch. Sie ging nie los!

Und wenn sie nicht gestorben ist, dann geht sie auch heute nicht los!
EOF

git add .
git commit -m "[story] add chapter2"

# create another commit
echo "include::chapters/chapter2.adoc[leveloffset=2]" >> ./index.adoc

git add .
git commit -m "[story] include chapter2"

# push the changes
git push

# go back to original directory
popd

echo "All done!"
