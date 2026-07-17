# Zawiyah — Google Play Closed Testing Setup Guide

Play Console setup is web-console-only (no API/CLI credentials are
configured for this project), so this is a walkthrough for you to
follow, not something I can do directly. The build itself is ready:
`build/app/outputs/bundle/release/app-release.aab` (rebuilt fresh,
signed with the `zawiyah-upload` key, verified with `jarsigner
-verify`).

## Before you start: check which testing rules apply to you

Google requires **new personal developer accounts** (created after
13 November 2023) to run a closed test with **12 testers opted in
continuously for 14 days** before they can apply for production
access. This does *not* apply if your account is organizational, or
was created before that date.

Check which you are: Play Console → **Account details** (bottom of
left sidebar) → look for the account creation date. If you're not
sure, Play Console will simply tell you when you eventually try to
apply for production — but knowing now shapes how many testers to
recruit and how long to plan for.

## 1. Create the app listing

Play Console → **Create app**:
- App name: `Zawiyah`
- Default language: English (US) — matches `en` as the app's default locale
- App or game: **App**
- Free or paid: **Free**
- Declarations: accept Developer Program Policies and US export laws

This creates the listing but doesn't publish anything yet.

## 2. Complete the required "App content" declarations

Play Console gates *any* release — including testing tracks — on
these being filled in first (**Policy → App content** in the left
sidebar). Everything needed is already prepared in this repo:

| Declaration | Where to get the answer |
|---|---|
| Privacy policy | `https://worldmindai-cmd.github.io/zawiyah-app/privacy-policy.html` |
| Ads | No ads (confirmed — no ad SDKs in `pubspec.yaml`) |
| Content rating questionnaire | Full answer key in `AGE_AND_CONTENT_RATINGS.md` |
| Target audience & content | Not primarily directed at children — see the judgment-call note in `AGE_AND_CONTENT_RATINGS.md` about the Young Zawiyah role |
| Data safety form | `docs/privacy-policy.html` has the full breakdown — in short: no data collected or shared, everything stored locally on-device |
| News apps / COVID-19 apps / Government apps | Not applicable to any of these |
| Financial features | Not applicable — no payments, lending, or crypto features |

## 3. Fill in the minimum store listing

Even for closed testing, Play Console wants a basic store listing
(**Grow → Store presence → Main store listing**):
- Short description, full description, keywords: `STORE_METADATA_DRAFT.md`
- Screenshots: `store_assets/screenshots/android-phone/` (already
  device-correct size for a phone listing)
- App icon: already in `android/app/src/main/res/mipmap-*/ic_launcher.png`
- Feature graphic (1024×500): not yet created — you'll need one before
  this section is marked complete; not something I've built yet

## 4. Set up the closed testing track

**Testing → Closed testing → Create track** (or use the default
"Closed testing" track Play Console offers):
1. Name it something like `Alpha`.
2. **Testers** tab → create an email list (Play Console calls this a
   "testers list") and add the actual people you want testing —
   real email addresses tied to real Google accounts, since they need
   to opt in from their own device.
3. **Releases** tab → **Create new release** → upload
   `build/app/outputs/bundle/release/app-release.aab` → write release
   notes (e.g. "First test build — onboarding, Morning A'māl, Kahani,
   Library, notifications. Several sections are placeholder content
   pending scholarly review, clearly labelled in-app.") → save →
   review → **Start rollout to Closed testing**.
4. Play Console gives you an **opt-in URL** once the release is live
   (Testers tab, top of page) — send that link to your testers. They
   open it, tap "Become a tester," then install from the regular Play
   Store app.

## 5. What to tell testers

Worth setting expectations up front, since several sections are
intentionally incomplete:
- Biographies (all 13) and 4 of 5 Kahanis are placeholder text pending
  scholarly sourcing — clearly labelled in-app, not a bug.
- Library sections beyond Collections/Biographies are "Coming soon"
  placeholders by design.
- Notification toggles save a preference but don't yet schedule
  anything (scheduling logic isn't built).

## 6. Before applying for production later

- If the 12-testers/14-days rule applies to your account, Play
  Console tracks this automatically — check **Dashboard** for
  progress once testers are opted in.
- Get the scholar sign-off from `CONTENT_REVIEW_PACKAGE.md` before
  promoting to production, not just before closed testing — testers
  seeing labelled placeholders is fine; production users seeing
  unreviewed religious content as if it were final is the thing to
  avoid.
