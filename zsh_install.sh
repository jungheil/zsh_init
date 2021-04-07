#! /bin/bash


function check_sudo() {
    sudo echo "[ INSTALL VIM ] Install for $1" || { echo "[ INSTALL VIM ] sudo not found"; exit 1; }
}


if [ $(uname) == "Linux" ]; then
    if cat /etc/*release | grep ^NAME | grep Ubuntu 1>/dev/null 2>&1; then
        check_sudo "Ubuntu"
        sudo apt install -y git curl zsh tmux
        sudo chsh -s /bin/zsh
    else
        echo "[ INSTALL VIM ] OS not support, exiting installation!"
        exit 3
    fi
elif [ $(uname) == "Darwin" ]; then
    check_sudo "MacOS"
    brew install tmux
else
    echo "[ INSTALL VIM ] Unknown OS $(uname), exiting installation!"
    exit 3
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | grep -v exec)" && \

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || \
exit 1

if [ $(uname) == "Linux" ]; then
    sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"agnoster\"/g" $HOME/.zshrc && \
    sed -i "s/# DISABLE_MAGIC_FUNCTIONS=\"true\"/DISABLE_MAGIC_FUNCTIONS=\"true\"/g" $HOME/.zshrc && \
    sed -i "s/plugins=(git)/plugins=(git z extract sudo command-not-found safe-paste tmux history zsh-syntax-highlighting zsh-autosuggestions)/g" $HOME/.zshrc || \
    exit 2
elif [ $(uname) == "Darwin" ]; then
    sed -i "" "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"agnoster\"/g" $HOME/.zshrc && \
    sed -i "" "s/# DISABLE_MAGIC_FUNCTIONS=\"true\"/DISABLE_MAGIC_FUNCTIONS=\"true\"/g" $HOME/.zshrc && \
    sed -i "" "s/plugins=(git)/plugins=(git z extract sudo command-not-found safe-paste tmux history zsh-syntax-highlighting zsh-autosuggestions)/g" $HOME/.zshrc || \
    exit 2
else
    echo "[ INSTALL VIM ] Unknown OS $(uname), exiting installation!"
    exit 3
fi

echo -e "\033[32mFinish!\033[0m"
