# Quick Start Guide - APK Build System

## 🚀 Quick Build Commands

### Prerequisites Check
```bash
flutter --version  # Should be 3.16.0 or higher
java -version      # Should be 17 or higher
```

### Build APK - The Easy Way

**Linux/macOS:**
```bash
./build-apk.sh
```

**Windows:**
```cmd
build-apk.bat
```

**APK Location:** `build/app/outputs/flutter-apk/app-release.apk`

---

## 🛠️ Manual Build Steps

If you prefer to build manually:

```bash
# 1. Clean previous builds
flutter clean

# 2. Get dependencies
flutter pub get

# 3. Build APK
flutter build apk --release
```

---

## 🤖 CI/CD Automated Builds

### How to Trigger

**Automatic:**
- Push to `main`, `master`, or `develop` branch
- Create a pull request to these branches

**Manual:**
1. Go to GitHub → Actions tab
2. Select "Build Android APK" workflow
3. Click "Run workflow"
4. Choose branch and click "Run workflow"

### Download Built APK

1. Go to **Actions** tab in GitHub
2. Click on the latest workflow run
3. Scroll to **Artifacts** section
4. Download `app-release-apk`

---

## 📱 Install APK on Device

### Via USB (ADB)
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Via File Transfer
1. Copy APK to your Android device
2. Open file manager on device
3. Tap the APK file
4. Enable "Install from Unknown Sources" if prompted
5. Tap "Install"

---

## 🔧 Troubleshooting

### "Flutter not found"
Install Flutter: https://flutter.dev/docs/get-started/install

### "Command not found: ./build-apk.sh"
```bash
chmod +x build-apk.sh
```

### Build fails
```bash
flutter clean
flutter pub get
flutter build apk --release
```

---

## 📚 More Information

See [BUILD.md](BUILD.md) for comprehensive documentation.
