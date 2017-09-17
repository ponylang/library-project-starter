# Library Project Starter Usage

The contents of this repo are designed to get you up and running with everything you need to start writing your excellent Pony library. If you copy all the contents of this repo into your new project you'll get:

- A Makefile to automate building and testing
- CircleCI setup (more actions will be required)
  * Build and test your project on each PR against most recent Pony release
  * Support for a daily cron job to test your project against bleeding-edge Pony master.
- Basic `.gitignore`
- Contribution guide that matches Pony's.
- Code of Conduct that matches Pony's.
- Style Guide that matches Pony's.
- README including:
  * CircleCI status badge
  * Project status
  * How to install using pony-stable

You still need to add:

- A License
- A directory at the root of the project containing your Pony source code

## It's opinionated

This starter pack is opinionated. We suggest that you review:

- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
- [CONTRIBUTING.md](CONTRIBUTING.md)
- [STYLE_GUIDE.md](STYLE_GUIDE.md)

Make sure that you agree with them. Feel free to make changes to suit your particular style.

## What you need to update

This repository is templated. You'll want to replace anything in {} with the correct value. The following replacement values are required:

- {USERNAME}: your GitHub username, for example: `ponylang`.
- {REPO}: the name of your repository, for example: `ponyc`.
- {PACKAGE}: the name of your libraries package, for example: `msgpack`.
- {COC_EMAIL}: email address that Code of Conduct violations should be reported to, for example: `coc@ponylang.org`.
- {PROJECT_DESCRIPTION}: a paragraph describing your project
- {PROJECT_STATUS}: paragraph or two describing the status of your project. Is it alpha? beta? production-ready? What's left to implement?

## What you need to create

Everything in this project assumes that your project has a single package that will be created at the root of the project. For example, if you were creating a project for supporting the MessagePack serialization format in Pony and called your package `msgpack` such that you would do the following to use it in other projects:

```pony
use "msgpack"
```

then you have to create a directory called `msgpack` at the root of your repository. All your Pony source code (including tests) will live in that directory. That directory needs to match the value you use for the {PROJECT} variable.

## About the CI setup

You'll still need to setup CircleCI to take advantage of the included CircleCI configuration file.  To do this, you'll need:

- A CircleCI account
- To grant CircleCI access to your repository

If you've never set up CircleCI before, we strongly suggest you check our their [documentation](https://circleci.com/docs/2.0/).

### What you might also need

The CI setup only sets up a single matrix Linux build using CircleCI. We are assuming that most libraries won't have OS specific code. If your project does have OS specific code, you'll possibly need to add:

- A CircleCI or TravisCI macOS setup
- Windows CI using appveyor

The CI setup also assumes that your project should perform the same regardless of LLVM version. If that isn't true for your project, you'll need to adjust the CircleCI configuration accordingly.

## How Make structures your project

The Makefile assumes that your project will have:

- A single package
- That your tests are in the top-level of your package.
- Tests will be built in the `build` directory

The Makefile assumes that you don't have any external dependencies that are managed by pony-stable. If you need to use stable, you'll need to update one of the Makefile rules:

```make
build/{PACKAGE}: build {PACKAGE}/*.pony
  ponyc {PACKAGE} -o build --debug
```

to

```make
build/{PACKAGE}: build {PACKAGE}/*.pony
  stable fetch
  stable env ponyc {PACKAGE} -o build --debug
```
