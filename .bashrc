# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias fixpanel='kscreen-doctor output.2.mode.38'
alias cc='clear'
# Fastfetch - use Bazzite extras when available
if [ -x /usr/libexec/bazzite-bling-fastfetch ]; then
    alias ff='/usr/bin/fastfetch --color $(/usr/libexec/bazzite-bling-fastfetch) -c ~/.config/fastfetch/config.jsonc'
else
    alias ff='fastfetch -c ~/.config/fastfetch/config.jsonc'
fi
alias btreset='sudo modprobe -r btusb && sudo modprobe btusb'
alias ssh73='ssh pi@192.168.1.73'
alias ssh77='ssh rick@192.168.1.77'
alias ssh94='ssh rick@192.168.1.94'
alias ssh85='ssh godzilla@192.168.1.85'
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

ff
echo btreset
echo  
echo cd /var/home/rick/Projects
echo distrobox enter devbox
eval "$(starship init bash)"

# Clear screen after pressing Enter 3 times on empty prompt
