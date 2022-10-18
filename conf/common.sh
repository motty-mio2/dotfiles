#!/usr/bin/sh

export XDG_CONFIG_HOME="$HOME/.config"


# Rust
if [ -d "$HOME/.cargo/bin" ] ; then
    export PATH="$HOME/.cargo/bin:$PATH"
    RUSTC_WRAPPER="$(which sccache)"
    export RUSTC_WRAPPER
fi