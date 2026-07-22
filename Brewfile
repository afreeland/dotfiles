# Brewfile
# Install with: brew bundle --file ~/.config/Brewfile

# Core development tools
brew "neovim"
# Dotfiles sync via git; ~/.local/share/nvim/ does NOT. After git pull on a new machine:
#   :checkhealth vim.pack
#   :TSInstall! go lua python javascript typescript hurl --sync
#   :lua require('fff.download').download_or_build_binary()
# Full error → fix guide: ~/.config/nvim/TROUBLESHOOTING.md
brew "wezterm"
brew "go"
#brew "dapper"
brew "delve"
brew "rust"

tap "dart-lang/dart"
brew "dart"


# LSP servers
brew "gopls"                      # Go LSP
brew "lua-language-server"        # Lua LSP
brew "node"                       # Runtime for vtsls/eslint LSPs (and Nx repos)
brew "vtsls"                      # TypeScript/JS LSP (VS Code tsserver wrapper)
brew "vscode-langservers-extracted" # Provides vscode-eslint-language-server

# Treesitter dependencies
brew "tree-sitter"                # For nvim-treesitter

# Essential CLI tools
brew "git"
brew "ripgrep"                    # rg - fast grep

# Optional but useful
brew "jq"                         # JSON processor
brew "ykman"                      # YubiKey cli 
brew "curl"
brew "hurl"                       # Curl but from text files
brew "zsh"
brew "tree-sitter-cli"
brew "wireguard-tools"
