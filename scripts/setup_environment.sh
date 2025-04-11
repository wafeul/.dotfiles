# Ensure vim is set as the default editor for crontab
echo "Setting vim as the default editor for crontab..."
export VISUAL=vim
export EDITOR=vim

# Add to shell configuration if not already present
if ! grep -q 'export VISUAL=vim' ~/.bashrc; then
    echo "export VISUAL=vim" >> ~/.bashrc
fi

if ! grep -q 'export EDITOR=vim' ~/.bashrc; then
    echo "export EDITOR=vim" >> ~/.bashrc
fi

echo "vim has been set as the default editor for crontab. Please restart your terminal session to apply changes."
