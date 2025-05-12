**Step-by-Step Guide to Setting Up Your Odoo Environment**

To ensure a smooth installation of Odoo, follow these steps carefully. Make sure 
your internet connection is optimal for downloading necessary files.

1. **Set Environment Variables**  
   First, you need to modify the required variables to suit your setup:
   ```bash
   export GUEST_LINUX=xenial
   export PROGRAM_ODOO=odoo9
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
   Finally, execute the script to set up your Odoo environment:
   ```bash
   ./create_guest_os
   ```

6. **Wait for Completion**  
   Be patient as the script runs. Once it finishes, your computer will 
   automatically restart.

By following these steps, you will have a fully functional Odoo environment 
ready for use. Enjoy your new setup!

