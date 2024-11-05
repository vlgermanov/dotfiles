#!/usr/bin/env bash

set -e
set -o pipefail
set -o nounset

source "$(dirname "${BASH_SOURCE[0]}")"/functions.sh

pushd "$(dirname "${BASH_SOURCE[0]}")/../" >/dev/null

# check if $HOME/.config dir exists
if ! has_path "$HOME/.config"; then
    log_pending "Creating $HOME/.config folder"
    mkdir -p $HOME/.config
    test_path "$HOME/.config"
fi

# check if stow is present, if not try install it via brew
if ! has_command "stow"; then
    if ! has_command "brew"; then
        log_failure "Can not find 'stow' in PATH and can not install it via 'brew'!"
        exit 1
    else
        log_pending "Installing stow"
        brew install stow
        test_command "stow"
    fi
else
  log_pending "Setup dotfiles"
  stow .
fi

popd >/dev/null