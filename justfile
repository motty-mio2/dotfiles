GREETING := "Hello, World!"

default:
    @echo "{{GREETING}}"

actions:
    actionlint

shell-de-template:
    find . -name "*.sh.tmpl" -exec sed -i '/{{"{{"}}/s/^/# /' {} \;

shell-check:
    find . \( -name "*.sh" -or -name "*.sh.tmpl" \) -exec shfmt -d {} \; -exec shellcheck {} \;

shell-fix:
    find . \( -name "*.sh" -or -name "*.sh.tmpl" \) -exec shfmt -w {} \;

shell-template:
    find . -name "*.sh.tmpl" -exec sed -i '/{{"{{"}}/s/^# //' {} \;

shell: shell-de-template shell-check shell-template

toml-check:
    find . \( -name "*.toml" \) -exec tombi lint {} \; -exec tombi format --check {} \;

toml-format:
    find . \( -name "*.toml" \) -exec tombi lint {} \; -exec tombi format {} \;

lua-check:
    find . -name "*.lua" -exec stylua -c {} \;

lua-fix:
    find . -name "*.lua" -exec stylua {} \;
