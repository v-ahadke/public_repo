#!/bin/bash

dir="$(mktemp -d)"
echo $dir
cd $dir
git clone "git@github.com:v-ahadke/private_repo.git"
cd private_repo

sed -i.bak 's/git@github.v-ahadke.biz:Brand-EG/git@github.com:\/EGInc/' Cartfile
sed -i.bak 's/git@github.v-ahadke.biz:Brand-EG/git@github.com:\/EGInc/' Cartfile.resolved

tag="$(git describe --tags)"
git commit -a -m "patch cart file"

git push "git@github.com:v-ahadke/public_repo.git" :refs/tags/$tag

message="$(git tag -l --format='%(subject)' -n1 $tag)"
git tag -fa -m "$message" $tag

git push -f --all "git@github.com:v-ahadke/public_repo.git"
#git push -f --tags "git@github.com:v-ahadke/public_repo.git"
git push -f "git@github.com:v-ahadke/public_repo.git" $tag