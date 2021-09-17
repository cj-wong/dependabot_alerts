#!/usr/bin/env bash
#
# Rebuild requirements.txt using packages listed in main.py.
#
# Exits:
#   1: script was not run in its directory
#   2: user did not accept prompt
#   3: venv was active but could not be deactivated (e.g. conda conflict)

# Prompt the user for input.
#
# Globals:
#   None
# Arguments:
#   $1: prompt message
# Returns:
#   0: the user accepted the prompt
# Exits:
#   1: the user did not accept the prompt (or input incorrectly)
function prompt_user() {
    local prompt
    read -r -p "${1} [yN] " prompt
    if [[ $prompt =~ ^[yY] ]]; then
        return 0
    else
        echo "Exiting..." >&2
        exit 2
    fi
}

src_dir=$(dirname "$0")
if [[ "$src_dir" != "$PWD" && "$src_dir" != "." ]]; then
    echo "Please run this script in its directory." >&2
    exit 1
fi

if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "You have a virtual environment already active."
    echo "Path: ${VIRTUAL_ENV}"
    echo "It must be deactivated to continue."
    if prompt_user "Deactivate it?"; then
        if deactivate; then
            echo "venv deactivated."
        else
            echo "Could not deactivate venv. This could be because conda is" >&2
            echo "installed locally. Deactivate manually, and then re-run." >&2
            exit 3
        fi
    fi
fi

if [[ -d venv ]]; then
    echo "venv already exists. It must be removed to continue."
    if prompt_user "Remove it?"; then
        rm -r venv
        echo "venv removed."
    fi
fi

packages=()

while read -r package; do
    packages+=("$package")
done < <(awk -f packages.awk main.py)

python3 -m venv venv
# shellcheck disable=SC1091
# The activation script only exists conditionally.
. venv/bin/activate

pip install "${packages[@]}"
pip freeze > requirements.txt
