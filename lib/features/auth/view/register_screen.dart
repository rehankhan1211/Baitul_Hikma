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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _submitRegister() async {
    final cubit = context.read<AuthCubit>();
    final success = await cubit.register(
      name: _nameCtrl.text,
      email: _emailCtrl.text,
      password: _passwordCtrl.text,
      confirmPassword: _confirmPasswordCtrl.text,
      agreedToTerms: _agreedToTerms,
    );

    if (success && mounted) {
      context.go(AppRoutes.home);
    }
  }

  int _calculatePasswordStrength(String pass) {
    if (pass.isEmpty) return 0;
    int strength = 0;
    if (pass.length >= 6) strength++;
    if (pass.length >= 8 && RegExp(r'[0-9]').hasMatch(pass)) strength++;
    if (RegExp(r'[A-Z]').hasMatch(pass) &&
        RegExp(r'[^a-zA-Z0-9]').hasMatch(pass)) {
      strength++;
    }
    return strength;
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
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: isDark ? AppColors.gold : emerald,
          ),
          onPressed: () => context.pop(),
        ),
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
          final passStrength = _calculatePasswordStrength(_passwordCtrl.text);

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    children: [
                      // ── Brand Emblem ──
                      BaitulHikmaLogo(width: 200, height: 110, isDark: isDark),
                      const SizedBox(height: 20),

                      // ── Card Container ──
                      Container(
                        padding: const EdgeInsets.all(26),
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
                                'Join the Circle of Wisdom',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? AppColors.gold : emerald,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Create your personal account to bookmark verses, track reading streaks & explore manuscripts.',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bodySmall(
                                  color:
                                      isDark
                                          ? AppColors.sage
                                          : AppColors.inkFaint,
                                ),
                              ),
                              const SizedBox(height: 22),

                              // ── Full Name Input ──
                              _buildInputField(
                                isDark: isDark,
                                label: 'Full Name',
                                hint: 'e.g., Ibn Sina or Maryam',
                                controller: _nameCtrl,
                                prefixIcon: CupertinoIcons.person,
                              ),
                              const SizedBox(height: 14),

                              // ── Email Input ──
                              _buildInputField(
                                isDark: isDark,
                                label: 'Email Address',
                                hint: 'scholar@baitulhikma.org',
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: CupertinoIcons.mail,
                              ),
                              const SizedBox(height: 14),

                              // ── Password Input ──
                              _buildInputField(
                                isDark: isDark,
                                label: 'Password',
                                hint: 'Minimum 6 characters',
                                controller: _passwordCtrl,
                                obscureText: _obscurePassword,
                                prefixIcon: CupertinoIcons.lock,
                                onChanged: (v) => setState(() {}),
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
                              const SizedBox(height: 6),

                              // ── Password Strength Bar ──
                              if (_passwordCtrl.text.isNotEmpty) ...[
                                Row(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: (passStrength / 3).clamp(
                                            0.2,
                                            1.0,
                                          ),
                                          backgroundColor:
                                              isDark
                                                  ? AppColors.darkDivider
                                                  : AppColors.parchmentDark,
                                          color:
                                              passStrength == 1
                                                  ? Colors.amber.shade700
                                                  : passStrength == 2
                                                  ? AppColors.gold
                                                  : Colors.green.shade600,
                                          minHeight: 4,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      passStrength == 1
                                          ? 'Fair'
                                          : passStrength == 2
                                          ? 'Good'
                                          : 'Strong',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            passStrength == 1
                                                ? Colors.amber.shade700
                                                : passStrength == 2
                                                ? AppColors.gold
                                                : Colors.green.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],

                              // ── Confirm Password Input ──
                              _buildInputField(
                                isDark: isDark,
                                label: 'Confirm Password',
                                hint: 'Re-enter your password',
                                controller: _confirmPasswordCtrl,
                                obscureText: _obscureConfirmPassword,
                                prefixIcon: CupertinoIcons.lock_shield,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
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
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 14),

                              // ── Terms & Ethics Checkbox ──
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Checkbox(
                                      value: _agreedToTerms,
                                      activeColor: emerald,
                                      checkColor: AppColors.ivory,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      onChanged: (v) {
                                        setState(() {
                                          _agreedToTerms = v ?? true;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'I agree to the Library Ethics & Preservation Guidelines',
                                      style: AppTextStyles.bodySmall(
                                        color:
                                            isDark
                                                ? AppColors.sage
                                                : AppColors.inkLight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 22),

                              // ── Register Submit Button ──
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
                                      state.isLoading ? null : _submitRegister,
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
                                                'Create Account',
                                                style: GoogleFonts.inter(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.ivory,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              const Icon(
                                                CupertinoIcons.checkmark_seal,
                                                size: 16,
                                                color: AppColors.gold,
                                              ),
                                            ],
                                          ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // ── Login Link ──
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 4,
                        children: [
                          Text(
                            "Already a member of the Library?",
                            style: AppTextStyles.bodyMedium(
                              color:
                                  isDark ? AppColors.sage : AppColors.inkLight,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Text(
                              'Sign In',
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
    ValueChanged<String>? onChanged,
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
            onChanged: onChanged,
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
