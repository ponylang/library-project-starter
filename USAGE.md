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
- Script to automate releasing versions of your library
- CHANGELOG file for tracking changes to our project
- README including:
  * CircleCI status badge
  * Project status
  * How to install using pony-stable

You still need to add:

- A directory at the root of the project containing your Pony source code

## It's opinionated

This starter pack is opinionated. We suggest that you review:

- [LICENSE](LICENSE)
- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
- [CONTRIBUTING.md](CONTRIBUTING.md)
- [STYLE_GUIDE.md](STYLE_GUIDE.md)

Make sure that you agree with them. Feel free to make changes to suit your particular style.

## It assumes you are using GitHub for hosting

Both `release.bash` and `RELEASE_PROCESS.md` assume you are using GitHub. Accordingly, as part of the release process, they contains GitHub specific code and instructions related to adding and publishing release notes via GitHub's release feature. If you aren't using GitHub, you can still use the included release files but, you will have to modify them a little.

Additionally, the CONTRIBUTING.md assumes your project is hosted on GitHub and contains links to issues, forking, etc that are GitHub specific. If you aren't hosting on GitHub, you should update those links accordingly.

## What you need to update

This repository is templated. You'll want to replace anything in {} with the correct value. The following replacement values are required:

- {REPO_OWNER}: your GitHub username or organization name, for example: `ponylang`.
- {REPO}: the name of your repository, for example: `ponyc`.
- {PACKAGE}: the name of your libraries package, for example: `msgpack`.
- {COC_EMAIL}: email address that Code of Conduct violations should be reported to, for example: `coc@ponylang.org`.
- {PROJECT_DESCRIPTION}: a paragraph describing your project
- {PROJECT_STATUS}: paragraph or two describing the status of your project. Is it alpha? beta? production-ready? What's left to implement?
- {COPYRIGHT_YEAR}: if you use the enclosed BSD 2 clause license, you'll need to set the Copyright year.
- {COPYRIGHT_HOLDER}: if you use the enclosed BSD 2 clause license, you'll need to set the Copyright holder.
- {COMMIT_NAME}: Name to use for commits that code that is part of this package will create, for example: `ponylang-main`.
- {COMMIT_EMAIL}: Email address to use for commits that code that is part of this package will create, for example: `main@ponylang.io`.
- {GITHUB_ACCESS_TOKEN_NAME}: Name of CircleCI environment variable that your GitHub personal access token that allows for `public_repo` access is stored in.
- {GITHUB_USER}: Username for the owner of the GitHub access token

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

## How to structure your project

The Makefile assumes that your project will have:

- A single package
- That your tests are in the top-level of your package.
- Tests will be built in the `build` directory
- Example programs located in `examples` that you want to compile as part of
    "testing"

### Examples

Each example program should be it's own directory in the `examples directory.
When you run `build-examples` or `test`, example programs will be compiled to
assure there is no API breakage. They will not, however, be run as there's no
generic way to validate behavior.

##

### Available make commands

- test

Runs the `unit-tests` and `build-examples` commands.

- unit-tests

Compiles your package and runs the Ponytest tests.

- build-examples

Compiles example programs in `examples` directory.

- clean

Removes build artifacts for the specified config (defaults to `release`). Doesn't remove documentation as documentation isn't config specific. Use `realclean` to remove all artifacts including documentation.

- realclean

Removes all build artifacts regardless of `config` value.

- docs

Builds the public documentation for your the library.

- TAGS

Generates a `tags` file for the project using `ctags`. `ctags` installation is
required to use this feature.

- all

Runs the `test` command.

- "bare"

Running `make` without any command will execute the `test` command.

### Available make options

- config

Pass either `release` or `debug` depending on which type of build you want to
do. The default is `release`.

## Using Pony stable

The Makefile assumes that you don't have any external dependencies that are managed by pony-stable. If you need to use stable, you'll need to update one of the Makefile rules:

```make
COMPILE_WITH := ponyc
```

to

```make
COMPILE_WITH := stable env ponyc
```

Please note, you will need to update the Makefile to run `stable fetch` for you
if you want it run automatically, or you will need to run it manually at least
once in order to get your dependencies.
