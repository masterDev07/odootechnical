# daftar variabel global
GUEST_LINUX=xenial
REPO_DEBOOTSTRAP=http://www.gtlib.gatech.edu/pub/ubuntu

# chroot berhasil login
echo -e "Install locales untuk koreksi konfigurasi localtime dan instalasi paket yang lain yang diperlukan"
apt-get install locales sudo nano wget
echo -e "agar waktu komputer menjadi WIB"
ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
    echo -e "Konfigurasi repository debian untuk pembaruan paket $GUEST_LINUX"
    echo "deb $REPO_DEBOOTSTRAP $GUEST_LINUX main restricted universe multiverse
    deb $REPO_DEBOOTSTRAP $GUEST_LINUX-updates main restricted universe multiverse
    deb $REPO_DEBOOTSTRAP $GUEST_LINUX-security main restricted universe multiverse
    deb $REPO_DEBOOTSTRAP $GUEST_LINUX-backports main restricted universe multiverse
    deb $REPO_DEBOOTSTRAP $GUEST_LINUX-proposed main restricted universe multiverse" > /etc/apt/sources.list.d/repo$GUEST_LINUX.list
echo -e "Hapus file create_repo_apt.sh"
rm -rf /create_repo_apt.sh
exit 
