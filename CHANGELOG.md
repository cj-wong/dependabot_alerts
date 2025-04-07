# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [0.5.0] - 2025-04-07
### Changed
- Replaced `ansible` environment with `automation`. It now uses `uv` for dependency management.

## [0.4.2] - 2024-02-22
### Security
- Updated `ansible` environment.

## [0.4.1] - 2024-02-18
### Security
- Updated multiple `dependabot` alerts. (`ansible`, `requests`)

## [0.4.0] - 2023-02-28
### Changed
- Contained dependency groups into `environments`, grouped by purpose or usage. This was done to eliminate the chance of commingling of extant dependencies.

## [0.3.0] - 2023-02-26
### Added
- Added `asdf-vm` management for Python version (currently 3.9.x). This version represents the minimum Python version I use in all my projects.

### Changed
- `main.py` and `packages.awk` were removed in favor of storing packages and versions into `rebuild.sh`.

### Removed
- Removed more unused dependencies.

## [0.2.2] - 2021-09-30
### Fixed
- Fixed shebang in `packages.awk`.

## [0.2.1] - 2021-09-16
### Added
- Added support for non-importable modules in `packages.awk`. (Start the line with `# Package: `.)
- Added `ansible` and `ansible-lint`.

## [0.2.0] - 2021-09-16
### Added
- Added `main.py` for tracking package`.
- Added `rebuild.sh` for automatically rebuilding [requirements.txt].
- Added helper awk script `packages.awk` to parse `main.py`.

### Removed
- Removed `discord.py` and its dependencies.

## [0.1.0] - 2021-08-26
### Added
- Initial version


[rebuild.sh]: rebuild.sh
[requirements.txt]: requirements.txt
