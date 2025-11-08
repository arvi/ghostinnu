#!/usr/bin/env bash
# Setup script for Nushell configuration

set -e

echo "🚀 Setting up configs..."
echo ""

# Helper function to create symlink with backup
create_symlink() {
    local source=$1
    local target=$2
    local name=$3

    # Create parent directory if needed
    mkdir -p "$(dirname "$target")"

    # Check if target exists
    if [ -e "$target" ] || [ -L "$target" ]; then
        # If it's a symlink, just remove it
        if [ -L "$target" ]; then
            echo "  🔗 Removing old symlink..."
            rm "$target"
        # If it's a regular file/directory, back it up
        elif [ -f "$target" ] || [ -d "$target" ]; then
            echo "  💾 Backing up existing $name to ${target}.bak"
            mv "$target" "${target}.bak"
        fi
    fi

    # Create the symlink
    ln -sf "$source" "$target"
    echo "  ✅ $name linked"
}

# Generate integration files
echo "🔧 Generating Nushell integrations..."

# Create integrations directory
mkdir -p integrations

starship init nu > integrations/starship.nu
echo "✅ Starship - customizable cross-shell prompt"

zoxide init nushell > integrations/zoxide.nu
echo "✅ Zoxide - smarter cd that learns your habits"

if command -v mise &> /dev/null; then
    mise activate nu > integrations/mise.nu
    # Remove CSV lines at the top (lines starting with 'set,' or 'hide,') - causing error in cursor terminal; should work with ghostty and cursor terminal
    sed -i '' '/^set,/d; /^hide,/d' integrations/mise.nu
    echo "✅ Mise - polyglot runtime/tool version manager"
fi

# Symlink Ghostty config
echo ""
echo "👻 Setting up Ghostty config..."
create_symlink "$(pwd)/ghostty/config" "$HOME/.config/ghostty/config" "Ghostty"

# Symlink Starship config
echo ""
echo "🚀 Setting up Starship config..."
create_symlink "$(pwd)/starship/starship.toml" "$HOME/.config/starship.toml" "Starship"

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Restart Nushell (or run: source config.nu)"
echo "  2. Restart Ghostty"
echo ""
if ls ~/.config/ghostty/config.bak ~/.config/starship.toml.bak 2>/dev/null | grep -q .; then
    echo "📦 Backups created:"
    [ -e ~/.config/ghostty/config.bak ] && echo "  - ~/.config/ghostty/config.bak"
    [ -e ~/.config/starship.toml.bak ] && echo "  - ~/.config/starship.toml.bak"
    echo ""
fi
