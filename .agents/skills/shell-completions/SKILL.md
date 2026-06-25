---
name: shell-completions
description: Create or generate shell completion scripts (bash, zsh, powershell) or Chezmoi completion templates for a CLI command. Use this skill when the user wants to write, set up, or generate completions for any command-line tool, or when they ask to set up chezmoi completion templates.
---

# Shell Completions Creator

Use this skill to discover how to generate shell completions for any given CLI command, and create raw completions or Chezmoi templates for zsh, bash, and powershell.

## Workflow

### 1. Discover Completion Method for the Command
When given a command name (e.g., `mise`, `uv`, `docker`):
1. Check if the tool is installed on the system using command exploration tools or run commands.
2. Run standard help/discovery probes:
   - `<command> --help`
   - `<command> help`
   - `<command> completion --help`
   - `<command> completions --help`
   - `<command> generate-shell-completion --help`
3. Analyze the output to determine:
   - **Dynamic completion command**: Does the CLI tool support outputting its own completion scripts? (e.g., `mise completion <shell>`, `uv generate-shell-completion <shell>`).
   - **Shell mapping**: Verify how the command refers to shells (e.g., `bash`, `zsh`, `powershell` or `ps1`).
   - **Static fallback**: If no dynamic completion generator exists, analyze the commands/subcommands/options via help outputs to write static completions from scratch.

### 2. Generate Chezmoi Templates
If Chezmoi templates are requested, use the template assets bundled with this skill:
- Bash template: `assets/chezmoi_bash.tmpl`
- Zsh template: `assets/chezmoi_zsh.tmpl`
- Powershell template: `assets/chezmoi_powershell.tmpl`

Read these files and replace the placeholders:
- `@COMMAND@`: The binary name (e.g., `mise`).
- `@SUBCOMMAND@`: The completion subcommand and flags (e.g., `completion` or `generate-shell-completion`).

### 3. Generate Static Completions (Fallback)
If the CLI command does not support dynamic generation, generate the following static files:

#### Bash Static Template
Save as `<cmd>` or `<cmd>-completion.bash`:
```bash
# bash completion for <cmd>
_<cmd>_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="<list_of_flags_and_subcommands>"

    # Simple matching of options
    if [[ ${cur} == -* ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
        return 0
    fi
    
    # Simple subcommands completion
    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
}
complete -F _<cmd>_completions <cmd>
```

#### Zsh Static Template
Save as `_<cmd>`:
```zsh
#compdef <cmd>

_$<cmd>() {
    local line
    _arguments -C \
        '-h[Show help]' \
        '--help[Show help]' \
        '1: :->cmds' \
        '*:: :->args'

    case "$state" in
        cmds)
            _values "commands" \
                <list_of_subcommands_with_descriptions>
            ;;
        args)
            # Custom argument completion per subcommand
            ;;
    esac
}

_$<cmd> "$@"
```

#### Powershell Static Template
Save as `<cmd>.ps1`:
```powershell
# powershell completion for <cmd>
$RegisterTabArgumentCompleter = {
    param($wordToComplete, $commandAst, $cursorPosition)
    $choices = @(<list_of_quoted_options_and_subcommands>)
    $choices | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}
Register-ArgumentCompleter -CommandName '<cmd>' -ScriptBlock $RegisterTabArgumentCompleter
```
