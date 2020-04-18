# Prevent "nopush" Commits

> This action prevents you from merging commits that *start with* `#no-push` or `#nopush`.

## Usage

An example workflow to prevent `#no-push` commits follows:

```yml
on: push
name: Validate
jobs:
  build:
    name: ianwremmel/prevent-nopush-commits@v1.0.1
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
      with:
        fetch-depth: 0
    - uses: ianwremmel/prevent-nopush-commits@v1.0.1
```
