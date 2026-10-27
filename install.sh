#!/bin/bash

# --no-folding links individual files rather than whole directories, so files
# that tools write at runtime (e.g. fish_variables) stay out of the repo
stow -t ~ -v --no-folding --ignore='install.sh' .
