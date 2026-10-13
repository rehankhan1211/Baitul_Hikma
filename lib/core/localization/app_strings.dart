import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/settings/bloc/settings_cubit.dart';

class AppStrings {
  final String languageCode;

  const AppStrings(this.languageCode);

  factory AppStrings.fromLocale(Locale locale) =>
      AppStrings(locale.languageCode);

  static AppStrings of(BuildContext context) {
    try {
      final state = context.watch<SettingsCubit>().state;
      return AppStrings(state.languageCode);
    } catch (_) {
      return const AppStrings('en');
    }
  }

  // --- Common & App Name ---
  String get appName => _t({
    'en': 'Baitul Hikma',
    'ar': 'بيت الحكمة',
    'ur': 'بیت الحکمہ',
    'id': 'Baitul Hikma',
    'tr': 'Beytülhikme',
  });

  String get home => _t({
    'en': 'Home',
    'ar': 'الرئيسية',
    'ur': 'ہوم',
    'id': 'Beranda',
    'tr': 'Ana Sayfa',
  });

  String get read => _t({
    'en': 'Read',
    'ar': 'اقرأ',
    'ur': 'مطالعہ',
    'id': 'Baca',
    'tr': 'Oku',
  });

  String get explore => _t({
    'en': 'Explore',
    'ar': 'استكشف',
    'ur': 'دریافت',
    'id': 'Jelajahi',
    'tr': 'Keşfet',
  });

  String get library => _t({
    'en': 'Library',
    'ar': 'المكتبة',
    'ur': 'لائبریری',
    'id': 'Perpustakaan',
    'tr': 'Kütüphane',
  });

  String get profile => myProfile;
  String get aboutBaitulHikma => aboutTitle;
  String get quran => nobleQuran;
  String get surah => surahTab;
  String get juz => juzTab;
  String get hadith => _t({
    'en': 'Hadith',
    'ar': 'الحديث',
    'ur': 'حدیث',
    'id': 'Hadis',
    'tr': 'Hadis',
  });
  String get hadithCollections => hadithTitle;
  String get theme => _t({
    'en': 'Theme',
    'ar': 'المظهر',
    'ur': 'تھیم',
    'id': 'Tema',
    'tr': 'Tema',
  });

  String get appSubtitle => _t({
    'en': 'House of Wisdom',
    'ar': 'دار الحكمة والكتب',
    'ur': 'حکمت و دانش کا گھر',
    'id': 'Rumah Kebijaksanaan',
    'tr': 'Hikmet Evi',
  });

  // --- Greetings ---
  String get goodMorning => _t({
    'en': 'Good morning',
    'ar': 'صباح الخير',
    'ur': 'صبح بخیر',
    'id': 'Selamat pagi',
    'tr': 'Günaydın',
  });

  String get goodAfternoon => _t({
    'en': 'Good afternoon',
    'ar': 'مساء الخير',
    'ur': 'دوپہر بخیر',
    'id': 'Selamat siang',
    'tr': 'Tünaydın',
  });

  String get goodEvening => _t({
    'en': 'Good evening',
    'ar': 'مساء النور',
    'ur': 'شام بخیر',
    'id': 'Selamat malam',
    'tr': 'İyi akşamlar',
  });

  String get assalamuAlaikum => _t({
    'en': 'Assalamu Alaikum',
    'ar': 'السلام عليكم',
    'ur': 'السلام علیکم',
    'id': 'Assalamu Alaikum',
    'tr': 'Selamün Aleyküm',
  });

  String get guest => _t({
    'en': 'Guest',
    'ar': 'ضيف',
    'ur': 'مہمان',
    'id': 'Tamu',
    'tr': 'Misafir',
  });

  // --- Home Screen ---
  String get streakLabel => _t({
    'en': 'Day Streak',
    'ar': 'أيام متتالية',
    'ur': 'روزانہ تسلسل',
    'id': 'Hari Beruntun',
    'tr': 'Günlük Seri',
  });

  String get ayahOfTheDay => _t({
    'en': 'ĀYAH OF THE DAY',
    'ar': 'آية اليوم',
    'ur': 'آج کی آیت',
    'id': 'AYAT HARI INI',
    'tr': 'GÜNÜN ÂYETİ',
  });

  String get hadithOfTheDay => _t({
    'en': 'HADITH OF THE DAY',
    'ar': 'حديث اليوم',
    'ur': 'آج کی حدیث',
    'id': 'HADIS HARI INI',
    'tr': 'GÜNÜN HADİSİ',
  });

  String get quickAccess => _t({
    'en': 'QUICK ACCESS',
    'ar': 'وصول سريع',
    'ur': 'فوری رسائی',
    'id': 'AKSES CEPAT',
    'tr': 'HIZLI ERİŞİM',
  });

  String get exploreHistory => _t({
    'en': 'EXPLORE HISTORY',
    'ar': 'استكشف التاريخ',
    'ur': 'تاریخ دریافت کریں',
    'id': 'JELAJAHI SEJARAH',
    'tr': 'TARİHİ KEŞFET',
  });

  String get seeAll => _t({
    'en': 'See all',
    'ar': 'عرض الكل',
    'ur': 'سب دیکھیں',
    'id': 'Lihat semua',
    'tr': 'Hepsini gör',
  });

  // --- Quran Screen ---
  String get nobleQuran => _t({
    'en': 'The Noble Quran',
    'ar': 'القرآن الكريم',
    'ur': 'قرآن مجید',
    'id': 'Al-Qur\'an Al-Karim',
    'tr': 'Kur\'an-ı Kerim',
  });

  String get surahTab => _t({
    'en': 'Surah',
    'ar': 'السور',
    'ur': 'سورتیں',
    'id': 'Surah',
    'tr': 'Sureler',
  });

  String get juzTab => _t({
    'en': 'Juz',
    'ar': 'الأجزاء',
    'ur': 'پارے',
    'id': 'Juz',
    'tr': 'Cüzler',
  });

  String get ayahsCountSuffix => _t({
    'en': 'Ayahs',
    'ar': 'آيات',
    'ur': 'آیات',
    'id': 'Ayat',
    'tr': 'Ayet',
  });

  // --- Hadith Screen ---
  String get hadithTitle => _t({
    'en': 'Hadith Collections',
    'ar': 'مجموعات الحديث',
    'ur': 'کتب احادیث',
    'id': 'Koleksi Hadis',
    'tr': 'Hadis Külliyatı',
  });

  String get collectionsLabel => _t({
    'en': 'COLLECTIONS',
    'ar': 'المجموعات',
    'ur': 'مجموعے',
    'id': 'KOLEKSI',
    'tr': 'KÜLLİYAT',
  });

  String get featuredHadiths => _t({
    'en': 'FEATURED HADITHS',
    'ar': 'أحاديث مختارة',
    'ur': 'منتخب احادیث',
    'id': 'HADIS PILIHAN',
    'tr': 'ÖNE ÇIKAN HADİSLER',
  });

  // --- Explore Screen ---
  String get exploreWisdom => _t({
    'en': 'Explore Wisdom',
    'ar': 'استكشف الحكمة',
    'ur': 'حکمت دریافت کریں',
    'id': 'Jelajahi Kebijaksanaan',
    'tr': 'Hikmeti Keşfet',
  });

  String get bookshelf => _t({
    'en': 'Bookshelf',
    'ar': 'الرفوف',
    'ur': 'کتابیں',
    'id': 'Rak Buku',
    'tr': 'Kitaplık',
  });

  String get timeline => _t({
    'en': 'Timeline',
    'ar': 'الخط الزمني',
    'ur': 'ٹائم لائن',
    'id': 'Garis Waktu',
    'tr': 'Zaman Çizelgesi',
  });

  // --- Library Screen ---
  String get myLibrary => _t({
    'en': 'My Library',
    'ar': 'مكتبتي',
    'ur': 'میری لائبریری',
    'id': 'Perpustakaan Saya',
    'tr': 'Kütüphanem',
  });

  String get bookmarks => _t({
    'en': 'Bookmarks',
    'ar': 'العلامات المرجعية',
    'ur': 'بک مارکس',
    'id': 'Penanda Buku',
    'tr': 'Yer İmleri',
  });

  String get history => _t({
    'en': 'History',
    'ar': 'السجل',
    'ur': 'تاریخچہ',
    'id': 'Riwayat',
    'tr': 'Geçmiş',
  });

  // --- Profile Screen ---
  String get myProfile => _t({
    'en': 'My Profile',
    'ar': 'ملفي الشخصي',
    'ur': 'میرا پروفائل',
    'id': 'Profil Saya',
    'tr': 'Profilim',
  });

  String get editProfile => _t({
    'en': 'Edit Profile',
    'ar': 'تعديل الملف',
    'ur': 'پروفائل میں ترمیم',
    'id': 'Edit Profil',
    'tr': 'Profili Düzenle',
  });

  String get readingProgress => _t({
    'en': 'READING PROGRESS',
    'ar': 'تقدم القراءة',
    'ur': 'مطالعے کی پیشرفت',
    'id': 'KEMAJUAN MEMBACA',
    'tr': 'OKUMA GELİŞİMİ',
  });

  String get recentActivity => _t({
    'en': 'RECENT ACTIVITY',
    'ar': 'النشاط الأخير',
    'ur': 'حالیہ سرگرمی',
    'id': 'AKTIVITAS TERBARU',
    'tr': 'SON AKTİVİTE',
  });

  String get savedCollections => _t({
    'en': 'SAVED COLLECTIONS',
    'ar': 'المجموعات المحفوظة',
    'ur': 'محفوظ مجموعے',
    'id': 'KOLEKSI TERSIMPAN',
    'tr': 'KAYDEDİLENLER',
  });

  String get accountControls => _t({
    'en': 'ACCOUNT CONTROLS',
    'ar': 'إدارة الحساب',
    'ur': 'اکاؤنٹ کنٹرول',
    'id': 'PENGATURAN AKUN',
    'tr': 'HESAP AYARLARI',
  });

  String get signOut => _t({
    'en': 'Sign Out',
    'ar': 'تسجيل الخروج',
    'ur': 'سائن آؤٹ',
    'id': 'Keluar',
    'tr': 'Çıkış Yap',
  });

  String get signIn => _t({
    'en': 'Sign In',
    'ar': 'تسجيل الدخول',
    'ur': 'سائن ان',
    'id': 'Masuk',
    'tr': 'Giriş Yap',
  });

  // --- Settings Screen ---
  String get settings => _t({
    'en': 'Settings',
    'ar': 'الإعدادات',
    'ur': 'ترتیبات',
    'id': 'Pengaturan',
    'tr': 'Ayarlar',
  });

  String get appearance => _t({
    'en': 'APPEARANCE',
    'ar': 'المظهر',
    'ur': 'ظاہری شکل',
    'id': 'TAMPILAN',
    'tr': 'GÖRÜNÜM',
  });

  String get language => _t({
    'en': 'Language',
    'ar': 'اللغة',
    'ur': 'زبان',
    'id': 'Bahasa',
    'tr': 'Dil',
  });

  String get languageSectionTitle => _t({
    'en': 'LANGUAGE & LOCALE',
    'ar': 'اللغة والمنطقة',
    'ur': 'زبان اور علاقہ',
    'id': 'BAHASA & WILAYAH',
    'tr': 'DİL VE BÖLGE',
  });

  String get readingPreferences => _t({
    'en': 'READING PREFERENCES',
    'ar': 'تفضيلات القراءة',
    'ur': 'مطالعے کی ترجیحات',
    'id': 'PREFERENSI MEMBACA',
    'tr': 'OKUMA TERCİHLERİ',
  });

  String get selectLanguage => _t({
    'en': 'Select Language',
    'ar': 'اختر اللغة',
    'ur': 'زبان منتخب کریں',
    'id': 'Pilih Bahasa',
    'tr': 'Dil Seçin',
  });

  // --- About Screen ---
  String get aboutTitle => _t({
    'en': 'About Baitul Hikma',
    'ar': 'عن بيت الحكمة',
    'ur': 'بیت الحکمہ کے بارے میں',
    'id': 'Tentang Baitul Hikma',
    'tr': 'Beytülhikme Hakkında',
  });

  // --- Helper ---
  String _t(Map<String, String> values) {
    return values[languageCode] ?? values['en'] ?? '';
  }
}

extension AppLocalizationExtension on BuildContext {
  AppStrings get l10n => AppStrings.of(this);
}
