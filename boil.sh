#!/bin/bash

COMMANDS_DIR="/usr/local/share/boil/commands"

COMMAND="$1"
shift
ARGS="$@"

get_all_commands() {
    find "$COMMANDS_DIR" -type f -name "*.sh"
}

if [[ "$COMMAND" == "uninstall" ]]; then
    echo "Uninstalling boil..."

    sudo rm -f /usr/local/bin/boil
    sudo rm -rf /usr/local/share/boil

    echo "Boil uninstalled successfully."
    exit 0
fi

if [[ "$COMMAND" == "--help" || "$COMMAND" == "-h" || -z "$COMMAND" ]]; then
    echo -e "\033[1;34mAvailable boil commands:\033[0m"
    echo
    echo -e "\033[1;34mboil uninstall\033[0m"
    echo "    Remove boil from your pc"
    echo

    get_all_commands | while read -r file; do
        cmd_name="$(basename "$file" .sh)"
        echo -e "\033[1;34m$cmd_name <project-name>\033[0m"

        desc=$(grep -m1 "^#:" "$file" | sed 's/^#://;s/^ *//')
        if [[ -n "$desc" ]]; then
            echo "    $desc"
        fi
        echo
    done

    exit 0
fi

COMMAND_FILE=$(get_all_commands | grep "/$COMMAND.sh$" | head -n 1)

if [[ -n "$COMMAND_FILE" && -f "$COMMAND_FILE" ]]; then
    "$COMMAND_FILE" "$PWD" $ARGS
else
    echo "Unknown command: $COMMAND"
    echo "Use 'boil --help' to list available commands."
    exit 1
fi
