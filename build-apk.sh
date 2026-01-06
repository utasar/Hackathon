#!/bin/bash

# Build APK Script for Linux/Mac
# This script builds a release APK for the Flutter app

set -e

echo "======================================"
echo "  Building APK for Dual Auth App"
echo "======================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null
then
    echo "Error: Flutter is not installed or not in PATH"
    echo "Please install Flutter from https://flutter.dev"
    exit 1
fi

echo "Flutter version:"
flutter --version
echo ""

# Clean previous builds
echo "Cleaning previous builds..."
flutter clean
echo ""

# Get dependencies
echo "Getting Flutter dependencies..."
flutter pub get
echo ""

# Build the APK
echo "Building release APK..."
flutter build apk --release
echo ""

# Check if APK was created
if [ -f "build/app/outputs/flutter-apk/app-release.apk" ]; then
    echo "======================================"
    echo "  ✓ APK built successfully!"
    echo "======================================"
    echo ""
    echo "APK location: build/app/outputs/flutter-apk/app-release.apk"
    echo ""
    
    # Show APK size
    ls -lh build/app/outputs/flutter-apk/app-release.apk | awk '{print "APK size: " $5}'
    echo ""
else
    echo "Error: APK build failed"
    exit 1
fi
