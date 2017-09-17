# {REPO}

{PROJECT_DESCRIPTION}

## Status

[![CircleCI](https://circleci.com/gh/{USERNAME}/{REPO}.svg?style=svg)](https://circleci.com/gh/{USERNAME}/{REPO})

{PROJECT_STATUS}

## Installation

* Install [pony-stable](https://github.com/ponylang/pony-stable)
* Update your `bundle.json`

```json
{ 
  "type": "github",
  "repo": "{USERNAME}/{REPO}"
}
```

* `stable fetch` to fetch your dependencies
* `use "{PACKAGE}"` to include this package
* `stable env ponyc` to compile your application
