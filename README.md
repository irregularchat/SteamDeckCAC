# SteamDeckCAC
DOD CAC Reader on SteamOS (Arch)
[[Arch]] [[IrregularGithub]]
**Prerequisites:**

- Internet connection on your Steam Deck.
- Docking station with a keyboard, mouse, and CAC reader.

**Setting Up Steam Deck:**

1. Set a root password:
    
    - Run `passwd` in the terminal and set a password for the deck user.
2. Disable read-only mode:
    
    - Run `sudo btrfs property set -ts / ro false`.
3. Initialize the pacman keyring:
    
    - Run `sudo pacman-key --populate archlinux`.
4. Install any Arch Linux packages:
    
    - Use `sudo pacman -S *Package Name*` to install the desired packages.

**Setting Up CAC Middleware (Applies to all Arch Linux installations, including Steam OS on Steam Deck):**

1. Install CCID and OpenSC packages:
    
    - Run `sudo pacman -S ccid` and `sudo pacman -S opensc`.
2. For CAC readers without a keypad (typical USB reader):
    
    - Append "enable_pinpad=false" to the "/etc/opensc.conf" file.
3. Start and enable pcscd.service:
    
    - Run `pcscd`, and if you encounter issues, run `sudo systemctl restart pcscd.socket`.
4. Verify your smart card reader:
    
    - Install pcsc-tools with `sudo pacman -S pcsc-tools`.
    - Run `pcsc_scan` to check the status of your smart card reader.

**Configuring Firefox for Smart Card Authentication:**

1. Download the latest DOD CAC certificates:
    
    - Find and download the DOD CAC certificates. (e.g., [https://dl.dod.cyber.mil/wp-content/uploads/pki-pke/zip/unclass-certificates_pkcs7_v5-6_dod.zip](https://dl.dod.cyber.mil/wp-content/uploads/pki-pke/zip/unclass-certificates_pkcs7_v5-6_dod.zip))
2. Configure Firefox:
    
    - In Firefox, go to "Settings" > "Privacy & Security."
    - Under "Certificates," click "View Certificates."
    - Click "Import" and select the DOD CAC certificates file.
    - Trust DoD Root CA 2 for all purposes.
3. Configure Firefox to use the smart card reader:
    
    - In Firefox, go to "Security Devices" to open the Device Manager.
    - Enter a Module Name (e.g., "OpenSC").
    - Browse and select the "opensc-pkcs11.so" file.
    - Click "OK" in the Device Manager.
    - Visit a DOD CAC-enabled website and log in with your CAC.

These steps should help you set up DOD CAC Login on your Steam Deck running Arch Linux. Be aware that some websites may be optimized for Windows and may require additional steps for full compatibility.
