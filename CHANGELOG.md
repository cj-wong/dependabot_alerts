# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [0.2.1] - 2021-09-16
### Added
- Added support for non-importable modules in [packages.awk]. (Start the line with `# Package: `.)
- Added `ansible` and `ansible-lint`.

## [0.2.0] - 2021-09-16
### Added
- Added [main.py] for tracking packages.
- Added [rebuild.sh] for automatically rebuilding [requirements.txt].
- Added helper awk script [packages.awk] to parse [main.py].

### Removed
- Removed `discord.py` and its dependencies.

## [0.1.0] - 2021-08-26
### Added
- Initial version


[main.py]: main.py
[packages.awk]: packages.awk
[rebuild.sh]: rebuild.sh
[requirements.txt]: requirements.txt
