#!/bin/bash

COMMANDS_DIR="/usr/local/share/boil/commands"

COMMAND="$1"
shift
ARGS="$@"

get_all_commands() {
    find "$COMMANDS_DIR" -type f -name "*.sh"
}

# HELP
if [[ "$COMMAND" == "--help" || "$COMMAND" == "-h" || -z "$COMMAND" ]]; then
    echo -e "\033[1;34mAvailable boil commands:\033[0m"
    echo

    get_all_commands | while read -r file; do
        cmd_name="$(basename "$file" .sh)"
        echo -e "\033[1;34m$cmd_name [project-name]\033[0m"

        desc=$(grep -m1 "^#:" "$file" | sed 's/^#://;s/^ *//')
        if [[ -n "$desc" ]]; then
            echo "    $desc"
        fi
        echo
    done

    exit 0
fi

# Procura o comando pelo nome do arquivo (basename)
COMMAND_FILE=$(get_all_commands | grep "/$COMMAND.sh$" | head -n 1)

if [[ -n "$COMMAND_FILE" && -f "$COMMAND_FILE" ]]; then
    "$COMMAND_FILE" "$PWD" $ARGS
else
    echo "Unknown command: $COMMAND"
    echo "Use 'boil --help' to list available commands."
    exit 1
fi
