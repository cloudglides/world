{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting (awk '
      BEGIN {
        # Get system uptime
        getline < "/proc/uptime";
        uptime = $1;
        close("/proc/uptime");

        # Get load averages
        getline < "/proc/loadavg";
        load1 = $1; load5 = $2; load15 = $3;
        close("/proc/loadavg");

        # Get user count
        users = 0;
        cmd = "who | wc -l";
        cmd | getline users;
        close(cmd);

        # Get local time using date
        cmd = "date +\"%H:%M:%S\"";
        cmd | getline current_time;
        close(cmd);

        # Print output like uptime
        printf "%s up %d:%02d, %d users, load average: %.2f, %.2f, %.2f\n",
               current_time, uptime / 3600, uptime % 3600 / 60, users, load1, load5, load15;
      }')
    '';
  };
}

