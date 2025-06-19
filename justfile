PYTHON := "python"

default:
    just --list --unsorted

# Update flake.lock
update:
    nix flake update
