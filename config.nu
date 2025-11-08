# ============================================================================
# Nushell Configuration
# ============================================================================

# Editor
$env.config.buffer_editor = "nvim"

# Shell behavior
$env.config.show_banner = false
$env.config.edit_mode = "emacs"

# External completions
$env.config.completions.external = {
    enable: true
    max_results: 100
    completer: null
}

# History
$env.config.history = {
    max_size: 100_000
    sync_on_enter: true
    file_format: "plaintext"
}

# Table display
$env.config.table = {
    mode: rounded
    index_mode: auto
    padding: { left: 1, right: 1 }
}

# ============================================================================
# Catppuccin Mocha Theme
# ============================================================================

$env.config.color_config = {
    separator: "#cdd6f4"
    leading_trailing_space_bg: { attr: n }
    header: { fg: "#a6e3a1" attr: b }
    empty: "#89b4fa"
    bool: "#cdd6f4"
    int: "#fab387"
    filesize: "#94e2d5"
    duration: "#cdd6f4"
    date: "#cba6f7"
    range: "#f9e2af"
    float: "#fab387"
    string: "#a6e3a1"
    nothing: "#cdd6f4"
    binary: "#cdd6f4"
    cell-path: "#cdd6f4"
    row_index: { fg: "#a6e3a1" attr: b }
    record: "#cdd6f4"
    list: "#cdd6f4"
    block: "#89b4fa"
    hints: "#6c7086"
    search_result: { fg: "#1e1e2e" bg: "#f38ba8" }
    
    shape_and: { fg: "#cba6f7" attr: b }
    shape_binary: { fg: "#cba6f7" attr: b }
    shape_block: { fg: "#89b4fa" attr: b }
    shape_bool: "#94e2d5"
    shape_closure: { fg: "#a6e3a1" attr: b }
    shape_custom: "#a6e3a1"
    shape_datetime: { fg: "#94e2d5" attr: b }
    shape_directory: "#89b4fa"
    shape_external: "#89b4fa"
    shape_externalarg: { fg: "#a6e3a1" attr: b }
    shape_filepath: "#94e2d5"
    shape_flag: { fg: "#89b4fa" attr: b }
    shape_float: { fg: "#fab387" attr: b }
    shape_garbage: { fg: "#f5e0dc" bg: "#f38ba8" attr: b }
    shape_globpattern: { fg: "#94e2d5" attr: b }
    shape_int: { fg: "#fab387" attr: b }
    shape_internalcall: { fg: "#94e2d5" attr: b }
    shape_list: { fg: "#94e2d5" attr: b }
    shape_literal: "#89b4fa"
    shape_match_pattern: "#a6e3a1"
    shape_matching_brackets: { attr: u }
    shape_nothing: "#94e2d5"
    shape_operator: "#f9e2af"
    shape_or: { fg: "#cba6f7" attr: b }
    shape_pipe: { fg: "#cba6f7" attr: b }
    shape_range: { fg: "#f9e2af" attr: b }
    shape_record: { fg: "#94e2d5" attr: b }
    shape_redirection: { fg: "#cba6f7" attr: b }
    shape_signature: { fg: "#a6e3a1" attr: b }
    shape_string: "#a6e3a1"
    shape_string_interpolation: { fg: "#94e2d5" attr: b }
    shape_table: { fg: "#89b4fa" attr: b }
    shape_variable: "#cba6f7"
    shape_vardecl: "#cba6f7"
}

$env.config.cursor_shape = {
    emacs: line
}


# ============================================================================
# Custom Configurations
# ============================================================================

source integrations.nu
source aliases_defaults.nu
source aliases_docker.nu
source aliases_git.nu
source navigation.nu

# config.nu
#
# Installed by:
# version = "0.108.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R
