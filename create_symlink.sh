#!/bin/sh

set -e
set -x

mkdir_if_not_exist () {
    local dir=$1
    if [ ! -d $dir ]; then
        mkdir -p $dir
    fi
}

# Emacs
mkdir_if_not_exist ~/.emacs.d
ln -sf ${PWD}/emacs/init.el ~/.emacs.d/init.el

## yasnippet
ln -sf ${PWD}/emacs/my_snippets ~/.emacs.d/

## auto-complete dictionary
ln -sf ${PWD}/emacs/ac-dict ~/.emacs.d/

## eshell
mkdir_if_not_exist ~/.emacs.d/eshell
ln -sf ${PWD}/emacs/eshell/alias ~/.emacs.d/eshell/

## Use Emacs.app instead of pre-installed emacs on MacOSX
EMACS_CLIENT_APP_PATH='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
case "$OSTYPE" in
    darwin*)
        echo "Set up for MacOSX"
        ln -sf ${EMACS_CLIENT_APP_PATH} ~/bin/emacsclient
        ;;
esac

# zsh
ln -sf $PWD/shell/zshrc ~/.zshrc
ln -sf $PWD/shell/functions ~/.zsh/

# tmux
ln -sf $PWD/shell/tmux.conf ~/.tmux.conf

# aspell
ln -sf $PWD/aspell.conf ~/.aspell.conf

# fonts
mkdir_if_not_exist ~/.config/fontconfig
ln -sf $PWD/evince/fonts.conf ~/.config/fontconfig/fonts.conf

# Spellunker
ln -sf $PWD/perl/spellunker.en ~/.spellunker.en

# Python
## REPL
ln -sf $PWD/python/pythonsetup ~/.pythonsetup
ln -sf $PWD/python/flake8 ~/.config/flake8

## ipython
IPYTHON_DIR=${HOME}/.config/ipython/profile_default
mkdir_if_not_exist ${IPYTHON_DIR}
ln -sf $PWD/python/ipython_config.py $IPYTHON_DIR

## golang
PECO_DIR=~/.peco
mkdir_if_not_exist ${PECO_DIR}
ln -sf $PWD/golang/config.json ${PECO_DIR}/config.json

# Ruby
ln -sf $PWD/ruby/gemrc ~/.gemrc
ln -sf $PWD/ruby/rubocop.yml ~/.rubocop.yml
ln -sf $PWD/ruby/pryrc ~/.pryrc

# For Common Lisp
ln -sf $PWD/common_lisp/clisprc.lisp ~/.clisprc.lisp
ln -sf $PWD/common_lisp/ccl-init.lisp ~/.ccl-init.lisp

# haskell
ln -sf $PWD/haskell/ghci ~/.ghci
