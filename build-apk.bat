@echo off
REM Build APK Script for Windows
REM This script builds a release APK for the Flutter app

echo ======================================
echo   Building APK for Dual Auth App
echo ======================================
echo.

REM Check if Flutter is installed
where flutter >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Error: Flutter is not installed or not in PATH
    echo Please install Flutter from https://flutter.dev
    exit /b 1
)

echo Flutter version:
flutter --version
echo.

REM Clean previous builds
echo Cleaning previous builds...
flutter clean
echo.

REM Get dependencies
echo Getting Flutter dependencies...
flutter pub get
echo.

REM Build the APK
echo Building release APK...
flutter build apk --release
echo.

REM Check if APK was created
if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo ======================================
    echo   APK built successfully!
    echo ======================================
    echo.
    echo APK location: build\app\outputs\flutter-apk\app-release.apk
    echo.
) else (
    echo Error: APK build failed
    exit /b 1
)
