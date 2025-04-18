# Function to check if DejaVuSansMono Nerd Font is installed
has_nerdfont() {
    fc-list | grep -qi "DejaVuSansMono"
}

if has_nerdfont; then
    USE_ICONS=true
    CHECK="[✅]"
    FAIL="[❌]"
    INFO="[ℹ️]]"
else
    USE_ICONS=false
    CHECK="[OK]"
    FAIL="[ERR]"
    INFO="[>>]"
fi

install_package() {
    if command -v apt &>/dev/null; then
        sudo apt update && sudo apt install -y "$@"
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y "$@"
    elif command -v yum &>/dev/null; then
        sudo yum install -y "$@"
    else
        echo "$FAIL No supported package manager found (apt/dnf/yum)."
        exit 1
    fi
}

NVM_VERSION="v0.40.2"
NODE_VERSION="22"
