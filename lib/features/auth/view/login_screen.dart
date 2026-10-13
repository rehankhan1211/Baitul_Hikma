import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/baitul_hikma_logo.dart';
import '../../../core/widgets/app_action_buttons.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submitLogin() async {
    final cubit = context.read<AuthCubit>();
    final success = await cubit.login(
      email: _emailCtrl.text,
      password: _passwordCtrl.text,
    );

    if (success && mounted) {
      context.go(AppRoutes.home);
    }
  }

  void _continueAsGuest() async {
    final cubit = context.read<AuthCubit>();
    await cubit.loginAsGuest();
    if (mounted) {
      context.go(AppRoutes.home);
    }
  }

  void _showForgotPasswordDialog() {
    final emailForgotCtrl = TextEditingController(text: _emailCtrl.text);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor:
                isDark ? AppColors.darkSurface : AppColors.parchment,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: AppColors.gold.withValues(alpha: 0.3)),
            ),
            title: Row(
              children: [
                const Icon(
                  CupertinoIcons.mail,
                  color: AppColors.gold,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  'Reset Password',
                  style: AppTextStyles.displaySmall(
                    color: isDark ? AppColors.gold : AppColors.emerald,
                  ).copyWith(fontSize: 18),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your registered email address to receive password reset instructions.',
                  style: AppTextStyles.bodyMedium(
                    color: isDark ? AppColors.sage : AppColors.inkLight,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailForgotCtrl,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.ink,
                  ),
                  decoration: InputDecoration(
                    hintText: 'your.email@example.com',
                    prefixIcon: const Icon(CupertinoIcons.mail, size: 20),
                    filled: true,
                    fillColor:
                        isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.gold.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: isDark ? AppColors.sage : AppColors.inkFaint,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.emerald,
                  foregroundColor: AppColors.ivory,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Password reset link sent to ${emailForgotCtrl.text.trim().isEmpty ? "your email" : emailForgotCtrl.text.trim()}',
                      ),
                      backgroundColor: AppColors.emerald,
                    ),
                  );
                },
                child: const Text('Send Link'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gold = AppColors.gold;
    final emerald = AppColors.emerald;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.parchment,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [AppTopActions(isDark: isDark), const SizedBox(width: 4)],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red.shade800,
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.read<AuthCubit>().clearMessages();
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ── Brand Emblem ──
                      BaitulHikmaLogo(width: 220, height: 120, isDark: isDark),
                      const SizedBox(height: 28),

                      // ── Card Container ──
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color:
                              isDark
                                  ? AppColors.darkSurface
                                  : Colors.white.withValues(alpha: 0.95),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: gold.withValues(alpha: isDark ? 0.25 : 0.2),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: isDark ? 0.35 : 0.06,
                              ),
                              blurRadius: 28,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Sign In to Your Sanctuary',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? AppColors.gold : emerald,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Continue your journey through classical manuscripts, sacred scriptures & history.',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bodySmall(
                                  color:
                                      isDark
                                          ? AppColors.sage
                                          : AppColors.inkFaint,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // ── Email Input ──
                              _buildInputField(
                                isDark: isDark,
                                label: 'Email Address',
                                hint: 'scholar@baitulhikma.org',
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: CupertinoIcons.mail,
                              ),
                              const SizedBox(height: 16),

                              // ── Password Input ──
                              _buildInputField(
                                isDark: isDark,
                                label: 'Password',
                                hint: '••••••••',
                                controller: _passwordCtrl,
                                obscureText: _obscurePassword,
                                prefixIcon: CupertinoIcons.lock,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye,
                                    size: 19,
                                    color:
                                        isDark
                                            ? AppColors.sage
                                            : AppColors.inkFaint,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 12),

                              // ── Remember Me & Forgot Password ──
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Checkbox(
                                          value: _rememberMe,
                                          activeColor: emerald,
                                          checkColor: AppColors.ivory,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          onChanged: (v) {
                                            setState(() {
                                              _rememberMe = v ?? true;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Remember me',
                                        style: AppTextStyles.bodySmall(
                                          color:
                                              isDark
                                                  ? AppColors.sage
                                                  : AppColors.inkLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: _showForgotPasswordDialog,
                                    child: Text(
                                      'Forgot password?',
                                      style: AppTextStyles.bodySmall(
                                        color: gold,
                                      ).copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 22),

                              // ── Submit Button ──
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.emerald,
                                      Color(0xFF2A5040),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: emerald.withValues(alpha: 0.35),
                                      blurRadius: 14,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  onPressed:
                                      state.isLoading ? null : _submitLogin,
                                  child:
                                      state.isLoading
                                          ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: AppColors.ivory,
                                              strokeWidth: 2.2,
                                            ),
                                          )
                                          : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Enter Library',
                                                style: GoogleFonts.inter(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.ivory,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              const Icon(
                                                CupertinoIcons.arrow_right,
                                                size: 16,
                                                color: AppColors.gold,
                                              ),
                                            ],
                                          ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // ── Or Divider ──
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color:
                                          isDark
                                              ? AppColors.darkDivider
                                              : AppColors.parchmentDark,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          size: 10,
                                          color: gold.withValues(alpha: 0.7),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'OR',
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1.5,
                                            color:
                                                isDark
                                                    ? AppColors.sage
                                                    : AppColors.inkFaint,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.star_rounded,
                                          size: 10,
                                          color: gold.withValues(alpha: 0.7),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color:
                                          isDark
                                              ? AppColors.darkDivider
                                              : AppColors.parchmentDark,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),

                              // ── Continue as Guest ──
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      isDark ? AppColors.ivory : emerald,
                                  side: BorderSide(
                                    color: gold.withValues(alpha: 0.5),
                                    width: 1.2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 13,
                                  ),
                                ),
                                onPressed:
                                    state.isLoading ? null : _continueAsGuest,
                                icon: const Icon(
                                  CupertinoIcons.compass,
                                  size: 18,
                                  color: AppColors.gold,
                                ),
                                label: Text(
                                  'Explore as Guest Seeker',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? AppColors.ivory : emerald,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ── Register Link ──
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 4,
                        children: [
                          Text(
                            "New to the House of Wisdom?",
                            style: AppTextStyles.bodyMedium(
                              color:
                                  isDark ? AppColors.sage : AppColors.inkLight,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.push(AppRoutes.register),
                            child: Text(
                              'Register Here',
                              style: AppTextStyles.bodyMedium(
                                color: gold,
                              ).copyWith(
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                decorationColor: gold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required bool isDark,
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.sage : AppColors.inkLight,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color:
                isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : const Color(0xFFFAF7F2),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark ? AppColors.darkDivider : AppColors.parchmentDark,
              width: 1.0,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isDark ? AppColors.ivory : AppColors.ink,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                fontSize: 13,
                color: isDark ? AppColors.sageDark : AppColors.inkFaint,
              ),
              prefixIcon: Icon(prefixIcon, size: 18, color: AppColors.gold),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
