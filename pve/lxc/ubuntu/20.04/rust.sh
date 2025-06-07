#!/bin/bash
set -e

# 1. System dependencies
apt update
apt install -y curl build-essential pkg-config libssl-dev

# 2. Setup Rust environment variables
RUST_ENV_FILE="/etc/profile.d/rust.sh"
mkdir -p /opt/rust
export CARGO_HOME=/opt/rust/cargo
export RUSTUP_HOME=/opt/rust/rustup

# 3. Install rustup with proper env
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
    env CARGO_HOME=$CARGO_HOME RUSTUP_HOME=$RUSTUP_HOME sh -s -- -y --no-modify-path

# 4. Install toolchain and set default
/opt/rust/cargo/bin/rustup install stable
/opt/rust/cargo/bin/rustup default stable

# 5. Profile script for interactive users
cat <<EOF > "$RUST_ENV_FILE"
export CARGO_HOME=/opt/rust/cargo
export RUSTUP_HOME=/opt/rust/rustup
export PATH=/opt/rust/cargo/bin:\$PATH
EOF
chmod +x "$RUST_ENV_FILE"

# 6. Environment for non-interactive shells
if ! grep -q "/opt/rust/cargo/bin" /etc/environment; then
    sed -i 's|^PATH=|PATH=/opt/rust/cargo/bin:|' /etc/environment || echo "PATH=/opt/rust/cargo/bin:\$PATH" >> /etc/environment
    echo "CARGO_HOME=/opt/rust/cargo" >> /etc/environment
    echo "RUSTUP_HOME=/opt/rust/rustup" >> /etc/environment
fi

# 7. Make accessible for all users
chmod -R a+rx /opt/rust
