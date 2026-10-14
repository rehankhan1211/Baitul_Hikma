import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/baitul_hikma_logo.dart';
import '../../../core/widgets/app_action_buttons.dart';
import '../../../core/localization/app_strings.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  void _showPolicyDialog(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.darkCard : AppColors.ivory,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (ctx) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.4,
            maxChildSize: 0.95,
            expand: false,
            builder:
                (_, scrollCtrl) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: ListView(
                    controller: scrollCtrl,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.displaySmall(
                              color:
                                  isDark ? AppColors.gold : AppColors.emerald,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () => Navigator.of(ctx).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        content,
                        style: AppTextStyles.bodyMedium(
                          color:
                              isDark ? AppColors.ivoryDark : AppColors.inkLight,
                        ).copyWith(height: 1.7),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.emerald,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Understood'),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final messageCtrl = TextEditingController();

    showDialog<void>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor: isDark ? AppColors.darkCard : AppColors.ivory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Send Reader Feedback',
              style: AppTextStyles.displaySmall(
                color: isDark ? AppColors.gold : AppColors.emerald,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'We value your insights and corrections. Your feedback helps preserve scholarly integrity.',
                  style: AppTextStyles.bodySmall(
                    color: isDark ? AppColors.sage : AppColors.inkFaint,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: messageCtrl,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Share corrections, questions, or ideas...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.emerald,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Thank you! Your feedback has been noted.'),
                      backgroundColor: AppColors.emerald,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text('Submit'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
        title: Text(
          context.l10n.aboutBaitulHikma,
          style: AppTextStyles.displaySmall(
            color: isDark ? AppColors.gold : AppColors.emerald,
          ).copyWith(fontSize: 20),
        ),
        actions: [AppTopActions(isDark: isDark), const SizedBox(width: 4)],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── HERO IDENTITY HEADER ──
            Center(
              child: Column(
                children: [
                  BaitulHikmaLogo(width: 200, height: 110, isDark: isDark),
                  const SizedBox(height: 12),
                  Text(
                    AppConstants.appName,
                    style: AppTextStyles.displayMedium(
                      color: isDark ? AppColors.gold : AppColors.emerald,
                    ).copyWith(fontSize: 26),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppConstants.appSubtitle,
                    style: AppTextStyles.labelLarge(
                      color: isDark ? AppColors.sage : AppColors.inkFaint,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Version 1.0.0 (Build 1)',
                      style: AppTextStyles.labelMedium(
                        color: AppColors.goldDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ── MISSION & HERITAGE ──
            _EditorialCard(
              title: 'HERITAGE & IDENTITY',
              isDark: isDark,
              child: Text(
                'Baitul Hikma (The House of Wisdom) draws inspiration from the renowned 9th-century Baghdad library and translation institution that sparked the Golden Age of Islam. Our digital sanctuary honors that tradition by curating sacred scriptures, prophetic traditions, and intellectual masterpieces into a serene, contemplative reading environment.',
                style: AppTextStyles.bodyMedium(
                  color: isDark ? AppColors.ivoryDark : AppColors.inkLight,
                ).copyWith(height: 1.7),
              ),
            ),
            const SizedBox(height: 16),

            _EditorialCard(
              title: 'OUR MISSION',
              isDark: isDark,
              child: Text(
                'To make sacred texts, authentic Hadiths, and civilizational history effortlessly accessible through timeless typography, editorial craftsmanship, and distraction-free digital design.',
                style: AppTextStyles.bodyMedium(
                  color: isDark ? AppColors.ivoryDark : AppColors.inkLight,
                ).copyWith(height: 1.7),
              ),
            ),
            const SizedBox(height: 16),

            // ── CONTENT CATEGORIES ──
            _EditorialCard(
              title: 'COLLECTIONS IN BAITUL HIKMA',
              isDark: isDark,
              child: Column(
                children: [
                  _CategoryRow(
                    icon: Icons.menu_book_rounded,
                    title: 'Al Quran',
                    subtitle:
                        'Full 114 Surahs with authentic Amiri Arabic typography and verified translations.',
                    isDark: isDark,
                  ),
                  const Divider(height: 20),
                  _CategoryRow(
                    icon: Icons.library_books_rounded,
                    title: 'Hadith Collections',
                    subtitle:
                        'Treasury of prophetic wisdom from Sahih al-Bukhari, Sahih Muslim, Forty Hadith, and Abu Dawud.',
                    isDark: isDark,
                  ),
                  const Divider(height: 20),
                  _CategoryRow(
                    icon: Icons.history_edu_rounded,
                    title: 'Civilization Chronicles',
                    subtitle:
                        'Interactive historical timelines spanning the Prophetic Era, Rightly Guided Caliphs, and the Baghdad Scholars.',
                    isDark: isDark,
                  ),
                  const Divider(height: 20),
                  _CategoryRow(
                    icon: Icons.favorite_border_rounded,
                    title: 'Sacred Invocations & Adhkar',
                    subtitle:
                        'Daily morning, evening, and Quranic supplications with clear transliterations.',
                    isDark: isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── SOURCE INTEGRITY ──
            _EditorialCard(
              title: 'SCHOLARLY INTEGRITY & ATTRIBUTION',
              isDark: isDark,
              child: Text(
                'All Quranic verses conform to the recognized Madinah Mushaf tradition. Hadith records preserve primary attribution, narrator chains, and authenticated collection identifiers. We uphold strict standards against unverified attributions.',
                style: AppTextStyles.bodyMedium(
                  color: isDark ? AppColors.ivoryDark : AppColors.inkLight,
                ).copyWith(height: 1.7),
              ),
            ),
         
            const SizedBox(height: 16),

            // ── CONTACT & LEGAL ──
            _EditorialCard(
              title: 'SUPPORT & LEGAL ETHICS',
              isDark: isDark,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.mail_outline_rounded),
                    title: Text(
                      'Reader Support & Inquiries',
                      style: AppTextStyles.bodyMedium(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ),
                    ),
                    subtitle: Text(
                      'support@baitulhikma.org',
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.sage : AppColors.inkFaint,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 18,
                    ),
                    onTap: () => _showFeedbackDialog(context),
                  ),
                  const Divider(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: Text(
                      'Privacy Policy',
                      style: AppTextStyles.bodyMedium(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 13,
                    ),
                    onTap:
                        () => _showPolicyDialog(
                          context,
                          title: 'Privacy Policy',
                          content:
                              'Baitul Hikma is designed as a private sanctuary of learning. All reading statistics, bookmarks, progress, and preferences are stored locally on your device via encrypted key-value storage. We do not sell your personal data, track your browsing across the web, or collect intrusive usage logs.',
                        ),
                  ),
                  const Divider(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.gavel_rounded),
                    title: Text(
                      'Terms of Use & Ethics',
                      style: AppTextStyles.bodyMedium(
                        color: isDark ? AppColors.ivory : AppColors.ink,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 13,
                    ),
                    onTap:
                        () => _showPolicyDialog(
                          context,
                          title: 'Terms of Use',
                          content:
                              'Content hosted within Baitul Hikma is provided for personal educational, spiritual, and scholarly non-commercial study. Users are encouraged to share wisdom freely while maintaining source respect and text integrity.',
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

class _EditorialCard extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isDark;

  const _EditorialCard({
    required this.title,
    required this.child,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.ivory,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? AppColors.darkDivider : AppColors.ivoryDark,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.sectionLabel(
              color: isDark ? AppColors.gold : AppColors.emerald,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDark;

  const _CategoryRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.emerald.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isDark ? AppColors.gold : AppColors.emerald,
            size: 20,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyLarge(
                  color: isDark ? AppColors.ivory : AppColors.ink,
                ).copyWith(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTextStyles.bodySmall(
                  color: isDark ? AppColors.sage : AppColors.inkFaint,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

