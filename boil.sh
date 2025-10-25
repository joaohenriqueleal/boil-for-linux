#!/bin/bash

COMMANDS_DIR="/usr/local/share/boil/commands"

COMMAND="$1"
shift
ARGS="$@"

if [[ "$COMMAND" == "--help" || "$COMMAND" == "-h" ]]; then
    echo -e "\033[1;34mAvailable boil commands:\033[0m"
    echo
    for file in "$COMMANDS_DIR"/*.sh; do
        cmd_name=$(basename "$file" .sh)
        echo -e "\033[1;34m$cmd_name [project-name]\033[0m"
        desc=$(grep -m1 "^#:" "$file" | sed 's/^#://;s/^ *//')
        if [[ -n "$desc" ]]; then
            echo "    $desc"
        fi
        echo
    done
    exit 0
fi

if [[ -f "$COMMANDS_DIR/$COMMAND.sh" ]]; then
    "$COMMANDS_DIR/$COMMAND.sh" "$PWD" $ARGS
else
    echo "Unknown command: $COMMAND"
    echo "Use 'boil --help' to list available commands."
fi
