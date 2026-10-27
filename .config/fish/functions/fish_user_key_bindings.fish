function fish_user_key_bindings
  # older fzf (e.g. apt's) has no --fish, so stay quiet if it fails
  command -q fzf; and fzf --fish 2>/dev/null | source
end
