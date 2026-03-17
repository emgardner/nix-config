programs.tmux = {
  enable = true;
  extraConfig = '' 
  # New vertical split (prefix + %) in the current directory
  bind % split-window -h -c "#{pane_current_path}"
  
  # New horizontal split (prefix + ") in the current directory
  bind '"' split-window -v -c "#{pane_current_path}"
  
  # New window (prefix + c) in the current directory
  bind c new-window -c "#{pane_current_path}"

  '';
}
