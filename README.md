**Step-by-Step Guide to Setting Up Odoo Development Environment With Debootstrap**

We must take 3 steps to setting up Odoo Development Environment Install Guest Operating System on Host then make configuration on it and Install Odoo from Debian package. Our goal are to running Odoo on Guest OS. In this example we are try to install Odoo 10.

**A. Install Guest Operating System With Debootstrap**
 
To ensure a smooth installation of Odoo, follow these steps carefully. Make sure 
your internet connection is optimal for downloading necessary files. Please use distribution linux Debian-based like Mint, Ubuntu, Debian ....


1. **Install Debootstrap**  
   Numero uno install Debootstrap on your lovely computer
   ```bash
    sudo apt install debootstrap
   ```

2. **Create a Directory**  
   Next, create a directory where the Odoo files will be stored:
   ```bash
   mkdir /home/chroot
   ```

3. **Clone the Repository**  
   Now, clone the Odoo technical repository from GitHub. This command will 
   download the latest version:
   ```bash
   git clone --depth 1 https://github.com/masterDev07/odootechnical
   ```

4. **Make the Script Executable**  
   After cloning, you need to make the script executable. This allows you to run 
   it without any permission issues:
   ```bash
   chmod +x create_guest_os.sh
   ```

5. **Run the Script**  
   Make correction on file create_guest_os.sh as you need. Finally, execute the script to set up your Odoo environment:
   ```bash
   ./create_guest_os.sh
   ```

6. **Wait for Completion**  
   Be patient as the script runs. Once it finishes, your computer will 
   automatically restart.


**B. Configure Guest OS**

To run Odoo 10 Guest OS on xenial, we need configuration our guest OS. We need chroot on our box. First we install chroot on our box and install schroot to simple execution for using chroot. Then we need make configuration on file /etc/schroot/chroot.d/sepuluh.conf.
 
1. **Install chroot and schroot**
   ```bash
    sudo apt install chroot schroot
   ```
   
2. **Create configuration file**
   ```bash
    [odoo10]
    description=xenial
    type=directory
    directory=/home/chroot/xenialodoo10
    profile=default
    groups=schroot
    users=your_username
    root-users=your_username
   ```


**C. Install Odoo from Debian package**

Now we can install everything on our guest OS like Odoo etc. First we must login to our box with command:
   ```bash
    schroot -c sepuluh
   ```

1. **Download Odoo 10 Debian package from nightly.com**
   ```bash
    wget https://nightly.odoo.com/10.0/nightly/deb/odoo_10.0.latest_all.deb
   ```
       
2. **Install Dependency for Odoo 10**
   ```bash
    sudo apt install adduser node-less postgresql-client python python-babel python-dateutil python-decorator python-docutils python-feedparser python-imaging python-jinja2 python-ldap python-libxslt1 python-lxml python-mako python-mock python-openid python-passlib python-psutil python-psycopg2 python-pychart python-pydot python-pyparsing python-pypdf python-reportlab python-requests python-suds python-tz python-vatnumber python-vobject python-werkzeug python-xlsxwriter python-xlwt python-yaml -y
   ```

To be Continue .....

By following these steps, you will have a fully functional Odoo Development environment ready for use. Enjoy your new setup!

