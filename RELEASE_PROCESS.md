# How to cut a {REPO} release

This document is aimed at members of the Pony team who might be cutting a release of Pony. It serves as a checklist that can take you through doing a release step-by-step.

## Prerequisites for doing any release

In order to do a release, you absolutely must have:

* Commit access to the `{REPO}` repo
* Version 0.3.x of the [changelog tool](https://github.com/ponylang/changelog-tool/releases) installed
* [git](https://git-scm.com/), [cURL](https://curl.haxx.se/), and [jq](https://stedolan.github.io/jq/) installed
* An account on the [Pony Zulip](https://ponylang.zulipchat.com)

## Prerequisites for specific releases

Before getting started, you will need a number for the version that you will be releasing as well as an agreed upon "golden commit" that will form the basis of the release.

## Releasing

Please note that the release script was written with the assumption that you are using a clone of the `{REPO}` repo. You have to be using a clone rather than a fork. Further, due to how git works, you need to make sure that both your `master` branch is up-to-date. It is advised to your do this but making a fresh clone of the `{REPO}` repo from which you will release. For example:

```bash
git clone git@github.com:{USERNAME}/{REPO}.git {REPO}-release-clean
cd {REPO}-release-clean
```

Any commit is eligible to be a "golden commit" so long as it has passed all CI checks. However, the normal case for the release tool that you will use assumes you will use a "golden commit" that is the most recent change to the `master` branch of {REPO}. If you deviate from that expectation, then some manual intervention might be required for you to continue the release process. Once manual intervention is involved, there is no way to restart the automated process and you'll have to do each of the steps in the release script by hand.

For the duration of this document, we will pretend the "golden commit" version is `8a8ee28` and the version is `0.3.1`. Any place you see those values, please substitute your own version.

You also need your GitHub user name and a GitHub personal access token. In the example below, the GitHub username is `seantallen` and the personal access token is `9999998gk48888ddd78a9fd12345a12870987uk`.

With that in mind, run the release script:

```bash
bash release.bash seantallen 9999998gk48888ddd78a9fd12345a12870987uk \
  0.3.1 8a8ee28
```

### Get release notes URL

Navigate to the GitHub page for the release you just created. It will be something like:

```
https://github.com/{USERNAME}/{REPO}/releases/tag/0.3.1
```

Copy the url to the page. You'll need it for the next two steps.

### Inform the Pony Zulip

Once you have the URL for the release notes, drop a note in the [#announce stream](https://ponylang.zulipchat.com/#narrow/stream/189932-announce) with a topic like "{REPO} 0.3.1 has been released" of the Pony Zulip letting everyone know that the release is out and include a link the release notes.

If this is an "emergency release" that is designed to get a high priority bug fix out, be sure to note that everyone is advised to update ASAP.

### Add to "Last Week in Pony"

Last Week in Pony is the Pony community's weekly newsletter. Add information about the release, including a link to the release notes, to the [current Last Week in Pony](https://github.com/ponylang/ponylang.github.io/issues?q=is%3Aissue+is%3Aopen+label%3Alast-week-in-pony).

