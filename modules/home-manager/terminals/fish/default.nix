{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''

       set fish_greeting (awk '
       BEGIN {
         getline < "/proc/uptime";
         uptime = $1;
         close("/proc/uptime");

         getline < "/proc/loadavg";
         load1 = $1; load5 = $2; load15 = $3;
         close("/proc/loadavg");

         users = 0;
         cmd = "who | wc -l";
         cmd | getline users;
         close(cmd);

         cmd = "date +\"%H:%M:%S\"";
         cmd | getline current_time;
         close(cmd);

         printf "%s up %d:%02d, %d users, load average: %.2f, %.2f, %.2f\n",
                current_time, uptime / 3600, uptime % 3600 / 60, users, load1, load5, load15;
       }')

       eval (direnv hook fish)
      COMPLETE=fish jj | source

    '';
  };

  home.packages = with pkgs; [
    fish
    git
    gnome-tweaks
    auto-cpufreq
    zsh
    oh-my-zsh
  ];
}
