apt update
apt install lsb-release wget software-properties-common gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x ./llvm.sh
./llvm.sh 14
apt update
apt install llvm-14 llvm-14-dev
apt install clang-14 libclang-14-dev
ln -sf /usr/bin/clang-14 /usr/bin/clang
ln -sf /usr/bin/clang++-14 /usr/bin/clang++
ln -sf /usr/bin/llc-14 /usr/bin/llc
ln -sf /usr/bin/llvm-config-14 /usr/bin/llvm-config
ln -sf /usr/bin/opt-14 /usr/bin/opt
ln -sf /usr/bin/clang-format-14 /usr/bin/clang-format
ln -sf /usr/bin/clang-tidy-14 /usr/bin/clang-tidy
ln -sf /usr/bin/llvm-as-14 /usr/bin/llvm-as
ln -sf /usr/bin/llvm-dis-14 /usr/bin/llvm-dis
ln -sf /usr/bin/llvm-mc-14 /usr/bin/llvm-mc
ln -sf /usr/bin/llvm-link-14 /usr/bin/llvm-link
ln -sf /usr/bin/llvm-nm-14 /usr/bin/llvm-nm
ln -sf /usr/bin/llvm-objdump-14 /usr/bin/llvm-objdump
ln -sf /usr/bin/llvm-ranlib-14 /usr/bin/llvm-ranlib
ln -sf /usr/bin/llvm-readobj-14 /usr/bin/llvm-readobj
ln -sf /usr/bin/llvm-size-14 /usr/bin/llvm-size
ln -sf /usr/bin/llvm-strip-14 /usr/bin/llvm-strip
ln -sf /usr/lib/llvm-14/lib/libLLVM-14.so /usr/lib/libLLVM.so
apt upgrade
PROFILE_D_FILE="/etc/profile.d/clang14.sh"
tee "$PROFILE_D_FILE" > /dev/null <<EOF
#!/bin/sh
# LLVM and Clang 14 environment variables
export LLVM_CONFIG=/usr/bin/llvm-config-14
export LLVM_CONFIG_PATH=/usr/bin/llvm-config-14
export LLVM_SYS_140_PREFIX=/usr/lib/llvm-14
export LD_LIBRARY_PATH=/usr/lib/llvm-14/lib:${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export CLANG=/usr/bin/clang-14
export CLANGXX=/usr/bin/clang++-14

export PATH=\$PATH:/usr/lib/llvm-14/bin
export LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:/usr/lib/llvm-14/lib
export LIBRARY_PATH=\${LIBRARY_PATH}:/usr/lib/llvm-14/lib
export C_INCLUDE_PATH=\${C_INCLUDE_PATH}:/usr/lib/llvm-14/include
export CPLUS_INCLUDE_PATH=\${CPLUS_INCLUDE_PATH}:/usr/lib/llvm-14/include
EOF

sudo chmod +x "$PROFILE_D_FILE"
