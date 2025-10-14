# Surverior Frontend Mobile

Surverior mobile application built with Flutter.

## Requirements

- Flutter SDK (version 3.32.6)
- FVM (Flutter Version Manager)
- Android Studio / Xcode (depending on target platform)
- Git

## Setup and Installation

This project uses FVM (Flutter Version Manager) to ensure consistent Flutter SDK versions across all development environments.

### Installing FVM

#### macOS

```bash
# Using Homebrew
brew tap leoafarias/fvm
brew install fvm

# Using Dart
dart pub global activate fvm
```

#### Windows

```powershell
# Using Dart
dart pub global activate fvm

# Make sure to add the FVM path to your PATH environment variable:
# %LOCALAPPDATA%\Pub\Cache\bin
```

Alternatively, you can install FVM using Chocolatey:

```powershell
# Install Chocolatey if not already installed
# Run in an Admin PowerShell:
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install FVM using Chocolatey
choco install fvm
```

#### Linux

```bash
# Using Dart
dart pub global activate fvm

# Make sure to add the FVM path to your PATH:
# Add this to your ~/.bashrc or ~/.zshrc
# export PATH="$PATH":"$HOME/.pub-cache/bin"
```

### Project Setup

1. Clone the repository

```bash
git clone https://github.com/Surverior/surverior_frontend_mobile.git
cd surverior_frontend_mobile
```

2. Install the correct Flutter version using FVM

```bash
fvm install
```

3. Use FVM to run Flutter commands

```bash
fvm flutter pub get
```

### Android Setup

1. Install Android Studio

   - Download and install from [Android Studio website](https://developer.android.com/studio)
   - Make sure to install Android SDK during setup

2. Configure Android SDK

   - Open Android Studio
   - Go to Settings/Preferences > Appearance & Behavior > System Settings > Android SDK
   - Install Android SDK Platform Tools, Android SDK Build-Tools
   - Install at least one Android SDK Platform (e.g., Android 13.0)

3. Create/Configure an Android Virtual Device (AVD)

   - Open Android Studio
   - Go to Tools > AVD Manager
   - Click "Create Virtual Device" and follow the wizard

4. Run the app on Android

```bash
fvm flutter run
```

### iOS Setup (Mac only)

1. Install Xcode from the App Store

2. Install CocoaPods

```bash
sudo gem install cocoapods
```

3. Set up iOS simulator or device

```bash
# Open iOS Simulator
open -a Simulator

# Or run directly
fvm flutter run -d ios
```

## Troubleshooting

### Common Issues

- **FVM command not found**: Make sure the FVM binary directory is in your PATH
- **Flutter SDK not found**: Run `fvm install` to install the correct Flutter version
- **Android SDK not found**: Make sure to set the ANDROID_HOME environment variable
- **iOS build fails**: Make sure Xcode Command Line Tools are installed (`xcode-select --install`)

### Flutter Doctor

Run Flutter Doctor to diagnose issues:

```bash
fvm flutter doctor -v
```

## Development

### Project Structure

```
lib/
  ├── main.dart          # Application entry point
  ├── pages/             # All app screens
  ├── providers/         # State management
  ├── utils/             # Utility functions
  └── widgets/           # Reusable UI components
```

### Building for Release

#### Android

```bash
fvm flutter build apk --release
# or
fvm flutter build appbundle --release
```

#### iOS

```bash
fvm flutter build ios --release
# Then archive using Xcode
```

## Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [FVM Documentation](https://fvm.app/docs/getting_started/overview)
- [Dart Package Documentation](https://pub.dev/)
