# ============================================================================
# Modern CLI Tool Replacements
# ============================================================================
# bat:      A cat clone with syntax highlighting and Git integration
# fd:       A fast and user-friendly alternative to find
# fzf:      A command-line fuzzy finder for interactive filtering
# ripgrep:  A fast search tool (like grep but faster and better defaults)
# zoxide:   A smarter cd command that learns your habits (autojump/z alternative)
# ============================================================================

# Better defaults with common flags
alias cat = bat --style=auto --paging=never
alias find = fd --hidden --exclude .git
alias grep = rg --smart-case
alias cd = z  # use zoxide instead of cd

# Navigation
alias .. = z ..
alias ... = z ../..
alias .... = z ../../..
alias - = z -  # go back to previous directory

# zoxide variants
alias zz = zi  # interactive zoxide with fzf
alias za = zoxide add  # manually add a path
alias zr = zoxide remove  # remove a path
alias zq = zoxide query  # query the database
alias ze = zoxide edit  # edit the database

# bat variants
alias cata = bat --style=auto --paging=always  # always page
alias catl = bat --style=plain                  # no decorations
alias catn = bat --style=numbers                # just line numbers

# fd variants
alias fda = fd --hidden --no-ignore             # find all (including gitignored)
alias fdf = fd --type f                         # files only
alias fdd = fd --type d                         # directories only
alias fdx = fd --type x                         # executables only

# ripgrep variants
alias rgi = rg --ignore-case                    # case insensitive
alias rgl = rg --files-with-matches             # just filenames
alias rga = rg --hidden --no-ignore             # search all files

# Open with default app
alias o = ^open  # macOS: opens with default application

# Editor shortcuts
alias v = nvim
alias vi = nvim
alias cs = cursor
alias cu = cursor
alias code = cursor
