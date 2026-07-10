// ============================================================
// Zawiyah — Kahani Content
// lib/features/kahani/data/kahani_content.dart
//
// The 'fatima' entry is now Ali's real, sourced content -- the
// Janab-e-Sayyida (SA) / Sunar Ki Biwi (Goldsmith's Wife) kahani,
// ported exactly from the provided document (native Urdu script +
// Roman Urdu). Not paraphrased, not translated, not summarised --
// copied faithfully. English and Arabic variants are not yet
// available for this one; the language picker only offers what
// actually exists (see KahaniItem.availableLanguages).
//
// The remaining four entries (sakina, abbas, ali_asghar, zainab) are
// still prototype placeholders explicitly marked as needing sourcing
// and review -- not altered.
// ============================================================

import '../domain/kahani_item.dart';

const List<KahaniItem> kahaniItems = [
  KahaniItem(
    id: 'fatima',
    title: 'جنابِ سیدہؑ کی کہانی — سنار کی بیوی (Janab-e-Sayyida (SA) — The Goldsmith\'s Wife)',
    aiTranslatedLanguages: {'english', 'arabic'},
    english: '''There is a well-known tradition that in a certain city in Arabia there lived a goldsmith's wife who had a son. One day she went to draw water from a well. While playing, the child wandered off toward a potter's kiln and went missing. Despite searching, he could not be found, and word spread that he had burned in the kiln. Overcome with grief, the goldsmith's wife saw a veiled, elderly lady in a dream, who told her that if the child returned alive, she should make a vow (mannat) to listen to the story of Janab-e-Sayyida (SA).

The goldsmith's wife made the vow, and upon waking she saw that her son had returned safe and sound. Overjoyed, she took sweets to the people and asked them to listen to the story, but no one paid attention. Disheartened, she set out toward the forest, where she met the same veiled lady, who began to narrate the story of Janab-e-Sayyida (SA).

She recounted the incident of the wedding of a Jewish man's daughter in Madina. The Jewish man had invited Janab-e-Sayyida Fatima al-Zahra (peace be upon her). She was prepared to go in simple clothing, but the maidens of Paradise came and adorned her. The wedding house was illuminated by her light. When the bride became lifeless, Janab-e-Sayyida (SA) made du'a, and by Allah's command she came back to life and began reciting the kalima of testimony.

Then the story of two girls who had become separated from their parents was recounted. They vowed that if they were reunited with their parents, they would listen to the story of Janab-e-Sayyida (SA). They were reunited with their family but forgot the vow. Later, they fell into hardship and imprisonment. The veiled lady reminded them that they had not fulfilled their vow. They had sweets brought, listened to the story and narrated it, after which they were released and their difficulties were removed.

After the story was completed, the veiled lady disappeared. It is related that when the goldsmith's wife returned home, she saw that the houses of those who had refused to listen to and narrate the story had caught fire. She then gave thanks to Allah.

May Allah, for the sake of Janab-e-Sayyida Fatima al-Zahra (peace be upon her), fulfill the legitimate needs of all believing men and women. Āmīn.''',
    urduScript: '''ایک مشہور روایت ہے کہ عرب کے کسی شہر میں ایک سنارن رہتی تھی جس کا ایک بیٹا تھا۔ ایک روز وہ کنویں پر پانی بھرنے گئی۔ بچہ کھیلتے کھیلتے کمہار کی بھٹی کی طرف چلا گیا اور گم ہو گیا۔ تلاش کے باوجود نہ ملا اور خبر پھیلی کہ وہ بھٹی میں جل گیا ہے۔ غم کے عالم میں سنارن نے ایک نقاب پوش بزرگ خاتون کو خواب میں دیکھا جنہوں نے فرمایا کہ اگر بچہ زندہ واپس آ جائے تو جنابِ سیدہؑ کی کہانی سننے کی منت مان لو۔

سنارن نے منت مانی اور آنکھ کھلنے پر دیکھا کہ اس کا بیٹا صحیح سلامت واپس آ رہا ہے۔ وہ خوشی سے شیرینی لے کر لوگوں کے پاس گئی اور کہانی سنانے کی درخواست کی مگر کسی نے توجہ نہ دی۔ مایوس ہو کر وہ جنگل کی طرف نکل گئی جہاں وہی نقاب پوش خاتون ملیں اور انہوں نے جنابِ سیدہؑ کی کہانی سنانی شروع کی۔

انہوں نے مدینہ کے ایک یہودی کی بیٹی کی شادی کا واقعہ بیان کیا۔ یہودی نے جنابِ سیدہ فاطمہ زہرا سلام اللہ علیہا کو دعوت دی۔ آپؑ سادگی کے لباس میں جانے کو تیار ہوئیں مگر جنت کی حوروں نے آ کر آپؑ کو آراستہ کیا۔ آپؑ کے نور سے شادی کا گھر روشن ہو گیا۔ دلہن بے جان ہو گئی تو جنابِ سیدہؑ نے دعا فرمائی اور اللہ تعالیٰ کے حکم سے وہ دوبارہ زندہ ہو کر کلمۂ شہادت پڑھنے لگی۔

پھر دو لڑکیوں کا واقعہ بیان ہوا جو اپنے والدین سے بچھڑ گئیں۔ انہوں نے منت مانی کہ اگر والدین سے مل گئیں تو جنابِ سیدہؑ کی کہانی سنیں گی۔ وہ اپنے گھر والوں سے مل گئیں مگر منت بھول گئیں۔ بعد میں مصیبت اور قید میں مبتلا ہوئیں۔ نقاب پوش خاتون نے انہیں یاد دلایا کہ انہوں نے منت پوری نہیں کی۔ انہوں نے مٹھائی منگوا کر کہانی سنی اور سنائی، جس کے بعد ان کی رہائی ہو گئی اور ان کی مشکلات دور ہو گئیں۔

کہانی مکمل ہونے کے بعد نقاب پوش خاتون غائب ہو گئیں۔ روایت میں بیان کیا جاتا ہے کہ جب سنارن اپنے گھر واپس آئی تو اس نے دیکھا کہ جن لوگوں نے کہانی سننے اور سنانے سے انکار کیا تھا ان کے گھروں میں آگ لگی ہوئی تھی۔ پھر اس نے اللہ تعالیٰ کا شکر ادا کیا۔

دعا ہے کہ اللہ تعالیٰ جنابِ سیدہ فاطمہ زہرا سلام اللہ علیہا کے صدقے تمام مومنین و مومنات کی جائز حاجات پوری فرمائے۔ آمین۔''',
    romanUrdu: '''Ek mashhoor riwayat hai ke Arab ke kisi shehar mein ek sunaaran rehti thi jis ka ek beta tha. Ek roz woh kuen par pani bharne gayi. Bacha khelte khelte kumhaar ki bhatti ki taraf chala gaya aur gum ho gaya. Talaash ke bawajood na mila aur khabar phaili ke woh bhatti mein jal gaya hai. Gham ke aalam mein sunaaran ne ek naqab posh buzurg khatoon ko khwab mein dekha jinhon ne farmaya ke agar bacha zinda wapas aa jaye to Janab-e-Sayyida ki kahani sunne ki mannat maan lo.

Sunaaran ne mannat maani aur aankh khulne par dekha ke us ka beta sahih salamat wapas aa raha hai. Woh khushi se sheerini le kar logon ke paas gayi aur kahani sunane ki darkhwast ki magar kisi ne tawajju na di. Mayoos ho kar woh jungle ki taraf nikal gayi jahan wohi naqab posh khatoon milin aur unhon ne Janab-e-Sayyida ki kahani sunani shuru ki.

Unhon ne Madina ke ek Yahudi ki beti ki shaadi ka waqia bayan kiya. Yahudi ne Janab-e-Sayyida Fatima Zahra salamullahi alayha ko dawat di. Aap saadgi ke libas mein jane ko tayyar huin magar jannat ki hooron ne aa kar aap ko aarasta kiya. Aap ke noor se shaadi ka ghar roshan ho gaya. Dulhan bejaan ho gayi to Janab-e-Sayyida ne dua farmai aur Allah Ta'ala ke hukm se woh dobara zinda ho kar Kalima-e-Shahadat parhne lagi.

Phir do larkiyon ka waqia bayan hua jo apne walidain se bichhar gayin. Unhon ne mannat maani ke agar walidain se mil gayin to Janab-e-Sayyida ki kahani sunengi. Woh apne ghar walon se mil gayin magar mannat bhool gayin. Baad mein museebat aur qaid mein mubtala huin. Naqab posh khatoon ne unhein yaad dilaya ke unhon ne mannat poori nahin ki. Unhon ne mithai manga kar kahani suni aur sunai jis ke baad un ki rihaai ho gayi aur mushkilaat door ho gayin.

Kahani mukammal hone ke baad naqab posh khatoon ghaib ho gayin. Riwayat mein bayan kiya jata hai ke jab sunaaran apne ghar wapas aayi to us ne dekha ke jin logon ne kahani sunne aur sunane se inkar kiya tha un ke gharon mein aag lagi hui thi. Phir us ne Allah Ta'ala ka shukar ada kiya.

Dua hai ke Allah Ta'ala Janab-e-Sayyida Fatima Zahra salamullahi alayha ke sadqay tamaam momineen o mominaat ki jaiz hajat poori farmaaye. Ameen.''',
    arabic: '''هناك رواية مشهورة أنه في إحدى مدن العرب كانت تعيش زوجة صائغ لها ولد. خرجت ذات يوم لتملأ الماء من البئر. وأثناء اللعب، ذهب الطفل نحو فرن الفخاري وضاع. ورغم البحث لم يُعثر عليه، وانتشر خبر أنه احترق في الفرن. وفي حالة الحزن، رأت الصائغة في المنام امرأة منقبة كبيرة السن، قالت لها: إن عاد الولد حياً، فلتنذري أن تستمعي إلى قصة سيدتنا سيدہؑ (سلام الله عليها).

فنذرت الصائغة، وعند استيقاظها رأت ابنها يعود سالماً معافى. ففرحت وأخذت الحلوى إلى الناس وطلبت منهم الاستماع إلى القصة، لكن لم يهتم أحد. فخرجت يائسة نحو الغابة، حيث التقت بتلك المرأة المنقبة نفسها، فبدأت تروي لها القصة.

فروت واقعة زواج ابنة يهودي في المدينة. فقد دعا اليهودي السيدة فاطمة الزهراء (سلام الله عليها). فتأهبت للذهاب بثياب بسيطة، فجاءت حوريات الجنة وزيّنّها. فأضاء نورها بيت العرس. فلما فقدت العروس وعيها، دعت السيدة (سلام الله عليها)، فبأمر الله عادت إلى الحياة وبدأت تنطق بالشهادتين.

ثم رُويت قصة فتاتين افترقتا عن والديهما. فنذرتا أنهما إن التقتا بوالديهما لاستمعتا إلى القصة. فالتقتا بأهلهما لكنهما نسيتا النذر. وبعد ذلك وقعتا في ضيق وسجن. فذكّرتهما المرأة المنقبة بأنهما لم توفيا بالنذر. فأحضرتا الحلوى واستمعتا إلى القصة وروتاها، وبعد ذلك أُطلق سراحهما وزالت متاعبهما.

وبعد اكتمال القصة، اختفت المرأة المنقبة. وتذكر الرواية أنه لما عادت الصائغة إلى بيتها، رأت أن بيوت الذين رفضوا الاستماع إلى القصة وروايتها قد اشتعلت فيها النار. فحمدت الله تعالى.

اللهم بحق السيدة فاطمة الزهراء (سلام الله عليها) اقض الحوائج المشروعة لجميع المؤمنين والمؤمنات. آمين.''',
  ),
  KahaniItem(
    id: 'sakina',
    title: 'Bibi Sakina (SA) Kahani',
    aamal:
        'Recommended alongside: Surah al-Fatiha for Bibi Sakina bintul Imam Hussain (SA), salawat, and dua for children and families.',
    english: 'Placeholder for Bibi Sakina (SA) kahani. Final text to be sourced and reviewed.',
    romanUrdu: 'Bibi Sakina (SA) ki kahani ka placeholder. Final matn source aur review ke baad add hoga.',
    arabic: 'نص مؤقت لقصة السيدة سكينة عليها السلام، ويحتاج إلى مراجعة وتوثيق.',
  ),
  KahaniItem(
    id: 'abbas',
    title: 'Hazrat Abbas (AS) Kahani',
    aamal:
        'Recommended alongside: salawat, 2 rak\'at hadiya to Hazrat Abbas (AS), and the isteghasa where appropriate.',
    english: 'Placeholder for Hazrat Abbas (AS) kahani. Final text to be sourced and reviewed.',
    romanUrdu: 'Hazrat Abbas (AS) ki kahani ka placeholder. Final matn source aur review ke baad add hoga.',
    arabic: 'نص مؤقت لقصة أبي الفضل العباس عليه السلام، ويحتاج إلى مراجعة وتوثيق.',
  ),
  KahaniItem(
    id: 'ali_asghar',
    title: 'Ali Asghar (AS) Kahani',
    aamal:
        'Recommended alongside: Surah al-Fatiha, salawat, and dua for the protection and wellbeing of children.',
    english: 'Placeholder for Ali Asghar (AS) kahani. Final text to be sourced and reviewed.',
    romanUrdu: 'Ali Asghar (AS) ki kahani ka placeholder. Final matn source aur review ke baad add hoga.',
    arabic: 'نص مؤقت لقصة علي الأصغر عليه السلام، ويحتاج إلى مراجعة وتوثيق.',
  ),
  KahaniItem(
    id: 'zainab',
    title: 'Bibi Zainab (SA) Kahani',
    aamal: 'Recommended alongside: salawat and dua for sabr, courage, dignity and protection.',
    english: 'Placeholder for Bibi Zainab (SA) kahani. Final text to be sourced and reviewed.',
    romanUrdu: 'Bibi Zainab (SA) ki kahani ka placeholder. Final matn source aur review ke baad add hoga.',
    arabic: 'نص مؤقت لقصة السيدة زينب عليها السلام، ويحتاج إلى مراجعة وتوثيق.',
  ),
];
