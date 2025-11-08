# ==============================================================================
# Git Aliases - Nushell Version (Improved)
# Add this to your Nushell config file (config.nu)
# ==============================================================================

# ------------------------------------------------------------------------------
# External Tools
# ------------------------------------------------------------------------------
alias lg = lazygit
alias lzg = lazygit

# ------------------------------------------------------------------------------
# Repository Setup
# ------------------------------------------------------------------------------
alias gin = git init
alias grao = git remote add origin
alias gcl = git clone

# ------------------------------------------------------------------------------
# Branch Management
# ------------------------------------------------------------------------------
alias gb = git branch
alias gbd = git branch -d  # Delete branch (safe)
alias gbD = git branch -D  # Force delete branch
alias gbr = git for-each-ref --count=5 --sort=-committerdate refs/heads/ --format='%(refname:short)'
alias gbm = git branch -m

# ------------------------------------------------------------------------------
# Modern Switch/Restore (Git 2.23+) - Preferred over checkout
# ------------------------------------------------------------------------------
alias gsw = git switch  # Switch branches
alias gswc = git switch -c  # Create and switch to new branch
alias gswp = git switch -  # Switch to previous branch
alias grs = git restore  # Restore files
alias grss = git restore --staged  # Unstage files

# ------------------------------------------------------------------------------
# Legacy Checkout (still works, but switch/restore are preferred)
# ------------------------------------------------------------------------------
alias gch = git checkout
alias gchprev = git checkout -
alias gchb = git checkout -b

# ------------------------------------------------------------------------------
# Cleaning and Commits
# ------------------------------------------------------------------------------
alias gcun = git clean -i
alias gcom = git commit
alias gcoma = git commit --amend  # Amend last commit
alias gcomane = git commit --amend --no-edit  # Amend without changing message

# Optional: Only use if you have commitizen installed
alias gcomz = git cz
alias gcz = git cz

alias gtag = git tag
alias gtaga = git tag -a  # Annotated tag

# ------------------------------------------------------------------------------
# Adding Files
# ------------------------------------------------------------------------------
alias ga = git add
alias gaa = git add --all
alias gap = git add -p  # Interactive patch mode

# ------------------------------------------------------------------------------
# Status and Logs
# ------------------------------------------------------------------------------
alias gs = git status
alias gss = git status -s  # Short status
alias gl = git log
alias glo = git log --oneline
alias glog = git log --oneline --graph --decorate --all
alias gref = git reflog
alias gwc = git log --stat

# ------------------------------------------------------------------------------
# Diff (with git-delta integration)
# ------------------------------------------------------------------------------
alias gd = git diff
alias gds = git diff --staged
alias gdc = git diff --cached
alias gdif = git diff --check

# ------------------------------------------------------------------------------
# Remote Operations
# ------------------------------------------------------------------------------
alias gpl = git pull
alias gplo = git pull origin
alias gplr = git pull --rebase  # Pull with rebase
alias gps = git push
alias gpso = git push origin
alias gpsf = git push --force-with-lease  # Safer force push
alias gfe = git fetch -a
alias gfetch = git fetch --all --prune  # Fetch and prune deleted branches

# ------------------------------------------------------------------------------
# Merge and Rebase
# ------------------------------------------------------------------------------
alias gmer = git merge
alias gmera = git merge --abort
alias grb = git rebase
alias grbi = git rebase -i  # Interactive rebase
alias grba = git rebase --abort
alias grbc = git rebase --continue
alias grbs = git rebase --skip

# ------------------------------------------------------------------------------
# Cherry-pick
# ------------------------------------------------------------------------------
alias gcp = git cherry-pick
alias gcpa = git cherry-pick --abort
alias gcpc = git cherry-pick --continue

# ------------------------------------------------------------------------------
# Show
# ------------------------------------------------------------------------------
alias gsh = git show
alias gshs = git show --stat  # Show with stats

# ------------------------------------------------------------------------------
# Stash Operations
# ------------------------------------------------------------------------------
alias gst = git stash
alias gstl = git stash list
alias gsts = git stash save
alias gsta = git stash apply
alias gstp = git stash pop
alias gstd = git stash drop
alias gstc = git stash clear  # Clear all stashes

# ------------------------------------------------------------------------------
# Worktree (manage multiple working trees)
# ------------------------------------------------------------------------------
alias gwt = git worktree
alias gwtl = git worktree list
alias gwta = git worktree add
alias gwtr = git worktree remove
alias gwtpr = git worktree prune

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------
alias gconfl = git config --list --local
alias gconfg = git config --list --global
alias gconfs = git config --list --system

# ------------------------------------------------------------------------------
# Blame and History
# ------------------------------------------------------------------------------
alias gbl = git blame
alias gblame = git blame -w  # Ignore whitespace

# ------------------------------------------------------------------------------
# Reset
# ------------------------------------------------------------------------------
alias grs = git reset
alias grsh = git reset --hard
alias grss = git reset --soft

# ==============================================================================
# Custom Git Commands (Nushell-specific)
# ==============================================================================

# Pretty git log with graph and colors
def glogn [
    --count (-n): int = 20  # Number of commits to show
] {
    git log --oneline --graph --decorate --all --color=always -n $count
}

# Interactive branch switcher
def gswint [] {
    let branches = (git branch --format='%(refname:short)' | lines)
    if ($branches | is-empty) {
        print "No branches found"
        return
    }
    let selected = ($branches | input list "Select branch to switch to: ")
    git switch $selected
}

# Legacy version for checkout
def gchint [] {
    let branches = (git branch --format='%(refname:short)' | lines)
    if ($branches | is-empty) {
        print "No branches found"
        return
    }
    let selected = ($branches | input list "Select branch to checkout: ")
    git checkout $selected
}

# List branches with last commit date (formatted table)
def gblist [
    --count (-n): int = 10  # Number of branches to show
] {
    git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)|%(committerdate:relative)|%(subject)' --count=$count
    | lines 
    | parse "{branch}|{date}|{message}" 
    | select branch date message
}

# Show recent commits in a nice table
def glrecent [
    --count (-n): int = 10  # Number of commits to show
] {
    git log --pretty=format:'%h|%an|%ar|%s' -n $count
    | lines
    | parse "{hash}|{author}|{date}|{message}"
    | select hash author date message
}

# Git status with parsed output
def gstatus [] {
    let status = (git status --porcelain)
    if ($status | is-empty) {
        print "Working tree clean"
    } else {
        $status | lines | parse "{status} {file}" | select status file
    }
}

# Show modified files only
def gmod [] {
    git status --porcelain 
    | lines 
    | where {|line| $line | str starts-with " M" or $line | str starts-with "M "} 
    | parse "{status} {file}" 
    | get file
}

# Show untracked files only
def guntracked [] {
    git status --porcelain 
    | lines 
    | where {|line| $line | str starts-with "??"} 
    | parse "{status} {file}" 
    | get file
}

# Quick commit with message (adds all files)
def gcommit [message: string] {
    git add --all
    git commit -m $message
}

# Quick commit without adding all (only staged files)
def gcommits [message: string] {
    git commit -m $message
}

# Push to current branch
def gpscurrent [
    --force (-f)  # Force push with lease
] {
    let branch = (git branch --show-current)
    if $force {
        git push --force-with-lease origin $branch
    } else {
        git push origin $branch
    }
}

# Pull from current branch
def gplcurrent [
    --rebase (-r)  # Pull with rebase
] {
    let branch = (git branch --show-current)
    if $rebase {
        git pull --rebase origin $branch
    } else {
        git pull origin $branch
    }
}

# Show current branch name
def gcurrent [] {
    git branch --show-current
}

# Delete merged branches (interactive)
def gbclean [] {
    let merged = (git branch --merged | lines | where {|b| not ($b | str contains '*')} | str trim)
    if ($merged | is-empty) {
        print "No merged branches to delete"
    } else {
        print "Merged branches:"
        print $merged
        let confirm = (["yes", "no"] | input list "Delete these branches? ")
        if $confirm == "yes" {
            $merged | each {|branch| git branch -d $branch}
        }
    }
}

# Show file changes in last commit
def glast [] {
    git show --stat
}

# Undo last commit (keep changes staged)
def gundo [] {
    git reset --soft HEAD~1
}

# Undo last commit (keep changes unstaged)
def gundosoft [] {
    git reset HEAD~1
}

# Show all remotes with URLs
def gremotes [] {
    git remote -v 
    | lines 
    | parse "{name}\t{url} ({type})" 
    | select name url type
}

# Interactive stash browser
def gstint [] {
    let stashes = (git stash list | lines)
    if ($stashes | is-empty) {
        print "No stashes found"
    } else {
        let selected = ($stashes | input list "Select stash to apply: ")
        let index = ($stashes | enumerate | where {|x| $x.item == $selected} | get index | first)
        git stash apply $"stash@{($index)}"
    }
}

# Show contributors with commit count
def gcontrib [] {
    git shortlog -sn 
    | lines 
    | parse "{commits} {author}" 
    | into int commits
    | sort-by commits -r
}

# Interactive rebase helper
def grbihelp [
    --count (-n): int = 10  # Number of commits to rebase
] {
    print $"Starting interactive rebase for last ($count) commits"
    git rebase -i $"HEAD~($count)"
}

# Search commit messages
def gsearch [query: string] {
    git log --oneline --all --grep=$query
}

# Search in code
def gsearchcode [query: string] {
    git log -S $query --oneline
}

# Show what changed in a file over time
def gfilelog [file: string] {
    git log --follow --patch -- $file
}

# List all tags sorted by version
def gtaglist [] {
    git tag --sort=-v:refname
}

# Create and push a tag
def gtagpush [tag: string, message: string = ""] {
    if ($message | is-empty) {
        git tag $tag
    } else {
        git tag -a $tag -m $message
    }
    git push origin $tag
}

# Sync fork with upstream
def gsynfork [] {
    git fetch upstream
    git checkout main
    git merge upstream/main
    git push origin main
}

# Show diff with delta (if configured)
# Make sure delta is configured in ~/.gitconfig
def gdelta [
    ...args: string  # Pass any git diff arguments
] {
    git diff ...$args
}

# Show commit graph in a prettier format
def gtree [
    --count (-n): int = 20
] {
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -n $count
}

# Checkout PR from GitHub (usage: gpr 123)
def gpr [pr_number: int] {
    git fetch origin $"pull/($pr_number)/head:pr-($pr_number)"
    git checkout $"pr-($pr_number)"
}

# Clean up local branches that don't exist on remote
def gprune [] {
    git fetch --prune
    git branch -vv | lines | where {|line| $line =~ "gone]"} | parse "{branch}" | get branch | each {|b| git branch -D ($b | str trim)}
}
