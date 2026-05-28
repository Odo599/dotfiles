set fish_greeting
set -g fish_transient_prompt 1
set -g fish_key_bindings fish_vi_key_bindings

if status is-interactive
    abbr --add n nvim
    abbr --add c cd
    abbr --add exitup sudo tailscale set --exit-node=home-server
    abbr --add exitdown sudo tailscale set --exit-node=

    zoxide init --cmd cd fish | source
end
