# {REPO}

{PROJECT_DESCRIPTION}

## Status

[![Build Status](https://travis-ci.org/{USERNAME}/{REPO}.svg?branch=master)](https://travis-ci.org/{USERNAME}/{REPO})

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
