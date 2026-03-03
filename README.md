# CodaSign

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A streamlined mobile application for managing digital signatures and signing PDF documents securely and efficiently.

---

## Prerequisites

Before running CodaSign locally, ensure you have the following installed:

| Tool               | Version                                       |
| ------------------ | --------------------------------------------- |
| **Flutter SDK**    | `>= 3.8.0`                                    |
| **Dart SDK**       | `>= 3.8.0`                                    |
| **Android Studio** | Latest stable (for Android emulator)          |
| **Xcode**          | Latest stable (for iOS simulator, macOS only) |

> **Tip:** Run `flutter doctor` to verify your environment is ready.

---

## Getting Started 🚀

### 1. Clone the Repository

```sh
git clone https://github.com/your-username/codasign.git
cd codasign
```

### 2. Install Dependencies

```sh
flutter pub get
```

### 3. Generate Code

CodaSign uses code generation for Freezed models, Drift database, and auto_route navigation. You **must** run this before building:

```sh
dart run build_runner build --delete-conflicting-outputs
```

### 4. Generate Localizations

```sh
flutter gen-l10n
```

---

## Running on a Local Emulator 📱

This project has 3 flavors: **development**, **staging**, and **production**.

### Android Emulator

1. **Launch an emulator** from Android Studio → Device Manager → Create/Start a virtual device.
2. Verify the emulator is detected:
   ```sh
   flutter devices
   ```
3. Run the app:

   ```sh
   # Development (recommended for local testing)
   flutter run --flavor development --target lib/main_development.dart

   # Staging
   flutter run --flavor staging --target lib/main_staging.dart

   # Production
   flutter run --flavor production --target lib/main_production.dart
   ```

### iOS Simulator (macOS only)

1. **Launch a simulator**:
   ```sh
   open -a Simulator
   ```
2. Run the app:
   ```sh
   flutter run --flavor development --target lib/main_development.dart
   ```

### Physical Device (USB Debugging)

1. **Enable Developer Mode** and **USB Debugging** on your Android phone (Settings → Developer Options).
2. Connect your phone via USB and authorize the computer.
3. Verify the device is detected:
   ```sh
   flutter devices
   ```
4. Run the app:
   ```sh
   flutter run --flavor development --target lib/main_development.dart
   ```

> **Note:** For physical iOS devices, you need to configure code signing in Xcode before running.

---

## Building APKs 🏗️

```sh
# Debug APK
flutter build apk --flavor development --target lib/main_development.dart

# Release APK
flutter build apk --flavor production --target lib/main_production.dart --release
```

The built APK will be at `build/app/outputs/flutter-apk/`.

---

## Project Structure 📁

```
lib/
├── app/
│   ├── commons/           # Shared widgets, extensions
│   ├── features/          # Feature modules
│   │   ├── document/      # PDF signing & document management
│   │   ├── home/          # Dashboard & overview
│   │   ├── settings/      # App settings
│   │   └── signature/     # Signature creation & library
│   ├── providers/         # Dependency injection
│   ├── router/            # Auto Route navigation
│   └── ui/                # Theme, colors, constants
├── core/
│   ├── data/              # Repository implementations, datasources
│   ├── domain/            # Models, repository interfaces
│   └── utils/             # Utilities
├── l10n/                  # Localization (EN, ID)
├── main_development.dart
├── main_staging.dart
└── main_production.dart
```

---

## Running Tests 🧪

```sh
# Run all tests
very_good test --coverage --test-randomize-ordering-seed random

# Generate coverage report
genhtml coverage/lcov.info -o coverage/
open coverage/index.html
```

---

## Working with Translations 🌐

CodaSign supports **English** and **Indonesian**.

- ARB files are located in `lib/l10n/arb/`
- Add new strings to `app_en.arb` and `app_id.arb`
- Regenerate with `flutter gen-l10n`

Usage in code:

```dart
import 'package:codasign/l10n/l10n.dart';

Text(context.l10n.signDocument);
```

---

## Tech Stack

| Category         | Tools                                                    |
| ---------------- | -------------------------------------------------------- |
| State Management | `flutter_bloc`, `bloc`                                   |
| Navigation       | `auto_route`                                             |
| Models           | `freezed`, `freezed_annotation`                          |
| PDF              | `syncfusion_flutter_pdf`, `syncfusion_flutter_pdfviewer` |
| DI               | `get_it`                                                 |
| Storage          | `shared_preferences`, `path_provider`                    |
| Error Handling   | `dartz` (Either pattern)                                 |

---

[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
