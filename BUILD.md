# APK Build System Guide

This document provides comprehensive information about the APK build system integrated into this repository.

## Overview

This repository includes a complete build system foundation for generating Android APKs from the Flutter application. The system supports both manual builds (local development) and automated CI/CD builds (GitHub Actions).

## Build System Components

### 1. Flutter Project Structure

The project follows the standard Flutter application structure:

```
Hackathon/
├── lib/
│   └── main.dart                   # Main application entry point
├── android/
│   ├── app/
│   │   ├── build.gradle            # App-level Gradle configuration
│   │   └── src/main/
│   │       ├── AndroidManifest.xml # Android manifest file
│   │       ├── kotlin/             # Kotlin source files
│   │       └── res/                # Android resources
│   ├── build.gradle                # Project-level Gradle configuration
│   ├── settings.gradle             # Gradle settings
│   └── gradle.properties           # Gradle properties
└── pubspec.yaml                    # Flutter dependencies
```

### 2. Build Scripts

#### build-apk.sh (Linux/macOS)
Shell script for building APKs on Unix-based systems.

**Usage:**
```bash
chmod +x build-apk.sh
./build-apk.sh
```

**What it does:**
- Checks for Flutter installation
- Cleans previous builds
- Fetches Flutter dependencies
- Builds the release APK
- Reports build status and APK location

#### build-apk.bat (Windows)
Batch script for building APKs on Windows systems.

**Usage:**
```cmd
build-apk.bat
```

**What it does:**
- Checks for Flutter installation
- Cleans previous builds
- Fetches Flutter dependencies
- Builds the release APK
- Reports build status and APK location

### 3. GitHub Actions CI/CD Workflow

Located at `.github/workflows/build-apk.yml`

**Triggers:**
- Push to `main`, `master`, or `develop` branches
- Pull requests targeting these branches
- Manual workflow dispatch

**Build Steps:**
1. Checkout repository
2. Set up Java 17 (Zulu distribution)
3. Set up Flutter 3.16.0 (stable channel)
4. Verify Flutter installation
5. Fetch Flutter dependencies
6. Run Flutter analyzer (optional)
7. Build release APK
8. Upload APK as artifact (30-day retention)
9. Upload APK metadata (optional)

**Accessing CI/CD Built APKs:**
1. Navigate to the "Actions" tab in GitHub
2. Select the workflow run
3. Download artifacts from the "Artifacts" section

## Prerequisites

### For Local Development

1. **Flutter SDK**
   - Version: 3.16.0 or higher
   - Download: https://flutter.dev/docs/get-started/install

2. **Java Development Kit (JDK)**
   - Version: 17
   - Download: https://www.oracle.com/java/technologies/downloads/

3. **Android SDK**
   - API Level: 34 (Android 14)
   - Included with Android Studio or available separately

4. **Android SDK Command-line Tools**
   - Required for building APKs
   - Install via Android Studio SDK Manager

### For CI/CD

No manual setup required. GitHub Actions automatically:
- Sets up Java 17
- Installs Flutter 3.16.0
- Configures Android SDK

## Build Variants

### Release Build
Optimized for production with code optimization and minification.

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Debug Build
Includes debugging symbols and is not optimized.

```bash
flutter build apk --debug
```

Output: `build/app/outputs/flutter-apk/app-debug.apk`

### Split APKs
Creates separate APKs for different CPU architectures (smaller file size).

```bash
flutter build apk --split-per-abi
```

Outputs:
- `app-armeabi-v7a-release.apk` (32-bit ARM)
- `app-arm64-v8a-release.apk` (64-bit ARM)
- `app-x86_64-release.apk` (64-bit Intel)

## App Configuration

### Application ID
- **Package Name:** `com.example.nwe`
- **Location:** `android/app/build.gradle`

### Version Information
- **Version Name:** 1.0.0
- **Version Code:** 1
- **Location:** `pubspec.yaml` (Flutter) and `android/app/build.gradle` (Android)

### Minimum SDK Requirements
- **Minimum SDK:** API 21 (Android 5.0 Lollipop)
- **Target SDK:** API 34 (Android 14)
- **Compile SDK:** API 34

### Permissions
Defined in `android/app/src/main/AndroidManifest.xml`:
- `INTERNET` - Network access
- `USE_BIOMETRIC` - Biometric authentication
- `USE_FINGERPRINT` - Fingerprint authentication (deprecated, for compatibility)

## Signing Configuration

Currently using **debug signing** for release builds. For production:

1. **Generate a signing key:**
```bash
keytool -genkey -v -keystore ~/my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
```

2. **Create `android/key.properties`:**
```properties
storePassword=<password>
keyPassword=<password>
keyAlias=my-key-alias
storeFile=/path/to/my-release-key.jks
```

3. **Update `android/app/build.gradle`:**
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

## Dependencies

### Flutter Dependencies
Defined in `pubspec.yaml`:
- `flutter` - Flutter SDK
- `cupertino_icons` - iOS-style icons
- `local_auth` - Biometric authentication
- `flutter_plugin_android_lifecycle` - Android lifecycle support

### Dev Dependencies
- `flutter_test` - Testing framework
- `flutter_lints` - Code linting rules

## Troubleshooting

### Build Fails with "Flutter not found"
**Solution:** Install Flutter SDK and add it to your system PATH.

### Gradle sync fails
**Solution:** 
1. Run `flutter clean`
2. Delete `android/.gradle` directory
3. Run `flutter pub get`
4. Rebuild

### APK installation fails on device
**Solution:**
1. Enable "Install from Unknown Sources" in device settings
2. Ensure device API level is 21 or higher
3. Check if package name conflicts with existing app

### CI/CD build fails
**Solution:**
1. Check GitHub Actions logs for detailed error messages
2. Ensure all required files are committed
3. Verify workflow YAML syntax

## Advanced Build Options

### Building for specific Android version
```bash
flutter build apk --target-platform android-arm64
```

### Building with obfuscation
```bash
flutter build apk --obfuscate --split-debug-info=/path/to/symbols
```

### Custom build flavor
Define flavors in `android/app/build.gradle`, then:
```bash
flutter build apk --flavor production
```

## Output Files

After a successful build, you'll find:

```
build/app/outputs/flutter-apk/
├── app-release.apk           # Main APK file
└── output-metadata.json      # Build metadata
```

The `output-metadata.json` contains:
- Application ID
- Version code and name
- Build variant information
- APK file information

## Continuous Integration Best Practices

1. **Branch Protection:** Set up branch protection rules for main branches
2. **Required Checks:** Make APK build a required status check
3. **Artifact Retention:** Adjust retention period based on needs (default: 30 days)
4. **Build Notifications:** Configure GitHub notifications for build failures
5. **Version Bumping:** Automate version increments in CI/CD

## Next Steps

To enhance the build system:

1. **Add Testing:** Integrate unit and widget tests in CI/CD
2. **Code Coverage:** Add code coverage reports
3. **App Signing:** Configure release signing for production
4. **Release Automation:** Auto-publish to Google Play Store
5. **Build Variants:** Add development, staging, and production flavors
6. **App Bundle:** Support Android App Bundle (AAB) format

## Support

For issues or questions:
- Check Flutter documentation: https://flutter.dev/docs
- Review GitHub Actions logs for CI/CD issues
- Consult Android developer documentation: https://developer.android.com

---

**Note:** This build system provides a foundation for APK generation. Customize it based on your specific requirements and deployment strategy.
