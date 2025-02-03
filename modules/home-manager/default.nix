{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./fish
    ./neovim
    ./ghostty
  ];

  home = {
    username = "cloudglides";
    homeDirectory = "/home/cloudglides";
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
