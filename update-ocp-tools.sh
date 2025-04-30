#!/bin/bash

set -e

BIN_DIR="$HOME/bin"
CLIENT_BASE_URL="https://mirror.openshift.com/pub/openshift-v4/clients/ocp"
CLIENT_FILENAME="openshift-client-linux"
INSTALL_FILENAME="openshift-install-linux"

ensure_bin_exists() {
  if [ ! -d "$BIN_DIR" ]; then
    mkdir -p "$BIN_DIR"
  fi
}

download_and_extract() {
  local url="$1"
  local filename_base="$2"
  local archive_file="$BIN_DIR/$filename_base.tar.gz"

  echo "Downloading $filename_base..."
  wget -q "$url" -O "$archive_file"

  echo "Extracting $filename_base..."
  tar -xzf "$archive_file" -C "$BIN_DIR"

  echo "Removing archive $archive_file..."
  rm "$archive_file"

  if [ -f "$BIN_DIR/README.md" ]; then
    echo "Removing README.md..."
    rm "$BIN_DIR/README.md"
  fi
}

ensure_bin_exists

if [ -z "$1" ]; then
  # Latest version
  CLIENT_URL="$CLIENT_BASE_URL/latest/$CLIENT_FILENAME.tar.gz"
  INSTALL_URL="$CLIENT_BASE_URL/latest/$INSTALL_FILENAME.tar.gz"
elif [[ "$1" =~ ^[0-9]+\.[0-9]+$ ]]; then
  # Minor version provided (e.g., 4.18)
  CLIENT_URL="$CLIENT_BASE_URL/latest-$1/$CLIENT_FILENAME.tar.gz"
  INSTALL_URL="$CLIENT_BASE_URL/latest-$1/$INSTALL_FILENAME.tar.gz"
elif [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  # Full version provided (e.g., 4.18.4)
  CLIENT_URL="$CLIENT_BASE_URL/$1/$CLIENT_FILENAME.tar.gz"
  INSTALL_URL="$CLIENT_BASE_URL/$1/$INSTALL_FILENAME.tar.gz"
else
  echo "Invalid version format. Please use either 'latest', 'X.Y', or 'X.Y.Z'."
  exit 1
fi

download_and_extract "$CLIENT_URL" "$CLIENT_FILENAME"
download_and_extract "$INSTALL_URL" "$INSTALL_FILENAME"

echo "Successfully updated $CLIENT_FILENAME and $INSTALL_FILENAME in $BIN_DIR"
