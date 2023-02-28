#!/usr/bin/env bash
#
# Rebuild requirements.txt using packages listed in main.py.
#
# Exits:
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

# Install packages in environment.
#
# Globals:
#   None
# Arguments:
#   $1: directory containing environment
# Returns:
#   0: install succeeded
#   1: package.txt missing
#   2: virtual env could not be created; something is wrong with the Python
#      installation
#   3: virtual env is missing a functional activate script
function install_env() {
    local env="$1"
    local packages="${env}/packages.txt"
    local venv="${env}/.venv"

    if [[ ! -d "$env" ]]; then
        return 10
    elif [[ ! -f "$packages" ]]; then
        echo "packages.txt is missing" >&2
        return 1
    elif ! python3 -m venv "$venv"; then
        echo "Couldn't create virtual environment for ${env}" >&2
        echo "The command is normally idempotent so something is wrong with "\
             "your Python installation." >&2
        return 2
    fi

    # shellcheck disable=SC1091
    # The activation script only exists conditionally.
    if ! . "${venv}/bin/activate"; then
        echo "The virtual env is missing critical files" >&2
        return 3
    fi

    while read -r package; do
        pip install "$package"
    done < "${env}/packages.txt"

    pip freeze > "${env}/requirements.txt"

    deactivate
}

src_dir=$(dirname "${BASH_SOURCE[0]}")

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

for env in "${src_dir}/environments"/*; do
    if ! install_env "$env"; then
        echo "Skipping ${env}" >&2
    fi
done
