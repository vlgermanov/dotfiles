#!/usr/bin/env bash

color_reset=$(tput sgr0)
color_red=$(tput setaf 1)
color_green=$(tput setaf 2)
color_yellow=$(tput setaf 3)
color_blue=$(tput setaf 4)

has_command() {
  if [ $(type -P $1) ]; then
    return 0
  fi
  return 1
}

test_command() {
  if has_command $1; then
    log_success "$1"
  else
    log_failure "$1"
  fi
}

has_brew() {
  if $(brew ls --versions $1 > /dev/null); then
    return 0
  fi
  return 1
}

test_brew() {
  if has_brew $1; then
    log_success "$1"
  else
    log_failure "$1"
  fi
}

has_path() {
  local path="$@"
  if [ -e "$path" ]; then
    return 0
  fi
  return 1
}

test_path() {
  if has_path $1; then
    log_success "$1"
  else
    log_failure "$1"
  fi
}

log_failure() {
    printf "\n"
    printf "${color_red}🔴  %s${color_reset}" "$@" >&2
    printf "\n"
}

log_message() {
    printf "\n"
    printf "${color_blue}✨  %s${color_reset}" "$@"
    printf "\n"
}

log_pending() {
    printf "\n"
    printf "${color_yellow}⏳  %s...${color_reset}" "$@"
    printf "\n"
}

log_success() {
    printf "\n"
    printf "${color_green}🟢  %s${color_reset}" "$@"
    printf "\n"
}
