# Zawiyah — Biography Content Sourcing Guide

Candidate sources for the 13 placeholder biographies in
`lib/features/biographies/data/biography_content.dart` (the Prophet
+ Twelve Imams, currently all `"Content pending sourcing and
review."`). This is a sourcing guide, not drafted content — per the
app's Constitution ("AI must never invent narrations"), the actual
Who/What/When/Where/Why/How text should come from you or your
reviewing scholar working from these sources, not be written by me
from memory. Verified live in July 2026, not recalled from training
data.

## Primary recommendation: Kitab al-Irshad (Shaykh al-Mufid)

**The single best-fit source for all 13 entries.** *Al-Irshad: The
Book of Guidance into the Lives of the Twelve Imams* is the classical
11th-century biographical work by Shaykh al-Mufid — one of the most
foundational texts in Twelver Shia scholarship, written explicitly for
general readers (not a specialist text), which matches the app's
Who/What/When/Where/Why/How format well since it already moves
chronologically through each Imam's life, appointment, key events, and
death.

- English translation by I.K.A. Howard, hosted with introduction at
  al-islam.org: https://al-islam.org/introduction-kitab-al-irshad-muhammad-rida-jafari/al-irshad
- Also sold in print by Tahrike Tarsile Qur'an and others, if a durable
  offline copy is preferred for review work.
- Covers Imam Ali through Imam al-Mahdi (AJTF) — all 12 Imams in one
  coherent, chronological work, making it easy to extract consistent
  Who/What/When/Where/Why/How fields across all entries rather than
  stitching together 12 different sources with different tones.

## Prophet Muhammad (SAWW)

Al-Irshad focuses on the Imams, not the Prophet's own biography, so
this entry needs a separate source:

- Al-Islam.org's dedicated Prophet Muhammad library section:
  https://al-islam.org/library/prophet-muhammad
- *Prophet Muhammad from the Shi'ah Perspective* (Muhammad
  Legenhausen), also on al-islam.org — useful specifically for how
  Shia sources frame his life/succession, which matters for this
  app's audience: https://al-islam.org/prophet-muhammad-shiah-perspective-muhammad-legenhausen/prophet-muhammad-shiah-perspective

## About al-islam.org / Ahlul Bayt DILP

The host for both sources above. The Ahlul Bayt Digital Islamic
Library Project is an independent non-profit (established 1996, not
government-affiliated) whose stated focus is digitizing primary
Twelver Shia sources — it's the same organization already implicitly
trusted by this project (Nahjul Balagha and Sahifa Sajjadiya, both
planned Library sections, are canonical texts this organization also
hosts).

## Secondary cross-reference: WikiShia

Useful for double-checking specific facts (dates, place names,
lineage) once a primary draft exists — not a replacement for Al-Irshad
as the main source, since it's a general encyclopedia rather than a
single authored scholarly work.

- https://en.wikishia.net/
- **Disclosure worth knowing**: WikiShia is run by the Ahl al-Bayt
  World Assembly, an organization under Ayatollah Khamenei's
  supervision. That doesn't make it unreliable, but depending on which
  marja' your reviewing scholar follows, they may have a preference
  for or caution around Iran-state-linked institutional sources versus
  independent ones like al-islam.org. Flagging this so it's a known
  factor in the sourcing decision, not a surprise later.

## Suggested workflow

1. For each of the 13 entries, read the relevant Al-Irshad chapter (or
   the Prophet sources above) and draft Who/What/When/Where/Why/How
   directly from the text — plain paraphrase of what's there, not
   embellishment.
2. Cross-check dates/places against WikiShia if anything's ambiguous.
3. Have your scholar reviewer sign off using the same process as
   `CONTENT_REVIEW_PACKAGE.md` — cite which source each field came
   from so the review is fast.
4. Only then flip that entry's `needsReview` to `false` in
   `biography_content.dart`.

Given there are 13 entries and this needs real editorial judgment per
person (not just find-and-paste), this is meaningful work — happy to
help build out the actual `Biography(...)` Dart entries once you or
your reviewer have drafted the text per person, if that'd help.
