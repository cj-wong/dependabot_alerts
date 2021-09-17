#!/usr/bin/env awk
#
# Get all packages in main.py.

/^import/ {
    if ($4 ~ /Package:/) {
        print $5
    } else {
        print $2
    }
}
