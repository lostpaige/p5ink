# Pink Inky Diffusion

This project installs and runs a service that uses a diffusion model to creatively stylize images and display them on a [Pimoroni Inky Impression](https://shop.pimoroni.com/products/inky-impression) e-paper display. The service is designed to run automatically on startup, using photos from a designated folder as inputs, and it generates approximately three new stylized displays each day.

## Table of Contents
1. [Overview](#overview)  
2. [Features](#features)  
3. [Installation](#installation)  
4. [Usage](#usage)  
5. [Configuration](#configuration)  
6. [Dependencies](#dependencies)  
7. [License](#license)

---

## Overview
- The application uses photos from a folder (e.g. `photos/`) and applies a diffusion model to stylize them into various artistic forms (cartoonish, anime, noir, old-timey movie style, caricature, etc.).  
- The stylized outputs are never saved, but are sent directly to the Pimoroni Inky Impression screen.  
- The project includes a service file that ensures the application starts during device boot.  
- By default, the app attempts to generate roughly three trials per day (this can be customized, see [Configuration](#configuration) below).

---

## Features
- Automated startup on Raspberry Pi (via system service).  
- Periodic stylized image generation using a diffusion model.  
- Sends results straight to the Inky Impression e-paper display.  
- Customizable generation frequency.  
- Automated installation script available.

---

## Installation
1. **Prepare Raspberry Pi**  
   - Use a Raspbian Lite (minimal) operating system for best results.  
   - Enable networking and SSH as needed.

2. **Clone the Repository**  
   ```bash
   git clone https://github.com/your-user/pink-inky-diffusion.git
   cd pink-inky-diffusion
   ```

3. **Run Install Script**  
   - This project provides an `install.sh` script to automate installation of dependencies, creation of service files, etc.  
   - Make the script executable and run it:
     ```bash
     chmod +x install.sh
     ./install.sh
     ```
   - This script will install required packages (defined in `requirements.txt`), and register a system service file so that the app starts on boot.

4. **Reboot**  
   - After installation, reboot your Raspberry Pi to ensure the service starts automatically.

---

## Usage
- Once the service is active, it will periodically:
  1. Select a new photo from the `photos/` folder.  
  2. Pass it to the diffusion model to generate a stylized result.  
  3. Display the stylized image on your Inky Impression screen.  
- If you want to run the script manually (for testing or debugging), you can do so:
  ```bash
  python3 app.py
  ```
- Logs can typically be found in your system’s journal:
  ```bash
  journalctl -u pink-inky-diffusion.service
  ```

---

## Configuration
- **Image Folder**: By default, the app uses `photos/`. You can change the path in `app.py` if needed.  
- **Generation Frequency**: The app is currently set to produce ~3 generations per day. You can adjust this in `app.py` or in a configuration variable referenced there.  
- **Diffusion Styles**: You can tweak or add new styles by modifying the style list or diffusion model parameters in `app.py`.  

---

## Dependencies
- Python 3.x  
- Required Python libraries are listed in [`requirements.txt`](./requirements.txt).  
- Suitable drivers and libraries for the Pimoroni Inky Impression screen.  
- Additional dependencies may be installed by the `install.sh` script.

---

## License
[MIT License](LICENSE) or other license of your choosing.  

Feel free to modify, distribute, and adapt to suit your needs.
