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
apt upgrade
