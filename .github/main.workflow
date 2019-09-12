workflow "Validate" {
    on = "push"
    resolves = [
        "ianwremmel/prevent-fixup-commits@v1.0.0",
        "ianwremmel/prevent-nopush-commits@v1.0.1"
    ]
}

action "ianwremmel/prevent-fixup-commits@v1.0.0" {
    uses = "ianwremmel/prevent-fixup-commits@v1.0.0"
}

action "ianwremmel/prevent-nopush-commits@v1.0.1" {
    uses = "ianwremmel/prevent-nopush-commits@v1.0.1"
}
