#!/bin/bash
clear && \

echo 
"

*******                                  **      **
 **   **                                 **      **
 **   **                                 **      **
 **   **   ******   ** ****    *****   ******  ******    ******
 ******   **    **  ***   **       **    **      **     **    **
 **   **  **    **  **    **   ******    **      **     **    **
 **   **  **    **  **    **  **    **   **      **     **    **
 **   **  **    **  **    **  **    **   ** **   ** **  **    **
*******    ******   **    **   *******    ****    ****   ******


"

echo "Instalando configurações para Kind no Vim" && \
echo "Curado por Sergio Bonatto" && \

sleep 60

git clone https://github.com/vim/vim.git && \

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \


cd ~/.vim/bundle/ && \ 
git clone https://github.com/jiangmiao/auto-pairs.git && \
git clone https://github.com/preservim/nerdtree.git && \
git clone https://github.com/vim-airline/vim-airline.git && \
git clone https://github.com/tpope/vim-fireplace.git && \
git clone https://github.com/sheerun/vim-polyglot.git && \
git clone https://github.com/wakatime/vim-wakatime.git && \
git clone https://github.com/turbio/bracey.vim  && \
git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git && \
git clone https://github.com/vim-airline/vim-airline-themes && \
git clone https://github.com/tpope/vim-fugitive.git && \
git clone https://github.com/frazrepo/vim-rainbow.git && \
git clone https://github.com/mattn/emmet-vim.git && \
git clone https://github.com/rstacruz/sparkup.git && \
git clone https://github.com/tpope/vim-commentary.git && \
git clone https://github.com/junegunn/vim-github-dashboard.git && \
git clone https://tpope.io/vim/sensible.git && \
git clone https://github.com/Yggdroot/indentLine.git  && \
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git && \
git clone https://github.com/ryanoasis/vim-devicons.git && \
git clone https://github.com/samueldurantes/vim-kind.git && \
git clone https://github.com/psliwka/vim-smoothie.git && \
git clone https://github.com/adelarsq/vim-matchit.git && \
git clone https://github.com/junegunn/vim-easy-align.git && \
git clone https://github.com/tiagofumo/vim-nerdtree-syntax-highlight.git && \
git clone https://github.com/honza/vim-snippets.git && \
git clone https://github.com/arthurxavierx/vim-unicoder.git && \
git clone https://github.com/preservim/nerdcommenter.git && \
git clone https://github.com/chrisbra/Colorizer.git && \
git clone https://github.com/drewtempelmeyer/palenight.vim.git && \
git clone https://github.com/gko/vim-coloresque.git && \
git clone https://github.com/rakr/vim-one.git && \


clear

echo "instalação finalizada"



