import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/widgets/baitul_hikma_logo.dart';

/// Splash Screen for Baitul Hikma
/// Shows the official Baitul Hikma logo in the center against a pure white background
/// for 3 seconds, then smoothly redirects to the Login page.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Set status bar to dark icons on white background
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn);

    _scaleAnimation = Tween<double>(
      begin: 0.90,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));

    _animCtrl.forward();

    // Exactly 3 seconds display time, then redirect to login screen
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(AppRoutes.login);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Rest of the screen in pure white
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: BaitulHikmaLogo(
                  width: 280,
                  height: 180,
                  fit: BoxFit.contain,
                  isDark: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
