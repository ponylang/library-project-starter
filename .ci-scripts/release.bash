#!/bin/bash

set -o errexit
set -o nounset

REPO_OWNER}"
REPO="{REPO}"
GITHUB_USER="{GITHUB_USER}"

# Who we are for git
git config --global user.email "{COMMIT_EMAIL}"
git config --global user.name "{COMMIT_NAME}"
git config --global push.default simple

# Gather expected arguments.
if [ $# -lt 2 ]
then
  echo "Tag and GH personal access token are required"
  exit 1
fi

TAG=$1
GITHUB_TOKEN=$2
# changes tag from "release-1.0.0" to "1.0.0"
VERSION="${TAG/release-/}"

### this doesn't account for master changing commit, assumes we are HEAD
# or can otherwise push without issue. that shouldl error out without issue.
# leaving us to restart from a different HEAD commit
# update CHANGELOG
changelog-tool release "${VERSION}" -e

# commit CHANGELOG updates
git add CHANGELOG.md
git commit -m "Release ${VERSION}"

# tag release
git tag "${VERSION}"

# push to release to remote
git push origin HEAD:master "${VERSION}"

# update CHANGELOG for new entries
changelog-tool unreleased -e

# commit changelog and push to master
git add CHANGELOG.md
git commit -m "Add unreleased section to CHANGELOG post ${VERSION} release

[skip ci]"
git push origin HEAD:master

# release body
echo "Preparing to update GitHub release notes..."

body=$(changelog-tool get "${VERSION}")

jsontemplate="
{
  \"tag_name\":\$version,
  \"name\":\$version,
  \"body\":\$body
}
"

json=$(jq -n \
--arg version "$VERSION" \
--arg body "$body" \
"${jsontemplate}")

echo "Uploading release notes..."

result=$(curl -X POST "https://api.github.com/repos/${REPO_OWNER}/${REPO}/releases" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -u "${GITHUB_USER}:${GITHUB_TOKEN}" \
  --data "${json}")

  rslt_scan=$(echo "${result}" | jq -r '.id')
if [ "$rslt_scan" != null ]
then
  echo "Release notes uploaded"
else
  echo "Unable to upload release notes, here's the curl output..."
  echo "${result}"
  exit 1
fi


