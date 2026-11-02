#!/usr/bin/env bash
set -euo pipefail

PUB=$(orb -m control bash -c 'cat ~/.ssh/id_ed25519.pub')

for vm in "$@"; do
  echo "==> $vm"
  orb create ubuntu:noble "$vm"
  orb -m "$vm" sudo apt-get update -qq
  orb -m "$vm" sudo apt-get install -y -qq openssh-server python3
  orb -m "$vm" bash -c "mkdir -p ~/.ssh && echo '$PUB' > ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"
done