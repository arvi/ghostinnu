# ============================================================================
# FZF Tools, Commands & Keybindings
# ============================================================================
#
# Quick Reference:
# ┌─────────────┬──────────────────────────────────────────────────────────┐
# │ Keybinding  │ Use Case                                                 │
# ├─────────────┼──────────────────────────────────────────────────────────┤
# │ Ctrl+R      │ Search command history while typing                      │
# │ Ctrl+T      │ Insert file path into current command                    │
# │             │ Example: git add <Ctrl+T> → select file                  │
# │ Alt+C       │ Browse all directories (recursive)                       │
# │ Alt+Z       │ Jump to frequent directories (zoxide)                    │
# └─────────────┴──────────────────────────────────────────────────────────┘
#
# Commands:
# - ll, la     → Quick ls with sorting
# - nufzf      → FZF for Nushell structured data
# - psf        → Browse processes interactively
# - envf       → Browse environment variables
#
# Aliases (from config.nu):
# - f          → Standalone file browser with preview
# - zf         → Frecent directory jump (manual)
# - rgf        → Search file contents, then browse
# ============================================================================

# ============================================================================
# Custom Commands
# ============================================================================

# Enhanced ls shortcuts
def ll [] {
  ls | sort-by type name
}

def la [] {
  ls -a | sort-by type name
}

# Nushell-aware fzf wrapper for structured data
# Usage: ps | nufzf, ls | nufzf, $env | transpose key value | nufzf
def nufzf [] {
  $in
  | each {|i| $i | to json --raw}
  | str join (char newline)
  | fzf
  | from json
}

# Browse processes interactively
def psf [] {
  ps | nufzf
}

# Browse environment variables
def envf [] {
  $env | transpose key value | nufzf
}

# ============================================================================
# FZF Keybindings
# ============================================================================

# Ctrl+R: Search command history
$env.config.keybindings = ($env.config.keybindings | append {
    name: fzf_history
    modifier: control
    keycode: char_r
    mode: emacs
    event: {
        send: executehostcommand
        cmd: "commandline edit --replace (history | get command | uniq | reverse | str join (char newline) | fzf --height 40% --layout=reverse --border)"
    }
})

# Ctrl+T: Insert file path at cursor
# Perfect for: git add <Ctrl+T>, nvim <Ctrl+T>, cat <Ctrl+T>
$env.config.keybindings = ($env.config.keybindings | append {
    name: fzf_files
    modifier: control
    keycode: char_t
    mode: emacs
    event: {
        send: executehostcommand
        cmd: "commandline edit --insert (fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always {}' --height 60%)"
    }
})

# Alt+C: Browse & change to any directory
# Searches recursively from current location
$env.config.keybindings = ($env.config.keybindings | append {
    name: fzf_cd
    modifier: alt
    keycode: char_c
    mode: emacs
    event: {
        send: executehostcommand
        cmd: "cd (fd --type d --hidden --exclude .git | fzf --height 40%)"
    }
})

# Alt+Z: Jump to frequent directories (zoxide)
# Based on your visit frequency and recency
$env.config.keybindings = ($env.config.keybindings | append {
    name: zoxide_interactive
    modifier: alt
    keycode: char_z
    mode: emacs
    event: {
        send: executehostcommand
        cmd: "cd (zoxide query -l | fzf --height 40%)"
    }
})

# ============================================================================
# FZF Power Functions - Press "Enter" to activate
# ============================================================================
# These are functions (def), not aliases, because they use pipes
#
# Usage Examples:
# $ f              → Browse files, returns filename
# $ fv             → Browse and open in nvim
# $ fo             → Browse and open with default app
# $ fc             → Browse and display contents
# $ rgf "TODO"     → Find files containing "TODO"
# ============================================================================

# File operations - using def instead of alias
def f [] {
  fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always {}'
}

def fv [] {
  let file = (fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always {}')
  if ($file | is-not-empty) {
    nvim $file
  }
}

def fo [] {
  let file = (fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always {}')
  if ($file | is-not-empty) {
    ^open $file
  }
}

def fc [] {
  let file = (fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always {}')
  if ($file | is-not-empty) {
    bat $file
  }
}

# Content search - searches inside files (not filenames)
# Includes hidden files like .env.example, .eslintrc, etc.
def rgf [pattern: string] {
  rg --hidden --files-with-matches $pattern | fzf --preview 'bat --color=always {}'
}

# Search ALL files (ignores .gitignore)
# Searches node_modules, .git, etc.
def rgfa [pattern: string] {
  rg --hidden --no-ignore --files-with-matches $pattern | fzf --preview 'bat --color=always {}'
}

# Jump to dir and edit
def zd [] {
  let dir = (zoxide query -l | fzf --height 40%)
  if ($dir | is-not-empty) {
    nvim $dir
  }
}
