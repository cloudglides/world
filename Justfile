set shell := ["bash", "--norc", "--noprofile", "-euo", "pipefail"]

recipe := "world"

default:
    @just --list

# Rebuild + switch the system (nh → nixos-rebuild, includes home-manager)
switch:
    nh os switch

# Validate the whole flake
check:
    nix flake check

# Update all flake inputs
update:
    nix flake update

# Show current generation info + boot time
status:
    systemd-analyze
    ls -lc /nix/var/nix/profiles/system | tail -1