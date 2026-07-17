# Zawiyah — Age & Content Rating Worksheet (v1.0.0)

Both App Store Connect and Google Play Console only let you fill these
out live, inside their consoles (no way to submit them from outside).
This is a pre-filled answer key based on what's actually in the app,
so you can click through the real forms quickly instead of re-deriving
each answer from scratch. Verified against Apple's current
[age rating categories](https://developer.apple.com/help/app-store-connect/reference/app-information/age-ratings-values-and-definitions/)
(July 2026) — Google's exact IARC question wording isn't published
outside the live questionnaire, so that section uses the standard
IARC category names and may differ slightly in phrasing from what you
see on screen.

## The two things that need a judgment call, not just a checkbox

**1. The la'nat (curse) wording.** Neither platform's questionnaire has
a category for "cursing specific historical/religious figures" — it's
not violence, not profanity in the vulgar sense, not sexual content.
It'll register as "None" on every literal category below. But it's
real content (`fatima_zikr` section: *"O Allah, curse those who
oppressed Lady Fatima al-Zahra (SA) and those who usurped her
rights"*), and it's sectarian-specific in a way that could surprise a
human reviewer with no context. Recommend adding a line to the
reviewer notes field (both stores have one) along the lines of: *"This
app includes a traditional Shia devotional counter (du'a) that
includes a religious imprecation against historical figures understood
in Shia tradition to have wronged the Prophet's daughter. This is
standard, widely-practiced Shia devotional content, not content
directed at any living person or group."* Better to explain it than to
have it discovered cold.

**2. The "Child / Young Zawiyah" onboarding role.** This doesn't make
Zawiyah a kids' app — it's one of 7 roles alongside "Daily worshipper,"
"Scholar," etc., and choosing it doesn't collect any data about a
child (per `docs/privacy-policy.html`, the choice itself is the only
thing stored, locally). Google Play in particular has a strict
**Families Policy** that applies extra rules if an app is *"primarily
child-directed."* Zawiyah isn't — recommend answering "No" to any
"is this app designed for children" / "primarily directed at
children" question. If a Young Zawiyah *feature* (not just an
onboarding role) gets built later with real content, revisit this.

## Apple App Store Connect

Apple's system is a calculated score from these questions, not a
free choice — you answer, it computes 4+/9+/13+/16+/18+ equivalent.

| Category | Sub-item | Answer | Why |
|---|---|---|---|
| Mature Themes | Profanity or Crude Humor | None | No profanity anywhere in the app. |
| Mature Themes | Horror/Fear Themes | None | Martyrdom narratives (Ashura, Karbala) are told reverently, not graphically — no gore, no jump-scare framing. Recheck if the still-unwritten Ali Asghar kahani ends up vivid. |
| Mature Themes | Alcohol, Tobacco, or Drug Use or References | None | Not present. |
| Medical or Wellness | Medical or Treatment Information | None | Not present. |
| Medical or Wellness | Health or Wellness Topics | None | Not present. |
| Sexuality or Nudity | Mature or Suggestive Themes / Sexual Content or Nudity / Graphic | None | Not present anywhere. |
| Violence | Cartoon/Fantasy, Realistic, Prolonged Graphic, Guns/Weapons | None | No depicted violence — the Constitution explicitly bans visual depiction of the Prophet (SAW), Lady Fatima (SA), and the Twelve Imams (AS), so there's no imagery to begin with, and text descriptions of historical events aren't graphic. |
| Chance-Based Activities | Gambling, Simulated Gambling, Contests, Loot Boxes | None | Not present. |
| Capabilities | Unrestricted Web Access | No | No embedded browser; `http` dependency exists for future features, unused for browsing in v1. |
| Capabilities | User-Generated Content | No | Personal Collections are private and local-only — no sharing/publishing UI exists (the `is_shared_anonymously` DB column is unused). |
| Capabilities | Social Media / Social Media Disabled Under 13 | Not applicable | No social media integration. |
| Capabilities | Messaging and Chat | No | No user-to-user communication of any kind. |
| Capabilities | Advertising | No | Confirmed no-ads throughout `STORE_METADATA_DRAFT.md` and the privacy policy. |
| In-App Controls | Parental Controls / Age Assurance | No | Not built. |

Expected result: this should calculate to Apple's lowest tier (4+
equivalent). If the calculator lands anywhere higher, something above
was answered differently than intended — worth double-checking rather
than accepting it.

## Google Play Console (IARC questionnaire)

| Category | Answer | Why |
|---|---|---|
| Violence | None | No depicted violence; see Apple's Violence row above for the same reasoning. |
| Sexual Content | None | Not present. |
| Language / Profanity | None | Not present. |
| Controlled Substances (alcohol/tobacco/drugs) | None | Not present. |
| Gambling | None (real or simulated) | Not present. |
| User Interaction — shares location | No | No location access at all. |
| User Interaction — shares personal info | No | No account, no personal data collected (see `docs/privacy-policy.html`). |
| User Interaction — digital purchases | No | No IAP dependencies in `pubspec.yaml`, nothing to purchase in v1. |
| User Interaction — unrestricted internet / UGC / chat | No | Same as Apple's Capabilities section above. |
| "Primarily directed at children" (Families Policy trigger) | No | See judgment call #2 above. |

Expected result: lowest IARC tier across all regional systems (ESRB
Everyone, PEGI 3, USK 0, etc.).

## After submitting

Both platforms let you re-run the questionnaire if content changes.
Re-visit this worksheet (and update it) if:
- The Young Zawiyah section moves from placeholder to a real,
  built feature.
- Any of the remaining Kahani placeholders (Sakina, Abbas, Ali Asghar,
  Zainab) get sourced content that includes more vivid/graphic
  descriptions of the martyrdoms than the Fatima kahani's tone.
- Collections gain a public-sharing feature (the `is_shared_anonymously`
  column suggests this was planned) — that would flip the
  User-Generated Content answer to "Yes" on both platforms.
