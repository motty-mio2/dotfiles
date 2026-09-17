---
name: add-dependency
description: Search for packages across package managers (scoop, nix, apt, aur, mise, winget, flatpak, brew) and add new tools/applications to .chezmoidata/dependencies.toml. Trigger this skill whenever the user wants to add, register, or track a new tool, package, CLI command, dev tool, or desktop application in their dependencies.
---

# Add Dependency Skill

This skill searches package managers for a specified tool or application via web search, determines its proper category, and registers it directly into `.chezmoidata/dependencies.toml`.

## Category Classification

Determine the target table in `.chezmoidata/dependencies.toml` based on the tool's primary purpose:

1. **`dependencies.desktop`** (GUI / Desktop Applications)
   - Applications with a graphical user interface (e.g. Chrome, Discord, Slack, Obsidian, VS Code, Wezterm, GIMP).
   - **Key naming**: PascalCase / Canonical App Name (e.g., `Discord`, `Visual Studio Code` or `VSCode`, `Notion`, `Wezterm`).
   - **Target Package Managers**: `winget`, `flatpak`, `brew` (and `snap` if relevant).

2. **`dependencies.dev`** (Developer Tools / LSP / Linters / Compilers / Formatters)
   - Language servers (LSP), linters, code formatters, static analyzers, compilers, and specialized build/dev tooling (e.g. `actionlint`, `shellcheck`, `shfmt`, `clangd`, `marksman`, `stylua`, `tree-sitter`, `sccache`).
   - **Key naming**: Lowercase CLI command / tool name (e.g., `marksman`, `shellcheck`).
   - **Target Package Managers**: Priority order `scoop`, `nix` > `apt`, `aur` > `mise`.

3. **`dependencies.cli`** (General CLI Utilities)
   - Command-line utilities, shell tools, VCS, terminal viewers, terminal multiplexers, system utilities (e.g. `bat`, `eza`, `fd`, `fzf`, `gh`, `jq`, `jujutsu`, `lazygit`, `ripgrep`, `starship`, `yazi`, `zoxide`).
   - **Key naming**: Lowercase CLI command name (e.g., `ripgrep`, `yazi`).
   - **Target Package Managers**: Priority order `scoop`, `nix` > `apt`, `aur` > `mise`.

4. **`dependencies.hyprland`** (Hyprland / Wayland Specific Tools)
   - Specialized components for Hyprland/Wayland desktop environment (e.g. `hyprlock`, `waybar`, `grim`, `slurp`, `cliphist`, `wofi`).
   - **Key naming**: Lowercase package name.
   - **Target Package Managers**: `apt`, `aur`, `nix`.

*(Note: If a tool is strictly a Python/pip or Node/npm package without native binary packages, check if it belongs to `pip = [...]` or `npm = [...]` lists instead).*

---

## Package Manager Search Strategy

Perform web searches (`search_web`) as the primary discovery method. Web search is robust against naming variations (e.g., hyphens vs. underscores, `-bin` suffixes, upstream repo renames). Where exact URLs or APIs are accessible, verify the findings directly against upstream manifests or repositories.

### Repology (High-Efficiency Cross-Distro Search)
Searching `repology.org` often reveals package names across Nix, AUR, Debian/Ubuntu, and Scoop simultaneously:
- Query: `site:repology.org <tool-name>`


### 1. CLI & Dev Tools (`dependencies.cli` / `dependencies.dev`)

Prioritize finding packages in this order: `scoop`, `nix` > `apt`, `aur` > `mise`.

- **Scoop (Windows)**:
  - Check Scoop main and extras buckets, or external buckets.
  - Queries:
    - `<tool-name> scoop manifest`
    - `site:github.com/ScoopInstaller <tool-name>`
    - `site:scoop.sh <tool-name>`
  - Key: `scoop = "<manifest_name>"` (e.g., `scoop = "ripgrep"`, `scoop = "llvm"`)

- **Nix (Nixpkgs)**:
  - Check Nixpkgs package attribute name.
  - Queries:
    - `site:search.nixos.org/packages <tool-name>`
    - `<tool-name> nixpkgs`
  - Key: `nix = "<attribute_name>"` (e.g., `nix = "bat"`, `nix = "fd"`)

- **APT (Debian / Ubuntu)**:
  - Check Debian / Ubuntu package archives.
  - Queries:
    - `site:packages.ubuntu.com <tool-name>`
    - `site:packages.debian.org <tool-name>`
  - Key: `apt = "<pkg_name>"` (e.g., `apt = "git-delta"`, `apt = "fd-find"`)

- **AUR (Arch User Repository)**:
  - Check AUR / Arch official repos.
  - Queries:
    - `site:aur.archlinux.org <tool-name>`
    - `site:archlinux.org/packages <tool-name>`
  - Key: `aur = "<pkg_name>"` (e.g., `aur = "bat"`, `aur = "oh-my-posh-bin"`)

- **Mise (GitHub Release Binary / Core Plugin)**:
  - Check if the tool is supported by mise core/plugins or distributed via GitHub releases as precompiled binaries.
  - If hosted on GitHub with binary releases: `github:<owner>/<repo>`
  - If supported by a mise plugin/shortname: `<plugin_name>` (e.g. `uv`, `deno`, `usage`)
  - Queries:
    - `site:github.com <tool-name> releases`
    - `site:mise.jdx.dev plugins <tool-name>`
  - Key: `mise = "github:<owner>/<repo>"` or `mise = "<tool-name>"`

### 2. Desktop Applications (`dependencies.desktop`)

Look for packages across `winget`, `flatpak`, and `brew`:

- **Winget (Windows)**:
  - Look for official package identifier.
  - Queries:
    - `site:winget.run <app-name>`
    - `site:github.com/microsoft/winget-pkgs <app-name>`
  - Key: `winget = "<PackageIdentifier>"` (e.g., `winget = "Bitwarden.Bitwarden"`, `winget = "Google.Chrome.EXE"`, `winget = "XPDC2RH70K22MN"`)

- **Flatpak (Linux Flathub)**:
  - Look for Flathub reverse-DNS application ID.
  - Queries:
    - `site:flathub.org/apps <app-name>`
  - Key: `flatpak = "<app.id>"` (e.g., `flatpak = "com.discordapp.Discord"`, `flatpak = "org.mozilla.firefox"`)

- **Homebrew Cask (macOS / Cross-platform)**:
  - Look for Homebrew cask token.
  - Queries:
    - `site:formulae.brew.sh/cask <app-name>`
  - Key: `brew = "<cask-name>"` (e.g., `brew = "visual-studio-code"`, `brew = "discord"`)

---

## Workflow Steps

1. **Identify the Tool and Category**:
   - Extract the tool name requested by the user.
   - Categorize as `desktop`, `dev`, `cli`, or `hyprland`.
   - Normalize the key name (PascalCase for `desktop`, lowercase for `cli`/`dev`).

2. **Conduct Web Searches**:
   - Search Repology and specific package manager indices using `search_web`.
   - Collect package identifiers for all applicable managers.
   - Verify that package names are accurate and active.

3. **Check Existing Entries**:
   - Read `.chezmoidata/dependencies.toml`.
   - Check if the tool or command is already registered under any category to avoid duplicates.

4. **Construct and Insert the TOML Entry**:
   - Build an inline table:
     ```toml
     <tool_key> = { <mgr1> = "<pkg1>", <mgr2> = "<pkg2>" }
     ```
   - Insert into the appropriate section (`[dependencies.<category>]`) maintaining alphabetical order by key name.
   - Use `replace_file_content` to make the update directly.

5. **Report to the User**:
   - Report the added line and the target category.
   - Provide a brief summary of which package managers were found and configured.

---

## TOML Formatting Examples

### CLI Tool Example
```toml
# In [dependencies.cli]
eza = { scoop = "eza", nix = "eza", mise = "github:eza-community/eza" }
```

### Dev Tool Example
```toml
# In [dependencies.dev]
marksman = { scoop = "marksman", nix = "marksman", mise = "github:artempyanykh/marksman" }
```

### Desktop Application Example
```toml
# In [dependencies.desktop]
Discord = { flatpak = "com.discordapp.Discord", winget = "XPDC2RH70K22MN" }
```
