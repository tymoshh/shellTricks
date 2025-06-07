#!/bin/bash

set -e

RUSTUP_INIT_URL="https://sh.rustup.rs"
RUST_ENV_FILE="/etc/profile.d/rust.sh"
RUST_BIN_DIR="/root/.cargo/bin"

mkdir -p /opt/rust
export CARGO_HOME=/opt/rust/cargo
export RUSTUP_HOME=/opt/rust/rustup

curl --proto '=https' --tlsv1.2 -sSf "$RUSTUP_INIT_URL" | sh -s -- -y --no-modify-path

cat <<EOF > "$RUST_ENV_FILE"
export CARGO_HOME=/opt/rust/cargo
export RUSTUP_HOME=/opt/rust/rustup
export PATH=/opt/rust/cargo/bin:\$PATH
EOF

chmod +x "$RUST_ENV_FILE"
echo "[*] Created $RUST_ENV_FILE"

# 3. Add to /etc/environment for non-interactive shells
if ! grep -q "/opt/rust/cargo/bin" /etc/environment; then
    sed -i 's|^PATH=|PATH=/opt/rust/cargo/bin:|' /etc/environment
    echo "CARGO_HOME=/opt/rust/cargo" >> /etc/environment
    echo "RUSTUP_HOME=/opt/rust/rustup" >> /etc/environment
    echo "[*] Updated /etc/environment"
fi

chmod -R a+rx /opt/rust
