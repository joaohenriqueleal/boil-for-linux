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
set -e
echo "Installing Boil CLI..."
git clone https://github.com/joaohenriqueleal/boil-for-linux.git ~/boil-for-linux || echo "Repo already exists, skipping clone."
cd ~/boil-for-linux || exit
sudo mkdir -p /usr/local/share/boil/commands
sudo cp -r commands/*.sh /usr/local/share/boil/commands/
sudo cp boil.sh /usr/local/bin/boil
sudo chmod +x /usr/local/share/boil/commands/*.sh
sudo chmod +x /usr/local/bin/boil

echo "Boil installed globally!"
echo "Try: boil --help"
```

## How to use?

example:

```
boil react-ts my-project-name
```

This command create a React + TypeScript project Completely clean, without the App.jsx and App.css files from the default Vite project, with 4-space formatting through the Prettier library, and much more. Boil generates a production-ready structure without any hassle or wasted time. See the [docs](https://github.com/joaohenriqueleal/boil-for-linux/blob/main/docs/commands.md) documentation for more details and commands.

![Boil logo](https://github.com/joaohenriqueleal/boil-for-linux/blob/main/boil.sh)
