// ============================================================
// Zawiyah — Morning A'mal Content
// lib/features/morning_aamal/data/morning_aamal_content.dart
//
// Ali's personal Morning A'mal routine, ported faithfully from the
// HTML prototype -- every Arabic text, transliteration, and
// translation copied exactly as written, nothing paraphrased or
// altered. This is Ali's own accumulated practice, refined over time
// (originally kept in iOS Notes, organised with ChatGPT's help into
// the prototype this is ported from) -- not generic template content.
//
// PROVENANCE NOTE for the Content Authority document: this routine
// mixes traditionally-sourced du'as/ziyarat (e.g. Ziyarat-e-Ashura,
// the Qur'anic du'as) with personally-compiled wasila/hajat wording.
// When the Content Authority doc is written, worth distinguishing
// which items trace to a specific named source vs. Ali's own
// compiled practice -- not changing anything here, just flagging
// for that future documentation pass.
// ============================================================

import '../domain/amal_models.dart';

const List<AmalSection> morningAamalSections = [
  AmalSection(
    id: 'niyyah',
    title: 'Niyyah',
    initiallyOpen: true,
    blocks: [
      AmalBlock.action(
        'Make your intention sincerely before Allah (SWT). Read the niyyah slowly before starting the routine.',
      ),
      AmalBlock.note(
        '"Ya Allah, I perform these a\'māl seeking closeness to You through Imam Hussain (AS) and the Ahlul Bayt (AS). Accept these from me."',
      ),
    ],
  ),

  AmalSection(
    id: 'nawafil_fajr',
    title: '1. Nawafil and Fajr Salah',
    initiallyOpen: true,
    blocks: [
      AmalBlock.action(
        'Pray 2 rak\'at Nafilat al-Fajr, then pray 2 rak\'at Fajr. If time is short, prioritise the wajib Fajr salah.',
      ),
      AmalBlock.list([
        '2 Rak\'at Nafilat al-Fajr',
        '2 Rak\'at Fajr',
        'Fard + recommended Nawafil if time allows',
      ]),
    ],
  ),

  AmalSection(
    id: 'namaz_hadiya',
    title: '2. Namaz-e-Hadiya — 2 Rak\'at',
    blocks: [
      AmalBlock.action(
        'Recite 2 rak\'at salat as a gift to the Ma\'soomeen (AS).',
      ),
      AmalBlock.note('Gift to the Ma\'soomeen (AS).'),
    ],
  ),

  AmalSection(
    id: 'namaz_walidayn',
    title: '3. Namaz-e-Walidayn — 2 Rak\'at',
    blocks: [
      AmalBlock.action(
        'Recite 2 rak\'at salat for your parents, then read the dua below.',
      ),
      AmalBlock.note('For parents, after Salah.'),
      AmalBlock.textItem(
        arabic: 'رَبِّ اغْفِرْ لِي وَلِوَالِدَيَّ وَارْحَمْهُمَا كَمَا رَبَّيَانِي صَغِيرًا',
        transliteration:
            'Rabbighfir lī wa li-wālidayya warḥamhumā kamā rabbayānī ṣaghīrā.',
        translation:
            '"My Lord, forgive me and my parents, and have mercy upon them as they raised me when I was small."',
      ),
    ],
  ),

  AmalSection(
    id: 'ziyarat_namaz',
    title: '4. Ziyarat Namaz — 2 Rak\'at',
    blocks: [
      AmalBlock.action(
        'Recite 2 rak\'at salat with the intention of ziyarat for Imam Hussain (AS), Ziyarat-e-Ashura and Arbaeen.',
      ),
      AmalBlock.note(
        'Intention for Imam Hussain (AS), Ziyarat-e-Ashura and Arbaeen.',
      ),
    ],
  ),

  AmalSection(
    id: 'ziyarat_recitations',
    title: '5. Ziyarat Recitations',
    blocks: [
      AmalBlock.action(
        'Read the ziyarat recitations in order: Ziyarat-e-Warisa, Ziyarat-e-Ashura, then Ziyarat-e-Arbaeen.',
      ),
      AmalBlock.list([
        'Ziyarat-e-Warisa',
        'Ziyarat-e-Ashura',
        'Ziyarat-e-Arbaeen',
      ]),
    ],
  ),

  AmalSection(
    id: 'namaz_hajjat',
    title: '6. Namaz-e-Hajjat — 2 Rak\'at',
    blocks: [
      AmalBlock.action(
        'First recite 2 rak\'at salat for the ḥājjat of Imam Hussain (AS). Then continue with the salawat and tasbeeh below.',
      ),
      AmalBlock.textItem(
        label: 'Salawat ×14',
        arabic: 'اللّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَآلِ مُحَمَّدٍ وَعَجِّلْ فَرَجَهُمْ',
        transliteration:
            'Allahumma ṣalli ʿalā Muḥammadin wa āli Muḥammad, wa ʿajjil farajahum.',
        maxCount: 14,
        contentId: 'salawat14a',
      ),
      AmalBlock.textItem(
        label: '×100',
        arabic: 'يَا حُسَيْنُ ابْنَ عَلِيّ، يَا نُورَ اللّٰهِ',
        transliteration: 'Yā Hussain ibne Ali, Yā Noorallāh.',
        translation: '"O Hussain son of Ali, O Light of Allah."',
        maxCount: 100,
        contentId: 'yahussain',
      ),
      AmalBlock.textItem(
        label: 'Salawat ×14',
        arabic: 'اللّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَآلِ مُحَمَّدٍ وَعَجِّلْ فَرَجَهُمْ',
        transliteration:
            'Allahumma ṣalli ʿalā Muḥammadin wa āli Muḥammad, wa ʿajjil farajahum.',
        maxCount: 14,
        contentId: 'salawat14b',
      ),
    ],
  ),

  AmalSection(
    id: 'fatima_zikr',
    title: '7. Lady Fatima (SA) Zikr',
    initiallyOpen: true,
    blocks: [
      AmalBlock.action(
        'Recite each subsection in order: la\'nat, Tasbeeh of Imam Ali (AS), Tasbeeh of Bibi Fatima (SA), salawat, then the heart/chest salawat.',
      ),
      AmalBlock.textItem(
        label: 'La\'nat on the Oppressors',
        arabic: 'اللّهُمَّ الْعَنْ ظَالِمِي فَاطِمَةَ الزَّهْرَاءِ وَالْغَاصِبِينَ حَقَّهَا',
        transliteration:
            'Allahummal\'an ẓālimī Fāṭimataz-Zahrā wal-ghāṣibīna ḥaqqahā.',
        translation:
            '"O Allah, curse those who oppressed Lady Fatima al-Zahra (SA) and those who usurped her rights."',
        isRed: true,
      ),
      AmalBlock.group('Tasbeeh of Imam Ali (AS)', [
        AmalBlock.textItem(
          arabic: 'سُبْحَانَ اللّٰهِ',
          transliteration: 'Subḥānallāh',
          translation: 'Glory be to Allah.',
          maxCount: 10,
          contentId: 'ali_subhanallah10',
        ),
        AmalBlock.textItem(
          arabic: 'الْحَمْدُ لِلّٰهِ',
          transliteration: 'Alḥamdulillāh',
          translation: 'All praise belongs to Allah.',
          maxCount: 10,
          contentId: 'ali_alhamdulillah10',
        ),
        AmalBlock.textItem(
          arabic: 'اللّٰهُ أَكْبَر',
          transliteration: 'Allāhu Akbar',
          translation: 'Allah is the Greatest.',
          maxCount: 10,
          contentId: 'ali_allahuakbar10',
        ),
        AmalBlock.textItem(
          arabic: 'لَا إِلٰهَ إِلَّا اللّٰهُ',
          transliteration: 'Lā ilāha illallāh',
          translation: 'There is no god except Allah.',
          maxCount: 10,
          contentId: 'ali_lailaha10',
        ),
      ]),
      AmalBlock.group('Tasbeeh of Bibi Fatima (SA)', [
        AmalBlock.textItem(
          arabic: 'اللّٰهُ أَكْبَر',
          transliteration: 'Allāhu Akbar',
          translation: 'Allah is the Greatest.',
          maxCount: 34,
          contentId: 'fatima_allahuakbar34',
        ),
        AmalBlock.textItem(
          arabic: 'الْحَمْدُ لِلّٰهِ',
          transliteration: 'Alḥamdulillāh',
          translation: 'All praise belongs to Allah.',
          maxCount: 33,
          contentId: 'fatima_alhamdulillah33',
        ),
        AmalBlock.textItem(
          arabic: 'سُبْحَانَ اللّٰهِ',
          transliteration: 'Subḥānallāh',
          translation: 'Glory be to Allah.',
          maxCount: 33,
          contentId: 'fatima_subhanallah33',
        ),
      ]),
      AmalBlock.textItem(
        label: 'Salawat ×14',
        arabic: 'اللّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَآلِ مُحَمَّدٍ وَعَجِّلْ فَرَجَهُمْ',
        transliteration:
            'Allahumma ṣalli ʿalā Muḥammadin wa āli Muḥammad, wa ʿajjil farajahum.',
        maxCount: 14,
        contentId: 'fatima_salawat14',
      ),
      AmalBlock.textItem(
        label: 'Left hand on chest ×11',
        arabic: 'اللّهُمَّ صَلِّ عَلَى فَاطِمَةَ وَأَبِيهَا وَبَعْلِهَا وَبَنِيهَا',
        transliteration:
            'Allahumma ṣalli ʿalā Fāṭimata wa abīhā wa baʿlihā wa banīhā.',
        translation:
            '"O Allah, send blessings upon Fatima, her father, her husband, and her sons."',
        maxCount: 11,
        contentId: 'fatima11',
      ),
    ],
  ),

  AmalSection(
    id: 'personal_duas',
    title: '8. Personal Duas — Qur\'anic Foundation',
    initiallyOpen: true,
    blocks: [
      AmalBlock.action(
        'Begin with the Qur\'anic duas, then make your personal ḥājāt through the wasila of the Ahlul Bayt (AS).',
      ),
      AmalBlock.note(
        'Suggested Wasta: Bibi Fatima (SA), Maula Ali (AS), Imam Hussain (AS), Imam-e-Zamana (AJTF).',
      ),
      AmalBlock.textItem(
        label: 'Du\'a of Prophet Musa (AS) ×3–7 — Qur\'an 28:24',
        arabic: 'رَبِّ إِنِّي لِمَا أَنزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيرٌ',
        transliteration: 'Rabbi innī limā anzalta ilayya min khayrin faqīr.',
        translation:
            '"My Lord, I am truly in need of whatever good You send down to me."',
        maxCount: 7,
        contentId: 'musa7',
      ),
      AmalBlock.textItem(
        label: 'Surah At-Talāq 65:2–3',
        arabic:
            'وَمَن يَتَّقِ اللّٰهَ يَجْعَل لَّهُ مَخْرَجًا\nوَيَرْزُقْهُ مِنْ حَيْثُ لَا يَحْتَسِبُ\nوَمَن يَتَوَكَّلْ عَلَى اللّٰهِ فَهُوَ حَسْبُهُ ۚ إِنَّ اللّٰهَ بَالِغُ أَمْرِهِ ۚ قَدْ جَعَلَ اللّٰهُ لِكُلِّ شَيْءٍ قَدْرًا',
        transliteration:
            'Wa man yattaqi Allāha yajʿal lahu makhrajā. Wa yarzuqhu min ḥaythu lā yaḥtasib. Wa man yatawakkal ʿalā Allāhi fahuwa ḥasbuh. Inna Allāha bālighu amrih. Qad jaʿala Allāhu likulli shay\'in qadrā.',
        translation:
            '"Whoever is mindful of Allah, He will make for him a way out, and He will provide for him from where he does not expect. And whoever relies upon Allah, He is sufficient for him. Indeed, Allah will accomplish His purpose. Allah has set a measure for everything."',
      ),
      AmalBlock.textItem(
        label: 'Your Hajāt',
        arabic: '',
        transliteration: '',
        translation:
            'Ask Allah for acceptance, nearness to Him, protection and health for your family, halal rizq, success in your work, barakah in your projects, and the reappearance of Imam al-Mahdi (AJTF).',
      ),
    ],
  ),

  AmalSection(
    id: 'full_dhikr_set',
    title: '9. Full Dhikr Set',
    blocks: [
      AmalBlock.action(
        'Work through each dhikr in order. Use the counters where provided so you do not lose your place.',
      ),
      AmalBlock.textItem(
        label: 'Yā Nūru, Yā Mubīnu ×100',
        arabic: 'يَا نُورُ يَا مُبِين',
        transliteration: 'Yā Nūru, Yā Mubīnu.',
        translation:
            '"O Allah, the Light, the One who is clear, evident, and makes truth clear."',
        maxCount: 100,
        contentId: 'noor100',
      ),
      AmalBlock.textItem(
        label: 'Istighfār ×100',
        arabic: 'أَسْتَغْفِرُ اللّٰهَ رَبِّي وَأَتُوبُ إِلَيْهِ',
        transliteration: 'Astaghfirullāha rabbī wa atūbu ilayh.',
        translation:
            '"I seek forgiveness from Allah, my Lord, and I turn to Him in repentance."',
        maxCount: 100,
        contentId: 'istighfar100',
      ),
      AmalBlock.textItem(
        label: 'Tasbeeh ×100',
        arabic: 'سُبْحَانَ اللّٰهِ وَبِحَمْدِهِ، سُبْحَانَ اللّٰهِ الْعَظِيمِ وَبِحَمْدِهِ',
        transliteration:
            'Subḥānallāhi wa biḥamdihī, subḥānallāhil ʿaẓīmi wa biḥamdihī.',
        translation:
            '"Glory be to Allah and praise belongs to Him; Glory be to Allah, the Magnificent, and praise belongs to Him."',
        maxCount: 100,
        contentId: 'tasbeeh100',
      ),
      AmalBlock.textItem(
        label: 'Dua of Sayyida Fatima (SA) ×3',
        arabic:
            'اللَّهُمَّ إِنِّي أَسْأَلُكَ بِحَقِّ فَاطِمَةَ وَأَبِيهَا وَبَعْلِهَا وَبَنِيهَا وَالسِّرِّ الْمُسْتَوْدَعِ فِيهَا، أَنْ تُصَلِّيَ عَلَى مُحَمَّدٍ وَآلِ مُحَمَّدٍ، وَأَنْ تَفْعَلَ بِي مَا أَنْتَ أَهْلُهُ، وَلَا تَفْعَلْ بِي مَا أَنَا أَهْلُهُ',
        transliteration:
            'Allahumma innī as\'aluka biḥaqqi Fāṭimata wa abīhā wa baʿlihā wa banīhā wa al-sirr al-mustawdaʿi fīhā, an tuṣalliya ʿalā Muḥammadin wa āli Muḥammad, wa an tafʿala bī mā anta ahluh, wa lā tafʿal bī mā ana ahluh.',
        translation:
            '"O Allah, I ask You by the right of Lady Fatima (SA), her father, her husband, her sons, and the secret entrusted within her, that You send blessings upon Muhammad and the Family of Muhammad, and that You deal with me according to what You are worthy of, and do not deal with me according to what I am worthy of."',
        maxCount: 3,
        contentId: 'dua_fatima3',
      ),
      AmalBlock.textItem(
        label: 'Ilm, Rizq & Acceptance ×3',
        arabic:
            'اللّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا وَاسِعًا طَيِّبًا، وَعَمَلًا مُتَقَبَّلًا، وَشِفَاءً مِنْ كُلِّ دَاءٍ، بِصَدَقَةِ الْبَنْجَتَنِ الْپَاكِ وَأَهْلِ الْبَيْتِ الْأَطْهَارِ',
        transliteration:
            'Allahumma innī as\'aluka ʿilman nāfiʿan, wa rizqan wāsiʿan ṭayyiban, wa ʿamalan mutaqabbalan, wa shifā\'an min kulli dā\', bi ṣadaqatil Panjetanil Pāk wa Ahlil Baytil Aṭhār.',
        translation:
            '"O Allah, I ask You for beneficial knowledge, plentiful and pure sustenance, accepted deeds, and healing from every illness, through the blessed ṣadaqa of the Panjetan Pak (AS) and the purified Ahlul Bayt (AS)."',
        maxCount: 3,
        contentId: 'ilm_rizq3',
      ),
      AmalBlock.textItem(
        label: 'Rizq & Sufficiency ×3',
        arabic:
            'اللّهُمَّ اكْفِنِي بِحَلَالِكَ عَنْ حَرَامِكَ، وَأَغْنِنِي بِفَضْلِكَ عَمَّنْ سِوَاكَ، وَارْزُقْنِي مِنْ حَيْثُ لَا أَحْتَسِبُ، بِصَدَقَةِ الْبَنْجَتَنِ الْپَاكِ وَأَهْلِ الْبَيْتِ الْأَطْهَارِ',
        transliteration:
            'Allahumma ikfinī biḥalālika ʿan ḥarāmik, wa aghninī bifaḍlika ʿamman siwāk, warzuqnī min ḥaythu lā aḥtasib, bi ṣadaqatil Panjetanil Pāk wa Ahlil Baytil Aṭhār.',
        translation:
            '"O Allah, suffice me with what You have made lawful instead of what You have made unlawful; enrich me through Your grace from dependence on anyone besides You; and provide for me from where I do not expect, through the blessed ṣadaqa of the Panjetan Pak (AS) and the purified Ahlul Bayt (AS)."',
        maxCount: 3,
        contentId: 'rizq_suff3',
      ),
      AmalBlock.textItem(
        label: 'Protection ×3',
        arabic:
            'اللّهُمَّ احْفَظْنِي مِنْ بَيْنِ يَدَيَّ، وَمِنْ خَلْفِي، وَعَنْ يَمِينِي، وَعَنْ شِمَالِي، وَمِنْ فَوْقِي، وَمِنْ تَحْتِي، وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي، بِصَدَقَةِ الْبَنْجَتَنِ الْپَاكِ وَأَهْلِ الْبَيْتِ الْأَطْهَارِ',
        transliteration:
            'Allahumma iḥfaẓnī min bayni yadayya, wa min khalfī, wa ʿan yamīnī, wa ʿan shimālī, wa min fawqī, wa min taḥtī, wa aʿūdhu biʿaẓamatika an ughtāla min taḥtī, bi ṣadaqatil Panjetanil Pāk wa Ahlil Baytil Aṭhār.',
        translation:
            '"O Allah, protect me from in front of me, behind me, from my right, from my left, from above me, and from beneath me; and I seek refuge in Your greatness from being attacked from beneath me, through the blessed ṣadaqa of the Panjetan Pak (AS) and the purified Ahlul Bayt (AS)."',
        maxCount: 3,
        contentId: 'protection3',
      ),
      AmalBlock.textItem(
        label: 'Dua for Wealth and Sustenance',
        arabic:
            'أَسْتَغْفِرُ اللَّهَ الَّذِي لَا إِلٰهَ إِلَّا هُوَ الرَّحْمٰنُ الرَّحِيمُ الْحَيُّ الْقَيُّومُ بَدِيعُ السَّمَاوَاتِ وَالْأَرْضِ مِنْ جَمِيعِ جُرْمِي وَظُلْمِي وَإِسْرَافِي عَلَىٰ نَفْسِي وَأَتُوبُ إِلَيْهِ',
        transliteration:
            'Astaghfirullāha alladhī lā ilāha illā Huwa ar-Raḥmānu ar-Raḥīm, al-Ḥayyu al-Qayyūm, Badīʿu as-samāwāti wal-arḍ, min jamīʿi jurmī wa ẓulmī wa isrāfī ʿalā nafsī, wa atūbu ilayh.',
        translation:
            '"I seek forgiveness from Allah, besides Whom there is no god; the Most Compassionate, the Most Merciful, the Ever-Living, the Self-Subsisting, the Originator of the heavens and the earth. I seek forgiveness for all my sins, my wrongdoing, and my excesses against my own soul, and I repent to Him."',
      ),
      AmalBlock.textItem(
        label: 'Yā Ṣāḥib az-Zamān ×100',
        arabic: 'يَا صَاحِبَ الزَّمَانِ أَدْرِكْنِي\nيَا صَاحِبَ الزَّمَانِ أَغِثْنِي',
        transliteration:
            'Yā Ṣāḥib az-Zamān adriknī. Yā Ṣāḥib az-Zamān aghithnī.',
        translation: '"O Master of the Age, help me. O Master of the Age, rescue me."',
        maxCount: 100,
        contentId: 'sahib100',
      ),
      AmalBlock.note('Sadqa: see the dedicated Sadqa section in Sajdat al-Shukr.'),
    ],
  ),

  AmalSection(
    id: 'sajdat_shukr',
    title: '10. Sajdat al-Shukr',
    blocks: [
      AmalBlock.action(
        'Go into sajdah and recite the shukr and closing adhkār below.',
      ),
      AmalBlock.textItem(
        label: '×100',
        arabic: 'الْحَمْدُ لِلّٰهِ رَبِّ الْعَالَمِينَ',
        transliteration: 'Alḥamdulillāhi Rabbil ʿĀlamīn.',
        translation: '"All thanks and praise belongs to Allah, Lord of the worlds."',
        maxCount: 100,
        contentId: 'shukr100',
      ),
      AmalBlock.textItem(
        label: '×14',
        arabic: 'يَا وَهَّابُ يَا وَاسِعُ',
        transliteration: 'Yā Wahhāb, Yā Wāsiʿ.',
        translation: '"O Bestower, O All-Encompassing."',
        maxCount: 14,
        contentId: 'wahhab14',
      ),
      AmalBlock.textItem(
        label: 'Final Salawat',
        arabic: 'اللّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَآلِ مُحَمَّدٍ وَعَجِّلْ فَرَجَهُمْ',
        transliteration:
            'Allahumma ṣalli ʿalā Muḥammadin wa āli Muḥammad, wa ʿajjil farajahum.',
      ),
      AmalBlock.note('Sadqa: see separate section below.'),
      AmalBlock.group('Sadqa', [
        AmalBlock.textItem(
          label: 'For Imam-e-Zamana (AJTF)',
          arabic: '',
          transliteration: '',
          translation:
              'Give sadqa with the intention of safety, wellbeing and service to Imam-e-Zamana (AJTF).',
        ),
        AmalBlock.textItem(
          label: 'For family',
          arabic: '',
          transliteration: '',
          translation:
              'Give sadqa for the protection, health and wellbeing of your family.',
        ),
      ]),
    ],
  ),

  AmalSection(
    id: 'isteghasa_abbas',
    title: '🌙 Later — Isteghasa of Hazrat Abbas (AS)',
    blocks: [
      AmalBlock.action(
        'When possible, first recite 2 rak\'at hadiya to Hazrat Abbas (AS), then recite the salawat, isteghasa and closing salawat.',
      ),
      AmalBlock.note('After 2 Rak\'at Hadiya to Hazrat Abbas (AS).'),
      AmalBlock.textItem(
        label: 'Salawat ×11 Before',
        arabic: 'اللّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَآلِ مُحَمَّدٍ وَعَجِّلْ فَرَجَهُمْ',
        transliteration:
            'Allahumma ṣalli ʿalā Muḥammadin wa āli Muḥammad, wa ʿajjil farajahum.',
        maxCount: 11,
        contentId: 'abbas_salawat_before11',
      ),
      AmalBlock.textItem(
        label: 'Isteghasa ×133',
        arabic:
            'يَا كَاشِفَ الْكَرْبِ عَنْ وَجْهِ الْحُسَيْنِ عَلَيْهِ السَّلَامُ اكْشِفْ كَرْبِي بِحَقِّ أَخِيكَ الْحُسَيْنِ عَلَيْهِ السَّلَامُ',
        transliteration:
            'Yā Kāshifa al-Karbi ʿan wajhi al-Ḥusayn ʿalayhis-salām, ikshif karbī biḥaqqi akhīka al-Ḥusayn ʿalayhis-salām.',
        translation:
            '"O you who removed grief from the face of al-Husayn (AS), remove my grief by the right of your brother al-Husayn (AS)."',
        maxCount: 133,
        contentId: 'abbas133',
      ),
      AmalBlock.textItem(
        label: 'Salawat ×11 After',
        arabic: 'اللّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَآلِ مُحَمَّدٍ وَعَجِّلْ فَرَجَهُمْ',
        transliteration:
            'Allahumma ṣalli ʿalā Muḥammadin wa āli Muḥammad, wa ʿajjil farajahum.',
        maxCount: 11,
        contentId: 'abbas_salawat_after11',
      ),
    ],
  ),
];
