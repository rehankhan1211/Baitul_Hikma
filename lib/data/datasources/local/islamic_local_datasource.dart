import '../../models/surah_model.dart';
import '../../models/hadith_model.dart';
import '../../models/dua_model.dart';

/// Static sample data — replace with API integration.
/// Note: Quranic verses and Hadiths are well-known authentic texts included
/// for demonstration. All religious content must be verified before release.
class IslamicLocalDataSource {
  IslamicLocalDataSource._();

  // ───────────────────── SURAHS ─────────────────────
  static List<SurahModel> get surahs => [
    const SurahModel(
      number: 1,
      nameArabic: 'الفاتحة',
      nameEnglish: 'The Opening',
      nameTransliteration: 'Al-Fatihah',
      revelationType: 'meccan',
      ayahCount: 7,
      juz: '1',
    ),
    const SurahModel(
      number: 2,
      nameArabic: 'البقرة',
      nameEnglish: 'The Cow',
      nameTransliteration: 'Al-Baqarah',
      revelationType: 'medinan',
      ayahCount: 286,
      juz: '1-3',
    ),
    const SurahModel(
      number: 3,
      nameArabic: 'آل عمران',
      nameEnglish: 'Family of Imran',
      nameTransliteration: 'Ali Imran',
      revelationType: 'medinan',
      ayahCount: 200,
      juz: '3-4',
    ),
    const SurahModel(
      number: 18,
      nameArabic: 'الكهف',
      nameEnglish: 'The Cave',
      nameTransliteration: 'Al-Kahf',
      revelationType: 'meccan',
      ayahCount: 110,
      juz: '15-16',
    ),
    const SurahModel(
      number: 36,
      nameArabic: 'يس',
      nameEnglish: 'Ya-Sin',
      nameTransliteration: 'Ya-Sin',
      revelationType: 'meccan',
      ayahCount: 83,
      juz: '22-23',
    ),
    const SurahModel(
      number: 55,
      nameArabic: 'الرحمن',
      nameEnglish: 'The Beneficent',
      nameTransliteration: 'Ar-Rahman',
      revelationType: 'medinan',
      ayahCount: 78,
      juz: '27',
    ),
    const SurahModel(
      number: 56,
      nameArabic: 'الواقعة',
      nameEnglish: 'The Inevitable',
      nameTransliteration: 'Al-Waqi\'ah',
      revelationType: 'meccan',
      ayahCount: 96,
      juz: '27',
    ),
    const SurahModel(
      number: 67,
      nameArabic: 'الملك',
      nameEnglish: 'The Sovereignty',
      nameTransliteration: 'Al-Mulk',
      revelationType: 'meccan',
      ayahCount: 30,
      juz: '29',
    ),
    const SurahModel(
      number: 112,
      nameArabic: 'الإخلاص',
      nameEnglish: 'Sincerity',
      nameTransliteration: 'Al-Ikhlas',
      revelationType: 'meccan',
      ayahCount: 4,
      juz: '30',
    ),
    const SurahModel(
      number: 113,
      nameArabic: 'الفلق',
      nameEnglish: 'The Daybreak',
      nameTransliteration: 'Al-Falaq',
      revelationType: 'meccan',
      ayahCount: 5,
      juz: '30',
    ),
    const SurahModel(
      number: 114,
      nameArabic: 'الناس',
      nameEnglish: 'Mankind',
      nameTransliteration: 'An-Nas',
      revelationType: 'meccan',
      ayahCount: 6,
      juz: '30',
    ),
  ];

  // Al-Fatihah ayahs (authentic)
  static List<AyahModel> get alfatihahAyahs => [
    const AyahModel(
      surahNumber: 1,
      ayahNumber: 1,
      arabicText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
      translation:
          'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
      tafseer:
          'This verse, known as the Basmala, opens every surah except At-Tawbah. It invokes the two names of Allah\'s mercy: Ar-Rahman (general mercy for all creation) and Ar-Raheem (special mercy for believers).',
    ),
    const AyahModel(
      surahNumber: 1,
      ayahNumber: 2,
      arabicText: 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
      translation: '[All] praise is [due] to Allah, Lord of the worlds —',
      tafseer:
          'Al-Hamd encompasses all praise, gratitude, and glory. Rabb (Lord) denotes mastery, ownership, and nurturing. Al-Alamin means all of creation — humans, jinn, angels, animals, and everything that exists.',
    ),
    const AyahModel(
      surahNumber: 1,
      ayahNumber: 3,
      arabicText: 'الرَّحْمَٰنِ الرَّحِيمِ',
      translation: 'The Entirely Merciful, the Especially Merciful,',
      tafseer:
          'The repetition of Allah\'s mercy after the Basmala emphasizes that all praise belongs to the Most Merciful — whose mercy encompasses all things.',
    ),
    const AyahModel(
      surahNumber: 1,
      ayahNumber: 4,
      arabicText: 'مَالِكِ يَوْمِ الدِّينِ',
      translation: 'Sovereign of the Day of Recompense.',
      tafseer:
          'Maalik Yawm id-Deen — The Owner or King of the Day of Judgment. Deen here means recompense and accountability. This reminds us that all authority ultimately returns to Allah.',
    ),
    const AyahModel(
      surahNumber: 1,
      ayahNumber: 5,
      arabicText: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
      translation: 'It is You we worship and You we ask for help.',
      tafseer:
          'The shift to direct address marks the heart of the surah. Ibadah (worship) combines love, awe, and total submission. The believer declares their exclusivity of worship to Allah alone.',
    ),
    const AyahModel(
      surahNumber: 1,
      ayahNumber: 6,
      arabicText: 'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
      translation: 'Guide us to the straight path —',
      tafseer:
          'The greatest dua a believer can make: guide us, maintain us, and keep us on the Sirat al-Mustaqeem — the path of truth, righteousness, and closeness to Allah.',
    ),
    const AyahModel(
      surahNumber: 1,
      ayahNumber: 7,
      arabicText:
          'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
      translation:
          'The path of those upon whom You have bestowed favor, not of those who have evoked [Your] anger or of those who are astray.',
      tafseer:
          'Those favored are the prophets, truthful ones, martyrs, and righteous. Those who earned anger knew truth but rejected it. Those astray acted in ignorance. We ask to follow the rightly guided.',
    ),
  ];

  // ───────────────────── HADITHS ─────────────────────
  static List<HadithCollection> get collections => [
    const HadithCollection(
      id: 'bukhari',
      nameEnglish: 'Sahih al-Bukhari',
      nameArabic: 'صحيح البخاري',
      author: 'Imam Muhammad al-Bukhari',
      totalHadiths: 7563,
      description:
          'The most authentic collection of Hadith, compiled by Imam Bukhari after rigorous chain verification. Considered the most reliable book after the Quran.',
      coverColor: '#203D31',
    ),
    const HadithCollection(
      id: 'muslim',
      nameEnglish: 'Sahih Muslim',
      nameArabic: 'صحيح مسلم',
      author: 'Imam Muslim ibn al-Hajjaj',
      totalHadiths: 7500,
      description:
          'The second most authentic Hadith collection. Imam Muslim\'s methodology involved extensive narrator criticism and precise documentation.',
      coverColor: '#2E5544',
    ),
    const HadithCollection(
      id: 'nawawi',
      nameEnglish: 'Forty Hadith',
      nameArabic: 'الأربعون النووية',
      author: 'Imam Yahya an-Nawawi',
      totalHadiths: 42,
      description:
          'A curated collection of 42 fundamental hadiths covering the pillars of Islam, ethics, and essential teachings. A classic for every Muslim to memorize.',
      coverColor: '#B69A61',
    ),
    const HadithCollection(
      id: 'abudawud',
      nameEnglish: 'Sunan Abu Dawud',
      nameArabic: 'سنن أبي داود',
      author: 'Imam Abu Dawud as-Sijistani',
      totalHadiths: 5274,
      description:
          'One of the six major Hadith collections, focusing particularly on legal and judicial matters in Islamic jurisprudence.',
      coverColor: '#4F7363',
    ),
  ];

  static List<HadithModel> get featuredHadiths => [
    const HadithModel(
      id: 'nawawi-1',
      collectionId: 'nawawi',
      number: 1,
      arabicText:
          'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ، وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى',
      englishText:
          'Actions are but by intentions, and every man shall have only that which he intended.',
      narrator: 'Umar ibn al-Khattab (رضي الله عنه)',
      grade: 'Sahih',
      reference: 'Bukhari 1, Muslim 1907',
      topic: 'Intention (Niyyah)',
    ),
    const HadithModel(
      id: 'nawawi-2',
      collectionId: 'nawawi',
      number: 2,
      arabicText:
          'الإِسْلامُ أَنْ تَشْهَدَ أَنْ لا إِلهَ إِلاَّ اللهُ وَأَنَّ مُحَمَّداً رَسُولُ اللهِ',
      englishText:
          'Islam is to testify that there is no deity except Allah and that Muhammad is the Messenger of Allah, to perform the prayers, to give Zakat, to fast in Ramadan, and to make the pilgrimage to the House if you are able to do so.',
      narrator: 'Umar ibn al-Khattab (رضي الله عنه)',
      grade: 'Sahih',
      reference: 'Muslim 8',
      topic: 'Pillars of Islam',
    ),
    const HadithModel(
      id: 'nawawi-6',
      collectionId: 'nawawi',
      number: 6,
      arabicText:
          'إِنَّ الْحَلالَ بَيِّنٌ وَإِنَّ الْحَرَامَ بَيِّنٌ وَبَيْنَهُمَا أُمُورٌ مُشْتَبِهَاتٌ',
      englishText:
          'The halal is clear and the haram is clear, and between the two of them are doubtful matters. Whosoever abandons what is doubtful to him has safeguarded his religion and honor.',
      narrator: 'An-Nu\'man ibn Bashir (رضي الله عنه)',
      grade: 'Sahih',
      reference: 'Bukhari 52, Muslim 1599',
      topic: 'Halal & Haram',
    ),
    const HadithModel(
      id: 'nawawi-13',
      collectionId: 'nawawi',
      number: 13,
      arabicText:
          'لا يُؤْمِنُ أَحَدُكُمْ حَتَّى يُحِبَّ لأَخِيهِ مَا يُحِبُّ لِنَفْسِهِ',
      englishText:
          'None of you will have faith till he wishes for his brother what he likes for himself.',
      narrator: 'Anas ibn Malik (رضي الله عنه)',
      grade: 'Sahih',
      reference: 'Bukhari 13, Muslim 45',
      topic: 'Brotherhood & Love',
    ),
  ];

  // ───────────────────── DUA ─────────────────────
  static List<DuaCategory> get duaCategories => [
    const DuaCategory(
      id: 'morning',
      nameEnglish: 'Morning Adhkar',
      nameArabic: 'أذكار الصباح',
      icon: '🌅',
      duaCount: 12,
    ),
    const DuaCategory(
      id: 'evening',
      nameEnglish: 'Evening Adhkar',
      nameArabic: 'أذكار المساء',
      icon: '🌙',
      duaCount: 10,
    ),
    const DuaCategory(
      id: 'sleep',
      nameEnglish: 'Before Sleep',
      nameArabic: 'أذكار النوم',
      icon: '😴',
      duaCount: 8,
    ),
    const DuaCategory(
      id: 'prayer',
      nameEnglish: 'After Prayer',
      nameArabic: 'أذكار بعد الصلاة',
      icon: '🤲',
      duaCount: 15,
    ),
    const DuaCategory(
      id: 'quran',
      nameEnglish: 'Quranic Duas',
      nameArabic: 'أدعية قرآنية',
      icon: '📖',
      duaCount: 20,
    ),
    const DuaCategory(
      id: 'protection',
      nameEnglish: 'Protection',
      nameArabic: 'أدعية الحماية',
      icon: '🛡️',
      duaCount: 9,
    ),
    const DuaCategory(
      id: 'gratitude',
      nameEnglish: 'Gratitude & Praise',
      nameArabic: 'الشكر والحمد',
      icon: '✨',
      duaCount: 7,
    ),
    const DuaCategory(
      id: 'forgiveness',
      nameEnglish: 'Seeking Forgiveness',
      nameArabic: 'الاستغفار',
      icon: '🙏',
      duaCount: 11,
    ),
  ];

  static List<DuaModel> get featuredDuas => [
    const DuaModel(
      id: 'sayyid-istighfar',
      categoryId: 'forgiveness',
      titleEnglish: 'Sayyid al-Istighfar',
      arabicText:
          'اللَّهُمَّ أَنْتَ رَبِّي، لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ',
      transliteration:
          'Allahumma anta Rabbi, la ilaha illa anta, khalaqtani wa ana abduka...',
      translationEnglish:
          'O Allah, You are my Lord, there is no deity except You. You created me and I am Your servant...',
      reference: 'Sahih al-Bukhari 6306',
      occasion: 'Morning & Evening',
    ),
    const DuaModel(
      id: 'morning-1',
      categoryId: 'morning',
      titleEnglish: 'Dua Upon Waking',
      arabicText:
          'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
      transliteration:
          'Alhamdu lillahil-ladhi ahyana ba\'da ma amatana wa ilayhin-nushur',
      translationEnglish:
          'All praise is for Allah, Who has brought us back to life after He caused us to die, and to Him is the return.',
      reference: 'Sahih al-Bukhari 6312',
      occasion: 'Upon waking from sleep',
    ),
    const DuaModel(
      id: 'ayat-kursi-protection',
      categoryId: 'protection',
      titleEnglish: 'Ayat Al-Kursi',
      arabicText:
          'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ',
      transliteration:
          'Allahu la ilaha illa huwal-Hayyul-Qayyum. La ta\'khudhuhu sinatun wa la nawm...',
      translationEnglish:
          'Allah — there is no deity except Him, the Ever-Living, the Sustainer of existence. Neither drowsiness overtakes Him nor sleep...',
      reference: 'Quran 2:255',
      occasion: 'After every prayer, before sleep',
    ),
  ];
}
