#!/bin/sh

# exit immediately if password-manager-binary is already in $PATH
type age >/dev/null 2>&1 && exit

# Variable for the age version
AGE_VERSION="1.1.1"


install_age() {
    # URL for the age release on GitHub
    AGE_URL="https://github.com/FiloSottile/age/releases/download/v${AGE_VERSION}/age-v${AGE_VERSION}-$1.tar.gz"

    # File name for the downloaded tarball
    TARBALL="age.tar.gz"

    # Destination directory for binaries
    DEST_DIR="$HOME/.local/bin"

    # Create the destination directory if it doesn't exist
    mkdir -p "$DEST_DIR"

    # Check if curl is available and use it to download the file
    if command -v curl >/dev/null 2>&1; then
        curl -Lo "$TARBALL" "$AGE_URL"
    elif command -v wget >/dev/null 2>&1; then
        wget -O "$TARBALL" "$AGE_URL"
    else
        echo "Error: curl or wget are not available. Please install one of these tools to proceed."
        exit 1
    fi

    # Verify if the download was successful
    if [ -f "$TARBALL" ]; then
        # Extract the tarball
        tar -xzf "$TARBALL" --strip-components=1 -C "$DEST_DIR" age/age age/age-keygen
        
        # Cleanup the tarball after extraction
        rm -f "$TARBALL"
    else
        echo "Error: download failed."
        exit 1
    fi
}

case "$(uname -s)" in
Darwin)
    install_age ""
    ;;
Linux)
    # commands to install password-manager-binary on Linux
    install_age "linux-amd64"
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac


