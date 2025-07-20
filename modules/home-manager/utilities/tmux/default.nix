{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options = {
    modules.utilities.tmux = {
      enable = mkEnableOption "tmux terminal multiplexer";
    };
  };

  config = mkIf config.modules.utilities.tmux.enable {
    programs.tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      terminal = "screen-256color";
      prefix = "C-a";
      mouse = true;
      baseIndex = 1;
      escapeTime = 0;
      historyLimit = 10000;

      extraConfig = ''
        # Default shell configuration
        set -g default-command ${pkgs.fish}/bin/fish
        set -g default-shell ${pkgs.fish}/bin/fish

        # Support logging out and back in
        set -g update-environment "SSH_ASKPASS SSH_AUTH_SOCK SSH_AGENT_PID SSH_CONNECTION"

        # Vi mode
        set-window-option -g mode-keys vi

        # If run as "tmux attach", create a session if one does not already exist
        new-session -n $HOST

        # Vi-like visual copy (updated syntax for modern tmux)
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

        # Set the prefix to ^A
        unbind C-b
        set -g prefix ^A
        bind a send-prefix

        # Open new stuff with correct CWD
        # Horizontal split
        unbind '"'
        bind | split-window -h -c "#{pane_current_path}"

        # Vertical split
        unbind %
        bind - split-window -v -c "#{pane_current_path}"

        # Set pane colors - highlight the active pane (updated syntax)
        set-option -g pane-border-style fg=colour60
        set-option -g pane-active-border-style fg=colour62

        # Colorize messages in the command line (updated syntax)
        set-option -g message-style bg=black,fg=brightred

        # Smart pane switching with awareness of vim splits
        bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
        bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
        bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
        bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"
        bind -n C-\ run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys 'C-\\') || tmux select-pane -l"

        bind C-l send-keys 'C-l'

        # Shortcuts
        bind - split-window -l 20 -c "#{pane_current_path}"
        bind _ split-window -l 20 -c "#{pane_current_path}" node

        # Status Bar
        set-option -g status on
        set -g status-interval 2
        set -g status-justify centre

        # Visual notification of activity in other windows
        setw -g monitor-activity on
        set -g visual-activity on

        # Show session name, window & pane number, date and time on right side
        set -g status-right "%b %d %Y @ %l:%M %p"

        # Split automatically on startup
        split-window -h -c "#{pane_current_path}"
        select-pane -L

        # Control automatic window renaming
        set-window-option -g automatic-rename on
        setw -g automatic-rename

        # Buffer management
        bind-key b list-buffers
        bind-key p choose-buffer
        bind-key x delete-buffer

        # Scrolling with terminal scroll bar
        set -g terminal-overrides 'xterm*:smcup@:rmcup@'

        # Pane resizing
        bind up resize-pane -U 5
        bind down resize-pane -D 5
        bind left resize-pane -L 5
        bind right resize-pane -R 5
        bind tab next-layout
        unbind C-o
        bind r rotate-window
        bind space select-pane -t:.+

        # Kill current pane/window
        bind-key q confirm-before kill-pane
        bind-key Q confirm-before kill-window

        # Monitor Activity
        bind m set-window-option monitor-activity

        # Window title
        set-option -g set-titles on
        set-option -g set-titles-string '#S:#I.#P #W'

        # Color scheme (styled as vim-powerline)
        set -g status-left-length 52
        set -g status-right-length 451
        set -g status-fg white
        set -g status-bg colour234
        set -g pane-border-style fg=colour245
        set -g pane-active-border-style fg=colour39
        set -g message-style fg=colour16,bg=colour221,bold

        # Pane resize in all four directions using vi bindings
        bind-key J resize-pane -D
        bind-key K resize-pane -U
        bind-key H resize-pane -L
        bind-key L resize-pane -R

        # Easily toggle synchronization
        bind e setw synchronize-panes on
        bind E setw synchronize-panes off

        # Screen like binding for last window
        unbind l
        bind C-a last-window

        # Reload key
        unbind R
        bind R source-file ~/.config/tmux/tmux.conf
      '';
    };

    # Ensure fish is available
    programs.fish.enable = mkDefault true;
  };
}
