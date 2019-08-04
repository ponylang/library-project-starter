#!/bin/bash

set -o errexit
set -o nounset

USERNAME={USERNAME}
REPONAME={REPO}

verify_args() {
  echo "Cutting a release for version $version with commit $commit"
  while true; do
    read -rp "Is this correct (y/n)?" yn
    case $yn in
    [Yy]*) break;;
    [Nn]*) exit;;
    *) echo "Please answer y or n.";;
    esac
  done
}

if [ $# -le 3 ]; then
  echo "GH username, GH personal access token, version, commit arguments required"
fi

set -eu
ghuser=$1
ghtoken=$2
version=$3
commit=$4

verify_args

# create version release branch
git checkout master
git pull
if ! git diff --exit-code master origin/master
then
  echo "ERROR! There are local-only changes on branch 'master'!"
  exit 1
fi
git checkout -b "release-$version" "$commit"

# update CHANGELOG
changelog-tool release "$version" -e

# commit CHANGELOG updates
git add CHANGELOG.md
git commit -m "Prep for $version release

[skip ci]"

# merge into master
git checkout master
if ! git diff --exit-code master origin/master
then
  echo "ERROR! There are local-only changes on branch 'master'!"
  exit 1
fi
git merge "release-$version" -m "Release $version"

# tag release
git tag "$version"

# push to release to remote
git push origin master
git push origin "$version"

# update CHANGELOG for new entries
changelog-tool unreleased -e

# commit changelog and push to master
git add CHANGELOG.md
git commit -m "Add unreleased section to CHANGELOG post $version release prep

[skip ci]"
git push origin master

# release body
body=$(changelog-tool get "${version}")

jsontemplate="
{
  \"tag_name\":\$version,
  \"name\":\$version,
  \"body\":\$body
}
"

json=$(jq -n \
--arg version "$version" \
--arg body "$body" \
"${jsontemplate}")

curl -X POST "https://api.github.com/repos/${USERNAME}/${REPO}/releases" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -u "${ghuser}:${ghtoken}" \
  --data "${json}"
