# Homebrew PATH
$env.PATH = ($env.PATH | split row (char esep) | prepend "/opt/homebrew/bin")

# Starship prompt
$env.STARSHIP_SHELL = "nu"
$env.STARSHIP_SESSION_KEY = (random chars -l 16)
$env.PROMPT_MULTILINE_INDICATOR = (^starship prompt --continuation)
$env.PROMPT_INDICATOR = ""
$env.PROMPT_COMMAND = { ||
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}
$env.PROMPT_COMMAND_RIGHT = ""


# env.nu
#
# Installed by:
# version = "0.108.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.
