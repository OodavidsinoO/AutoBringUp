# AutoBringUp 🔄

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=flat&logo=gnu-bash&logoColor=white)

A powerful and flexible bash script that automates the Android ROM bringup process by handling file renaming and dependency updates across device trees.

## 🚀 One-Liner Installation & Run

```bash
bash <(curl -s https://raw.githubusercontent.com/OodavidsinoO/AutoBringUp/main/autobringup.sh)
```

*Or download and run:*
```bash
wget https://raw.githubusercontent.com/OodavidsinoO/AutoBringUp/main/autobringup.sh && bash autobringup.sh
```

## ✨ Features

- **Automated File Renaming**: Automatically renames `.dependencies` files and device makefiles
- **Content Replacement**: Updates all references to the old ROM name with the new one
- **Multi-Device Support**: Pre-configured for popular devices with easy customization
- **Custom Device Support**: Input any device tree path without modifying the script
- **Interactive Menu**: User-friendly terminal interface
- **Error Handling**: Comprehensive error checking and meaningful error messages

## 📋 Supported Devices

### Pre-Configured Devices
- **OnePlus 8T** (`kebab`) - `device/oneplus/kebab` & `device/oneplus/sm8250-common`
- **Moto G6** (`ali`) - `device/motorola/ali` & `device/motorola/msm8953-common`

### Custom Device Support
Add any device by providing the path format:
```
device_path:common_path:device_suffix
```

**Examples:**
- `device/xiaomi/fuxi:device/xiaomi/sm8550-common:fuxi`
- `device/samsung/m21:device/samsung/universal7870-common:m21`
- `device/realme/RMX1941:device/realme/mt6765-common:RMX1941`

## 🛠️ Usage

1. **Run the script** using the one-liner above
2. **Select your device** from the interactive menu
3. **Enter ROM names** when prompted:
   - Old ROM name (the one you're bringing up from)
   - New ROM name (the one you're bringing up to)

### Example Workflow
```bash
$ bash autobringup.sh
Select your device please: 
1) Oneplus8T
2) MotoG6
3) Custom
4) Quit
#? 1

Please enter the name of the old rom: lineageos
Please enter the name of the new rom: crdroid
```

## 🔧 What It Does

The script automates these tedious bringup tasks:

1. **Renames dependency files**:
   - `oldrom.dependencies` → `newrom.dependencies`

2. **Renames device makefiles**:
   - `oldrom_device.mk` → `newrom_device.mk`

3. **Updates file contents**:
   - Replaces all occurrences of the old ROM name with the new one
   - Processes both device-specific and common device directories

## 📁 File Structure

After running the script, your device tree will have:
```
device/
├── manufacturer/
│   ├── device-specific/
│   │   ├── newrom.dependencies
│   │   ├── newrom_device.mk
│   │   └── ... (other files with updated ROM names)
│   └── common/
│       ├── newrom.dependencies
│       └── ... (other files with updated ROM names)
```

## 🎯 Prerequisites

- Linux/macOS environment with bash
- Existing Android source tree
- Device trees already in place
- Basic understanding of ROM bringup process

## ⚠️ Important Notes

- **Backup your work** before running the script
- **Double-check ROM names** - incorrect names will cause file renaming issues
- Ensure you're in the **root of your Android source tree** when running the script
- The script will exit if device paths don't exist

## 🐛 Troubleshooting

### Common Issues

1. **"Path to device doesn't exist"**
   - Verify your device tree is properly synced
   - Check for typos in custom device paths

2. **"Device makefile not found"**
   - Ensure the device suffix matches your actual makefile naming
   - Check if the old ROM name is correct

3. **Permission denied errors**
   - Make the script executable: `chmod +x autobringup.sh`

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Add support for more pre-configured devices
- Improve error handling
- Add new features
- Report bugs and issues

## 📄 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](https://www.gnu.org/licenses/gpl-3.0.txt) file for details.

## ⚡ Quick Command Reference

```bash
# Download and run
curl -s https://raw.githubusercontent.com/OodavidsinoO/AutoBringUp/main/autobringup.sh | bash

# Or clone and run
git clone https://github.com/OodavidsinoO/AutoBringUp.git
cd AutoBringUp
bash autobringup.sh
```

---