<<skrip_instalasi_debootstrap
* daftar variabel instalasi GUEST linux untuk Odoo dengan debootstrap
* author endro mei asmoro,endropbg@yahoo.com c 2025
* tujuan membuat sistem operasi GUEST distribusi linux debian dan turunannya 
skrip_instalasi_debootstrap
# daftar variabel global
GUEST_LINUX=xenial
PROGRAM_ODOO=odoo9
DIREKTORI_AWAL=/home/chroot
DIREKTORI_GUEST_LINUX=$DIREKTORI_AWAL/$GUEST_LINUX$PROGRAM_ODOO
WAKTU_TUNGGU=3
REPO_DEBOOTSTRAP=http://www.gtlib.gatech.edu/pub/ubuntu/

buat_pagar() {
    echo -e "==========================================="    
}

buat_header() {
    buat_pagar
    echo -e "Ini adalah program instalasi $GUEST_LINUX"
    echo -e "direktori yang dituju adalah $DIREKTORI_GUEST_LINUX"
    buat_pagar      
}

sleep $WAKTU_TUNGGU

buat_persiapan() {
echo -e  "buat direktori GUEST linux"
sudo mkdir $DIREKTORI_GUEST_LINUX
echo -e "Sebelumnya pastikan bahwa komputer anda memiliki koneksi internet yang stabil."
echo -e "Install chroot dan debootstrap"
sudo apt install chroot debootstrap
}

buat_installDeboostrap() {
echo -e "Menuju ke direktori $DIREKTORI_GUEST_LINUX"
chroot $DIREKTORI_GUEST_LINUX
echo -e "Mulai install $GUEST_LINUX dengan debootstrap"
echo -e "Tunggu proses hingga selesai beberapa menit kemudian"
sleep $WAKTU_TUNGGU
echo -e "Mulai instalasi $GUEST_LINUX di komputer"
sudo debootstrap $GUEST_LINUX $DIREKTORI_GUEST_LINUX $REPO_DEBOOTSTRAP
}

buat_kaitkanKedirektoriGUESTlinux() {
echo -e "Mount sysfs,proc,bind di $GUEST_LINUX"
sudo mount -t sysfs sysfs $DIREKTORI_GUEST_LINUX/sys
sudo mount -t proc proc $DIREKTORI_GUEST_LINUX/proc
sudo mount -o bind /dev $DIREKTORI_GUEST_LINUX/dev
echo -e "Copy file konfigurasi host ke $GUEST_LINUX"
sudo cp /etc/hosts $DIREKTORI_GUEST_LINUX/etc/hosts
sudo cp /etc/hostname $DIREKTORI_GUEST_LINUX/etc/hostname 
sudo cp /etc/apt/apt.conf $DIREKTORI_GUEST_LINUX/etc/apt/apt.conf
sudo mount -t none -o bind $DIREKTORI_GUEST_LINUX/tmp    
}

buat_konfigurasiGUESTlinux() {
    buat_pagar
    echo -e "Ini berada di sistem operasi GUEST $GUEST_LINUX"
    buat_pagar
echo -e "chroot ke direktori $GUEST_LINUX"
sudo chroot $DIREKTORI_GUEST_LINUX
echo -e "Install locales untuk koreksi konfigurasi localtime dan instalasi yang lain"
apt-get install locales sudo nano wget
echo -e "agar waktu komputer menjadi WIB"
ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
    echo -e "Konfigurasi repository debian untuk pembaruan paket $GUEST_LINUX"
    echo "deb $REPO_DEBOOTSTRAP $GUEST_LINUX main restricted universe multiverse
    deb $REPO_DEBOOTSTRAP $GUEST_LINUX-updates main restricted universe multiverse
    deb $REPO_DEBOOTSTRAP $GUEST_LINUX-security main restricted universe multiverse
    deb $REPO_DEBOOTSTRAP $GUEST_LINUX-backports main restricted universe multiverse
    deb $REPO_DEBOOTSTRAP $GUEST_LINUX-proposed main restricted universe multiverse" > /etc/apt/sources.list.d/repo$GUEST_LINUX.list    
}

buat_groupschroot() {
echo -e "Buat group schroot"
sudo groupadd schroot
sudo gpasswd -a $(whoami) schroot
}

buat_restatKomputer() {
echo -e "Reboot komputer"
echo -e "silakan tunggu sebentar"
sleep $WAKTU_TUNGGU
reboot    
}

## program utama 
buat_header
buat_persiapan
buat_installDeboostrap
buat_kaitkanKedirektoriTamulinux
buat_konfigurasiTamulinux
buat_groupschroot
buat_restatKomputer
