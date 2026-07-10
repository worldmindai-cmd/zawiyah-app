# Zawiyah 1.0 — Build and Submission Notes

## Important
This source package has been assembled without a Flutter SDK in the build environment. Before submission, run the commands below on the development Mac and resolve any analyzer/compiler findings.

## Validate
```bash
flutter clean
flutter pub get
flutter gen-l10n
flutter analyze
flutter test
```

## iOS
1. Open `ios/Runner.xcworkspace` in Xcode.
2. Select the correct Apple Developer Team.
3. Confirm bundle identifier `ai.zawiyah.zawiyah` is available, or replace it consistently.
4. Set version/build from `pubspec.yaml` (`1.0.0+1`).
5. Configure signing and capabilities.
6. Archive using a physical Release target and upload through Xcode Organizer.
7. Complete App Privacy answers. Current v1 stores devotional progress and onboarding role locally and does not contain advertising.

## Android
1. Create a Play upload key and `android/key.properties`.
2. Replace the temporary debug release signing fallback in `android/app/build.gradle.kts` with the upload signing configuration before Play upload.
3. Build:
```bash
flutter build appbundle --release
```
4. Upload `build/app/outputs/bundle/release/app-release.aab` to Play Console.

## Content review before release
- Confirm all Arabic, transliteration and English translations.
- Confirm Ayatollah Sistani references and wording.
- The Kahani content is labelled as a devotional/community tradition and must not be represented as authenticated history without review.
- No visual depictions of the Prophet (SAW), Lady Fatima (SA), or the Twelve Imams (AS).

## Store-review blockers to complete
- Hosted privacy policy URL.
- Support/contact URL.
- Final screenshots for required device sizes.
- Apple age rating and Google content rating.
- Release signing credentials.
- Scholar/content reviewer approval for public religious content.
