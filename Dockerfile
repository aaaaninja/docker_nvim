FROM ubuntu

SHELL [ "/bin/bash", "-c" ]
RUN apt update && apt upgrade -y && apt install -y busybox-static git build-essential && cd /usr/local/bin/ \
  && busybox wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz \
  && tar xf nvim-linux64.tar.gz && ln -s $PWD/nvim-linux64/bin/nvim nvim \
  && mkdir -p $HOME/.config && mkdir -p $HOME/.cache/dein \
  && cd $HOME && busybox wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh && sh installer.sh $HOME/.cache/dein \
  && git clone https://github.com/k1nPr45b0/nvim_config.git $HOME/.config/nvim

# 参考 => https://github.com/Shougo/dein.vim/issues/314
RUN nvim -N -c 'try | finally | qall! | endtry' -es -u $HOME/.config/nvim/init.vim
