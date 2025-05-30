<<skrip_instalasi_debootstrap
* daftar variabel instalasi GUEST linux untuk Odoo dengan debootstrap
* author endro mei asmoro,endropbg@yahoo.com c 2025
* tujuan membuat sistem operasi GUEST distribusi linux debian dan turunannya 
skrip_instalasi_debootstrap
# daftar variabel global
# sistem operasi default adalah Ubuntu Xenial
GUEST_LINUX=xenial
PROGRAM_ODOO=Odoo10
DIREKTORI_AWAL=/media/mint/dataku1/chroot
# nama direktori default adalah xenialOdoo10
DIREKTORI_GUEST_LINUX=$DIREKTORI_AWAL/$GUEST_LINUX$PROGRAM_ODOO
WAKTU_TUNGGU=3
REPO_DEBOOTSTRAP=http://www.gtlib.gatech.edu/pub/ubuntu

buat_pagar() {
    echo -e "==========================================="    
}

buat_header() {
    buat_pagar
    echo -e "Ini adalah program instalasi $GUEST_LINUX"
    echo -e "direktori yang dituju adalah $DIREKTORI_GUEST_LINUX"
    buat_pagar      
    sleep $WAKTU_TUNGGU
}

buat_persiapan() {
echo -e  "buat direktori GUEST linux"
if ! [[ -d $DIREKTORI_GUEST_LINUX ]];then
    sudo mkdir $DIREKTORI_GUEST_LINUX
fi
echo -e "Sebelumnya pastikan bahwa komputer anda memiliki koneksi internet yang stabil."
echo -e "Install chroot dan debootstrap"
sudo apt install debootstrap
}

buat_installDeboostrap() {
echo -e "Menuju ke direktori $DIREKTORI_GUEST_LINUX"
cd $DIREKTORI_GUEST_LINUX
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
sudo mount -t none -o bind /tmp $DIREKTORI_GUEST_LINUX/tmp
}

buat_groupschroot() {
echo -e "Buat group schroot dan lain-lain"
sudo groupadd schroot
sudo gpasswd -a $(whoami) schroot
sudo gpasswd -a $(whoami) odoo
}

buat_konfigurasiGUESTlinux() {
    buat_pagar
    echo -e "Ini akan di lakukan di lingkungan $GUEST_LINUX"
    echo -e "Copy setelah tanda pagar yaitu diawali kata \"sudo chroot\" hingga exit"
    buat_pagar
echo -e sudo chroot $DIREKTORI_GUEST_LINUX
echo -e "apt-get install locales sudo nano wget
ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime"
echo -e "Konfigurasi repository debian untuk pembaruan paket $GUEST_LINUX"
echo -e "echo \" deb $REPO_DEBOOTSTRAP $GUEST_LINUX main restricted universe multiverse
    deb $REPO_DEBOOTSTRAP $GUEST_LINUX-updates main restricted universe multiverse
    deb $REPO_DEBOOTSTRAP $GUEST_LINUX-security main restricted universe multiverse
    deb $REPO_DEBOOTSTRAP $GUEST_LINUX-backports main restricted universe multiverse
    deb $REPO_DEBOOTSTRAP $GUEST_LINUX-proposed main restricted universe multiverse \" > /etc/apt/sources.list.d/repo$GUEST_LINUX.list"
echo -e "exit"
echo -e "setelah selesai ingat restart komputer"
}


## program utama 
buat_header
buat_persiapan
buat_installDeboostrap
buat_kaitkanKedirektoriGUESTlinux
buat_groupschroot
buat_konfigurasiGUESTlinux
