# Gradle Build System Setup

## Summary of Changes

This PR adds the necessary Gradle build configuration files to resolve the GitHub Actions workflow failure. The workflow was failing with the error:

```
No file in /home/runner/work/Hackathon/Hackathon matched to [**/*.gradle*,**/gradle-wrapper.properties,buildSrc/**/Versions.kt,buildSrc/**/Dependencies.kt,gradle/*.versions.toml,**/versions.properties]
```

## Files Added

### Core Gradle Configuration
1. **settings.gradle** - Defines the project structure and included modules
2. **build.gradle** - Root-level build configuration with Android Gradle Plugin
3. **gradle.properties** - Project-wide Gradle settings and build optimizations
4. **app/build.gradle** - Android app module build configuration

### Gradle Wrapper
5. **gradle/wrapper/gradle-wrapper.properties** - Gradle wrapper configuration (Gradle 7.6)
6. **gradle/wrapper/gradle-wrapper.jar** - Gradle wrapper JAR file
7. **gradlew** - Gradle wrapper script for Unix/Linux/macOS
8. **gradlew.bat** - Gradle wrapper script for Windows

### Android Configuration
9. **app/src/main/AndroidManifest.xml** - Minimal Android manifest for the app
10. **app/proguard-rules.pro** - ProGuard configuration for code optimization

### Build Artifacts Control
11. **.gitignore** - Configured to exclude build artifacts while preserving existing APK files

## Build System Details

- **Build Tool**: Gradle 7.6
- **Android Gradle Plugin**: 7.4.2
- **Java Compatibility**: Java 8 (source and target)
- **Android SDK**:
  - Compile SDK: 33
  - Min SDK: 21
  - Target SDK: 33
- **Dependencies**:
  - AndroidX AppCompat 1.6.1
  - Material Design Components 1.9.0

## Resolution of CI Issue

The GitHub Actions workflow was using `cache: 'gradle'` in the `actions/setup-java@v4` step, which performs a search for Gradle files matching specific patterns. Without any Gradle files present, the workflow failed during the setup phase.

With these files in place, the workflow will now:
1. Successfully detect Gradle files for caching
2. Properly configure the Java environment
3. Be able to execute Gradle build commands

## Testing

The Gradle wrapper was tested locally and successfully:
- Downloads and installs Gradle 7.6
- Properly initializes the Gradle daemon
- Recognizes the project structure

Network limitations in the sandboxed environment prevented full build testing, but the GitHub Actions environment will have proper network access to download dependencies.

## Next Steps

When this PR is merged or when workflows run on this branch, they should now:
1. Successfully cache Gradle dependencies
2. Be able to run Gradle build commands
3. Build the Android application if source code is added

The project is now set up as a minimal Android application using Gradle, ready for further development.
