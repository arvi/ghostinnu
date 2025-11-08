# ============================================================================
# External Tool Integrations
# ============================================================================
# Auto-generated initialization files for external tools
# 
# These files are created/managed by the respective tools:
#
# - starship.nu  → Generated via starship init nu | save -f ($nu.default-config-dir | path join "integrations/starship.nu");
#
# - zoxide.nu    → Generated via zoxide init nushell | save -f ($nu.default-config-dir | path join "integrations/zoxide.nu");
#
# - mise.nu      → Generated via mise activate nu | save -f ($nu.default-config-dir | path join "integrations/mise.nu");
#
# Note: Don't edit these files directly - regenerate them if needed
# ============================================================================

# Starship prompt (https://starship.rs)
source ($nu.default-config-dir | path join "integrations/starship.nu")

# zoxide - smarter cd command (https://github.com/ajeetdsouza/zoxide)
source ($nu.default-config-dir | path join "integrations/zoxide.nu")

# mise - dev tools version manager (https://mise.jdx.dev)
source ($nu.default-config-dir | path join "integrations/mise.nu")
