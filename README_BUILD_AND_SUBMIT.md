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
1. Release signing is configured — `android/app/build.gradle.kts` loads `android/key.properties` (gitignored, not committed) and signs with the `zawiyah-upload` key. Both `key.properties` and `android/app/upload-keystore.jks` exist only on the machine that generated them; back them up somewhere durable, since losing them blocks future Play updates.
2. Build:
```bash
flutter build appbundle --release
```
3. Upload `build/app/outputs/bundle/release/app-release.aab` to Play Console.

## Content review before release
- Confirm all Arabic, transliteration and English translations.
- Confirm Ayatollah Sistani references and wording.
- The Kahani content is labelled as a devotional/community tradition and must not be represented as authenticated history without review.
- No visual depictions of the Prophet (SAW), Lady Fatima (SA), or the Twelve Imams (AS).

## Store-review blockers to complete
- ~~Hosted privacy policy URL.~~ https://worldmindai-cmd.github.io/zawiyah-app/privacy-policy.html
- ~~Support/contact URL.~~ https://worldmindai-cmd.github.io/zawiyah-app/support.html
- ~~Final screenshots for required device sizes.~~ `store_assets/screenshots/` — iPhone 17 Pro Max (6.9"), iPad Pro 13", Android phone (Pixel 8 Pro), 5 screens each (Home, Morning A'māl, Kahani, Library, More). Regenerate anytime with `integration_test/screenshot_flow_test.dart` via `flutter drive --driver=test_driver/integration_test.dart --target=integration_test/screenshot_flow_test.dart -d <device>`, capturing on each `SCREENSHOT_READY:<name>` stdout marker. Note: the iPad screenshots show the phone layout simply stretched to full width, not a tailored tablet layout — functional but not polished; worth a proper responsive pass before submission if that matters for the listing.
- Apple age rating and Google content rating — answer key in `AGE_AND_CONTENT_RATINGS.md`, still needs to actually be entered in App Store Connect / Play Console (only fillable live in each console).
- ~~Release signing credentials.~~ Generated — see Android section above.
- Scholar/content reviewer approval for public religious content — see `CONTENT_REVIEW_PACKAGE.md`.
- ~~App icon.~~ Real icon added — a mihrab (prayer-niche) with a lamp, gold on near-black, matching `zawiyah_colors.dart` and avoiding any figurative depiction per the Constitution. Generated via `flutter_launcher_icons` from `assets/icon/icon.png` (full-bleed, iOS/legacy Android) and `assets/icon/icon_foreground.png` (Android adaptive icon layer). Re-run `dart run flutter_launcher_icons` after editing either source file.
- ~~Feature graphic (Google Play, 1024×500).~~ `store_assets/feature_graphic.png`.
