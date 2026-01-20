# BOIL-FOR-LINUX

    ██████╗  ██████╗ ██╗██╗     
    ██╔══██╗██╔═══██╗██║██║     
    ██████╔╝██║   ██║██║██║     
    ██╔══██╗██║   ██║██║██║     
    ██████╔╝╚██████╔╝██║███████╗
    ╚═════╝  ╚═════╝ ╚═╝╚══════╝

 A fast and minimal Bash-based CLI to scaffold modern web projects (React, Vue, Svelte) with a single command.

## How to install?

To install, run exactaly code below
```
bash <<'EOF'
set -e
echo "Installing Boil CLI..."
REPO_DIR="$HOME/boil-for-linux"
INSTALL_DIR="/usr/local/share/boil"
BIN_PATH="/usr/local/bin/boil"
if [ ! -d "$REPO_DIR" ]; then
    git clone https://github.com/joaohenriqueleal/boil-for-linux.git "$REPO_DIR"
else
    echo "Repo already exists, skipping clone."
fi
cd "$REPO_DIR"
sudo rm -rf "$INSTALL_DIR"
sudo rm -f "$BIN_PATH"
sudo mkdir -p "$INSTALL_DIR"
sudo cp -r commands "$INSTALL_DIR/"
sudo cp boil.sh "$BIN_PATH"
sudo chmod +x "$BIN_PATH"
sudo chmod -R +x "$INSTALL_DIR/commands"
echo
echo "Boil installed globally!"
echo "Try: boil --help"
EOF
```

## How to use?

example:

```
boil react-ts-wind-vitest <my-project-name>
```


This command create a React + TypeScript project Completely clean, without the App.jsx and App.css files from the default Vite project, with 4-space formatting through the Prettier library, and much more. Boil generates a production-ready structure without any hassle or wasted time. See the [docs](https://github.com/joaohenriqueleal/boil-for-linux/blob/main/docs/commands.md) documentation for more details and commands.

## Dependencies
- node
- npm
- prettier
- tsc (TypeScript compiler)

<img width="1024" height="1024" alt="boil" src="https://github.com/user-attachments/assets/597592af-aec9-4339-a2cb-de21fa84ec29" />
