# Hackathon - Dual Authentication

A Flutter-based dual authentication app for enhanced security.

Check out the demo on YouTube: [Watch Demo](https://youtube.com/shorts/J3sy4jwVp-c?si=-fJl2JioVJIRuMi3)

## Features

- Dual authentication system
- Biometric authentication support
- Modern Material Design UI

## Building the APK

### Prerequisites

- Flutter SDK (3.16.0 or higher)
- Java Development Kit (JDK 17)
- Android SDK (API level 34)

### Manual Build

#### On Linux/macOS:
```bash
./build-apk.sh
```

#### On Windows:
```cmd
build-apk.bat
```

The APK will be generated at: `build/app/outputs/flutter-apk/app-release.apk`

### Using Flutter Commands

```bash
# Install dependencies
flutter pub get

# Build release APK
flutter build apk --release

# Build debug APK
flutter build apk --debug

# Build split APKs per ABI (smaller file size)
flutter build apk --split-per-abi
```

## CI/CD Build System

This repository includes a GitHub Actions workflow that automatically builds the APK when:
- Code is pushed to `main`, `master`, or `develop` branches
- Pull requests are created targeting these branches
- Manually triggered via workflow dispatch

### Accessing Built APKs from CI/CD

1. Go to the "Actions" tab in the GitHub repository
2. Select the latest workflow run
3. Download the APK from the "Artifacts" section

The CI/CD workflow will:
- Build the release APK
- Run Flutter analyzer
- Upload the APK as an artifact (retained for 30 days)
- Upload build metadata

## Project Structure

```
Hackathon/
├── .github/
│   └── workflows/
│       └── build-apk.yml          # CI/CD workflow for APK building
├── android/                        # Android project files
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── AndroidManifest.xml
│   │   │   └── kotlin/
│   │   └── build.gradle
│   ├── build.gradle
│   └── settings.gradle
├── lib/
│   └── main.dart                   # Flutter app entry point
├── build-apk.sh                    # Build script for Linux/Mac
├── build-apk.bat                   # Build script for Windows
├── pubspec.yaml                    # Flutter dependencies
└── README.md
```

## Development

### Running the App

```bash
# Run in debug mode
flutter run

# Run in release mode
flutter run --release
```

### Testing

```bash
# Run tests
flutter test

# Analyze code
flutter analyze
```

## License

This project was created for the Hackathon event.
