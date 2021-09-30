#!/usr/bin/env awk -f
#
# Get all packages in main.py.

/^import/ {
    if ($4 ~ /Package:/) {
        print $5
    } else {
        print $2
    }
}

/^# Package:/ {
    print $3
}
