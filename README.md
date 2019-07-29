# Prevent "nopush" Commits

> This action prevents you from merging commits that *start with* `#no-push` or `#nopush`.

## Usage

An example workflow to prevent `#no-push` commits follows:

```hcl
workflow "Validate Commit Messages" {
    on = "push"
    resolves = "Prevent nopush Commits"
}

action "Prevent nopush Commits" {
    uses = "ianwremmel/prevent-nopush-commits@v1.0.0"
}
```
