apt update
apt install lsb-release wget software-properties-common gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x ./llvm.sh
./llvm.sh 14
apt update
apt install llvm-14 llvm-14-dev
ln -sf $(which llvm-config-14) /usr/local/bin/llvm-config
