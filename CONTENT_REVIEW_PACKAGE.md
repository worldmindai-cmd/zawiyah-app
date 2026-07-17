# Zawiyah — Content Review Package (v1.0.0)

This is the "Content Authority document" flagged as needed in
`morning_aamal_content.dart`, and the material referenced as a
store-submission blocker in `README_BUILD_AND_SUBMIT.md`
("Scholar/content reviewer approval for public religious content").

## How to use this document

Every religious/devotional text string that ships in Zawiyah v1.0.0
is reproduced below, grouped by how it got into the app and what kind
of review it needs. Nothing here has been altered, paraphrased, or
generated to fill this document — text is copied verbatim from the
source files (cited by path) so a reviewer can check it against the
running app.

For each item needing review, please indicate:
1. **Approved as-is**, or
2. **Approved with correction** (please provide the corrected wording), or
3. **Not appropriate for the app** (please note why, so it can be removed or reworked)

Three sections, in priority order:
- **A — Ready for review**: real content with known provenance.
- **B — Flagged gaps**: specific discrepancies found while assembling
  this package that need a decision before/alongside review.
- **C — Not ready for review**: placeholder text only. Nothing to
  review yet; needs primary sourcing first. Listed so the reviewer
  knows what's coming, not to review now.

---

## A — Ready for review

### A1. Morning A'māl routine
*Source: `lib/features/morning_aamal/data/morning_aamal_content.dart`*

Ali's own personal, accumulated devotional routine (kept in iOS Notes
for years, organised into this app's structure). It mixes named,
traditionally-sourced recitations with personally-compiled wasila/
hajat wording. Splitting those two categories below, since they need
different kinds of review — one is "is this transcribed correctly,"
the other is "is this wording appropriate to publish for other
users," not just for Ali's private use.

#### A1a. Named/traditional recitations (check transcription accuracy)

These are referenced by name only in the app (the full texts are not
bundled yet — see Library screen and Gap B3 below) — recite/pray with
intention for:
- Ziyarat-e-Warisa
- Ziyarat-e-Ashura
- Ziyarat-e-Arbaeen
- Nafilat al-Fajr, Fajr, Namaz-e-Hadiya, Namaz-e-Walidayn, Namaz-e-Hajjat, Sajdat al-Shukr — all standard salah/nafilah, no content dispute expected.
- Isteghasa of Hazrat Abbas (AS), recited ×133 — full text is bundled (see below), please verify wording.

#### A1b. Bundled Arabic texts with transliteration + translation

The following full texts ARE bundled in the app and displayed/counted
verbatim. Please check each Arabic string, transliteration and
translation for accuracy:

| ID | Label | Arabic | Transliteration | Translation |
|---|---|---|---|---|
| — | Niyyah | — | — | "Ya Allah, I perform these a'māl seeking closeness to You through Imam Hussain (AS) and the Ahlul Bayt (AS). Accept these from me." |
| — | Du'a for parents | رَبِّ اغْفِرْ لِي وَلِوَالِدَيَّ وَارْحَمْهُمَا كَمَا رَبَّيَانِي صَغِيرًا | Rabbighfir lī wa li-wālidayya warḥamhumā kamā rabbayānī ṣaghīrā. | "My Lord, forgive me and my parents, and have mercy upon them as they raised me when I was small." |
| salawat14a/b | Salawat ×14 | اللّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَآلِ مُحَمَّدٍ وَعَجِّلْ فَرَجَهُمْ | Allahumma ṣalli ʿalā Muḥammadin wa āli Muḥammad, wa ʿajjil farajahum. | (standard salawat) |
| yahussain | ×100, after salawat | يَا حُسَيْنُ ابْنَ عَلِيّ، يَا نُورَ اللّٰهِ | Yā Hussain ibne Ali, Yā Noorallāh. | "O Hussain son of Ali, O Light of Allah." |
| — (isRed) | **La'nat on the Oppressors** — see Gap B1 | اللّهُمَّ الْعَنْ ظَالِمِي فَاطِمَةَ الزَّهْرَاءِ وَالْغَاصِبِينَ حَقَّهَا | Allahummal'an ẓālimī Fāṭimataz-Zahrā wal-ghāṣibīna ḥaqqahā. | "O Allah, curse those who oppressed Lady Fatima al-Zahra (SA) and those who usurped her rights." |
| ali_*10 | Tasbeeh of Imam Ali (AS) — Subḥānallāh / Alḥamdulillāh / Allāhu Akbar / Lā ilāha illallāh, ×10 each | سُبْحَانَ اللّٰهِ / الْحَمْدُ لِلّٰهِ / اللّٰهُ أَكْبَر / لَا إِلٰهَ إِلَّا اللّٰهُ | (standard) | (standard) |
| fatima_*33/34 | Tasbeeh of Bibi Fatima (SA) — Allāhu Akbar ×34, Alḥamdulillāh ×33, Subḥānallāh ×33 | (standard tasbeeh al-Zahra wording) | | |
| fatima11 | Left hand on chest ×11 | اللّهُمَّ صَلِّ عَلَى فَاطِمَةَ وَأَبِيهَا وَبَعْلِهَا وَبَنِيهَا | Allahumma ṣalli ʿalā Fāṭimata wa abīhā wa baʿlihā wa banīhā. | "O Allah, send blessings upon Fatima, her father, her husband, and her sons." |
| musa7 | Du'a of Prophet Musa (AS), Qur'an 28:24, ×3–7 | رَبِّ إِنِّي لِمَا أَنزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيرٌ | Rabbi innī limā anzalta ilayya min khayrin faqīr. | "My Lord, I am truly in need of whatever good You send down to me." |
| — | Surah At-Talāq 65:2–3 | وَمَن يَتَّقِ اللّٰهَ يَجْعَل لَّهُ مَخْرَجًا وَيَرْزُقْهُ مِنْ حَيْثُ لَا يَحْتَسِبُ وَمَن يَتَوَكَّلْ عَلَى اللّٰهِ فَهُوَ حَسْبُهُ ۚ إِنَّ اللّٰهَ بَالِغُ أَمْرِهِ ۚ قَدْ جَعَلَ اللّٰهُ لِكُلِّ شَيْءٍ قَدْرًا | (see source file) | (see source file) |
| noor100 | Yā Nūru, Yā Mubīnu ×100 | يَا نُورُ يَا مُبِين | Yā Nūru, Yā Mubīnu. | "O Allah, the Light, the One who is clear, evident, and makes truth clear." |
| istighfar100 | Istighfār ×100 | أَسْتَغْفِرُ اللّٰهَ رَبِّي وَأَتُوبُ إِلَيْهِ | Astaghfirullāha rabbī wa atūbu ilayh. | "I seek forgiveness from Allah, my Lord, and I turn to Him in repentance." |
| tasbeeh100 | Tasbeeh ×100 | سُبْحَانَ اللّٰهِ وَبِحَمْدِهِ، سُبْحَانَ اللّٰهِ الْعَظِيمِ وَبِحَمْدِهِ | Subḥānallāhi wa biḥamdihī, subḥānallāhil ʿaẓīmi wa biḥamdihī. | "Glory be to Allah and praise belongs to Him; Glory be to Allah, the Magnificent, and praise belongs to Him." |
| dua_fatima3 | Dua of Sayyida Fatima (SA) ×3 | اللَّهُمَّ إِنِّي أَسْأَلُكَ بِحَقِّ فَاطِمَةَ وَأَبِيهَا وَبَعْلِهَا وَبَنِيهَا وَالسِّرِّ الْمُسْتَوْدَعِ فِيهَا... | (see source file) | (see source file) |
| ilm_rizq3 | Ilm, Rizq & Acceptance ×3 | اللّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا... بِصَدَقَةِ الْبَنْجَتَنِ الْپَاكِ وَأَهْلِ الْبَيْتِ الْأَطْهَارِ | (see source file) | mentions "Panjetan Pak" — see Gap B2 |
| rizq_suff3 | Rizq & Sufficiency ×3 | اللّهُمَّ اكْفِنِي بِحَلَالِكَ... بِصَدَقَةِ الْبَنْجَتَنِ الْپَاكِ... | (see source file) | mentions "Panjetan Pak" — see Gap B2 |
| protection3 | Protection ×3 | اللّهُمَّ احْفَظْنِي... بِصَدَقَةِ الْبَنْجَتَنِ الْپَاكِ... | (see source file) | mentions "Panjetan Pak" — see Gap B2 |
| — | Dua for Wealth and Sustenance | أَسْتَغْفِرُ اللَّهَ الَّذِي لَا إِلٰهَ إِلَّا هُوَ الرَّحْمٰنُ الرَّحِيمُ... | (see source file) | (see source file) |
| sahib100 | Yā Ṣāḥib az-Zamān ×100 | يَا صَاحِبَ الزَّمَانِ أَدْرِكْنِي / يَا صَاحِبَ الزَّمَانِ أَغِثْنِي | Yā Ṣāḥib az-Zamān adriknī. Yā Ṣāḥib az-Zamān aghithnī. | "O Master of the Age, help me. O Master of the Age, rescue me." |
| shukr100 | Sajdat al-Shukr ×100 | الْحَمْدُ لِلّٰهِ رَبِّ الْعَالَمِينَ | Alḥamdulillāhi Rabbil ʿĀlamīn. | "All thanks and praise belongs to Allah, Lord of the worlds." |
| wahhab14 | ×14 | يَا وَهَّابُ يَا وَاسِعُ | Yā Wahhāb, Yā Wāsiʿ. | "O Bestower, O All-Encompassing." |
| abbas_salawat_before11 / after11 | Salawat ×11 (before/after isteghasa) | اللّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَآلِ مُحَمَّدٍ وَعَجِّلْ فَرَجَهُمْ | (standard) | (standard) |
| abbas133 | Isteghasa ×133 | يَا كَاشِفَ الْكَرْبِ عَنْ وَجْهِ الْحُسَيْنِ عَلَيْهِ السَّلَامُ اكْشِفْ كَرْبِي بِحَقِّ أَخِيكَ الْحُسَيْنِ عَلَيْهِ السَّلَامُ | Yā Kāshifa al-Karbi ʿan wajhi al-Ḥusayn ʿalayhis-salām, ikshif karbī biḥaqqi akhīka al-Ḥusayn ʿalayhis-salām. | "O you who removed grief from the face of al-Husayn (AS), remove my grief by the right of your brother al-Husayn (AS)." |

#### A1c. Personally-compiled wording (needs "is this appropriate to publish" review, not just transcription check)

- The free-text "Your Hajāt" prompt: *"Ask Allah for acceptance, nearness to Him, protection and health for your family, halal rizq, success in your work, barakah in your projects, and the reappearance of Imam al-Mahdi (AJTF)."*
- Sadqa intentions: *"Give sadqa with the intention of safety, wellbeing and service to Imam-e-Zamana (AJTF)"* and *"Give sadqa for the protection, health and wellbeing of your family."* (Per `CHANGELOG.md`, the family portion is hidden during Ayam-e-Aza — confirm that's the right call, not just the wording.)

### A2. Kahani — Janab-e-Sayyida (SA), "The Goldsmith's Wife"
*Source: `lib/features/kahani/data/kahani_content.dart`, id `fatima`*

- **Urdu script + Roman Urdu**: transcribed faithfully from a provided source document — please verify against that original document for transcription accuracy.
- **English + Arabic**: these are AI-generated translations of the Urdu original, explicitly flagged in-app as "AI translation — pending review" (`kahani_screen.dart:283`). These need translation-accuracy review specifically, separate from the Urdu original.

### A3. App voice / philosophy text (lower priority — not historical/fiqh claims, but sets the app's tone)
*Source: `lib/features/more/presentation/more_screen.dart`, `lib/features/onboarding/presentation/onboarding_screen.dart`*

The "Amanah/Niyyah," 8 core principles, "How We Measure Success," and closing prayer text on the More screen, plus the onboarding dedication/opening du'a. Worth a pass to confirm nothing here overstates the app's religious authority or conflicts with your guidance — these aren't narrations or rulings, so lower priority than A1/A2.

---

## B — Flagged gaps (need a decision, not just review)

1. **La'nat wording has no visible sourcing/context in-app.** The "La'nat on the Oppressors" counter (`fatima_zikr` section, `isRed: true`) is the single most sensitive string in the app and currently ships with no citation or explanatory framing beyond the translation itself. Recommend either (a) adding a source citation in-app, or (b) explicit reviewer sign-off that the bare text is acceptable to ship as-is.

2. **"Panjetan Pak" wording appears only in transliteration, not in the English translation**, in three duas (`ilm_rizq3`, `rizq_suff3`, `protection3`). Worth confirming this term doesn't need a translated equivalent or footnote for non-Urdu-speaking users.

3. **`CHANGELOG.md` claims "Added Ayatollah Sistani's Sajdat al-Shukr guidance (Islamic Laws, Ruling 1109)," but this citation does not appear anywhere in the current app UI or content files** — searched all of `lib/` for "Sistani," "1109," and "Islamic Laws"; no matches. Either this needs to be added back to the Sajdat al-Shukr screen, or the changelog entry is stale and should be corrected. Needs your input on which.

4. **Ziyarat-e-Warisa / Ziyarat-e-Ashura / Ziyarat-e-Arbaeen are referenced by name only** — full texts aren't bundled yet (that's the Library screen's "Ziyarat & Du'as" section, still `ComingSoonScreen`). Not a review item now, but flagging so it's not mistaken for already-reviewed content later.

---

## C — Not ready for review (placeholder only — sourcing needed first)

**13 Biographies** (`lib/features/biographies/data/biography_content.dart`) — the Holy Prophet (SAWW) and all Twelve Imams (AS) currently have literal placeholder text (`"Content pending sourcing and review."`) for every Who/What/When/Where/Why/How field. `needsReview: true` is set on all of them and the app displays a visible "placeholder pending sourcing and scholarly review — not yet authoritative" banner. Nothing to review until real content is drafted from a named source.

**4 Kahanis** (`lib/features/kahani/data/kahani_content.dart`, ids `sakina`, `abbas`, `ali_asghar`, `zainab`) — same situation: literal `"Placeholder for ... kahani. Final text to be sourced and reviewed."` text in all three languages. Not ready.

Per the app's Constitution ("AI must never invent narrations"), this content should come from you or a source you name — happy to help find candidate published/reputable sources to speed that up, if useful, but the actual text needs to originate from a verified source, not be drafted by AI.

---

*Generated as a snapshot of `zawiyah_project` at commit `c6dbf5e`. Re-generate before final submission if content changes.*
