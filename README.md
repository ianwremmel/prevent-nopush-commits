# Prevent "nopush" Commits

> This action prevents you from merging commits that *start with* `#no-push` or `#nopush`.

## Usage

An example workflow to prevent `#no-push` commits follows:

```yml
on: push
name: Validate
jobs:
  build:
    name: ianwremmel/prevent-nopush-commits
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
      with:
        fetch-depth: 0
    - uses: ianwremmel/prevent-nopush-commits@v2
```

v2 is a composite action, so it runs on any runner or job container that has
`bash` and `git`, including Kubernetes container mode runners. v1 is a Docker
action and only runs where Docker container actions are supported.

## Versions

`@v2` tracks the latest 2.x release; `v2.0.0` is the first composite release.
If you need the Docker action, pin `@v1.0.8`.
