# AGENTS.md

Guidance for AI coding agents working on this repository.

## What this is

A single-user NixOS flake (hostname `nixos`, user `cloudglides`) managing an
entire desktop system + home environment. Built with `nixos-unstable`.

## Repo layout

- `flake.nix` — entrypoint; flake inputs, overlay, `nixosConfiguration`. Home-manager
  is wired in as a NixOS module (`useGlobalPkgs = true`, `useUserPackages = true`).
- `modules/nixos/` — system-level config. `configuration.nix` is the main file;
  `hardware-configuration.nix` is machine-generated and gitignored.
- `modules/home-manager/` — per-app/user config, one `default.nix` per app, grouped:
  - `editors/` — neovim
  - `terminals/` — fish, ghostty
  - `utilities/` — fastfetch, tmux, vesktop
  - `default.nix` — imports all submodules + global home settings (packages, git, gpg, direnv)
- `pkgs/` — wrapper packages that ship config files as store paths
  (`builtins.path` + `stdenv.mkDerivation` that `cp -r`s into `$out`):
  - `pkgs/ghostty/ghostty/` — ghostty `config` + `shaders/*.glsl`
  - `pkgs/neovim/nvim/` — Neovim config (own git repo, lazy.nvim based)
- `assets/` — wallpaper + icons, exposed system-wide via `environment.etc."icons"`.
- `secrets.yaml` — SOPS-encrypted secrets (decrypted by sops-nix at activation).

## Commands

- Build/check the whole flake: `nix flake check` (always run after editing config)
- Rebuild the system: `sudo nixos-rebuild switch --flake .#nixos`
- Update inputs: `nix flake update`
- Eval a config value: `nix eval .#nixosConfigurations.nixos.config.<path>`

## Conventions

- **One `default.nix` per app** under `modules/home-manager/...`. New tools follow this pattern.
- Modules use compact function-arg style: `{pkgs, ...}: { ... }`. When a module defines
  options (`mkEnableOption`/`mkIf`), the args include `config` and `lib` (see tmux module).
- The overlay in `flake.nix` provides custom packages: `cloudglides-ghostty`,
  `cloudglides-nvim`. Custom packages are `callPackage`'d, not added to nixpkgs.
- `home.packages` is the catch-all for user packages (see `modules/home-manager/default.nix`).
- Use `with pkgs;` inside `home.packages` lists.
- **Never hardcode secrets** in `.nix` files. Git identity, etc. lives in
  `secrets.yaml` and is referenced via `/run/secrets/...` paths (sops-nix). To add a
  secret: `sops secrets.yaml`, then add a `sops.secrets.<name>` entry in
  `modules/nixos/configuration.nix`.
- `hardware-configuration.nix` is gitignored — regenerate per-machine, don't commit.
- Ghostty config/shaders and the neovim config live in `pkgs/` as store-path packages,
  symlinked into `~/.config/` by home-manager. Edit the files under `pkgs/*/...`,
  not `/home/cloudglides/.config/...` directly (those are home-manager-managed symlinks).

## Gotchas

- Ghostty relies on the system OpenGL driver via `hardware.graphics.enable = true`.
  "Failed to create EGL display" usually means a stale profile (old ghostty version),
  not a config bug — rebuild first.
- The shell is fish; `programs.fish` holds shell init + aliases.
- Flatpak packages are declared via `services.flatpak.packages` in home-manager.
- `result` symlink in the repo root is a build artifact (not tracked).
