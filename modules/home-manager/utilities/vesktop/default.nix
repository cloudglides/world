{inputs, ...}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    vesktop.enable = true;
    config = {
      frameless = true;
      plugins = {
        hideMedia.enable = true;
        ignoreActivities = {
          enable = true;
          ignorePlaying = true;
          ignoreWatching = true;
        };
      };
    };
  };
}
