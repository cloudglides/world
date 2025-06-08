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
        # Renumber windows when a window is closed
        set -g renumber-windows on

        # Enable activity alerts
        setw -g monitor-activity on
        set -g visual-activity on

        # Key bindings
        # Reload config file
        bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

        # Split panes using | and -
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        unbind '"'
        unbind %

        # New window in current path
        bind c new-window -c "#{pane_current_path}"

        # Switch panes using Alt-arrow without prefix
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # Resize panes with Prefix + Shift + Arrow
        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5

        # Status bar customization
        set -g status-bg colour234
        set -g status-fg colour137
        set -g status-position bottom
        set -g status-justify left
        set -g status-left ""
        set -g status-right '#[fg=colour233,bg=colour241,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S '
        set -g status-right-length 50
        set -g status-left-length 20

        # Window status
        setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '
        setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

        # Pane border colors
        set -g pane-border-style fg=colour238
        set -g pane-active-border-style fg=colour51

        # Message colors
        set -g message-style bg=colour166,fg=colour232

        # Copy mode
        setw -g mode-keys vi
        bind -T copy-mode-vi v send-keys -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

        # Don't exit copy mode after dragging with mouse
        unbind -T copy-mode-vi MouseDragEnd1Pane

        # Enable focus events for vim
        set -g focus-events on

        # True color support
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      '';

      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-vim 'session'
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-capture-pane-contents 'on'
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '15'
          '';
        }
        {
          plugin = yank;
          extraConfig = ''
            set -g @yank_selection_mouse 'clipboard'
          '';
        }
        sensible
      ];
    };

    # Ensure fish is available
    programs.fish.enable = mkDefault true;
  };
}
