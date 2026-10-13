import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/local_storage_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LocalStorageService storage;

  AuthCubit({required this.storage})
    : super(
        AuthState(
          isLoggedIn: storage.isLoggedIn,
          isGuest: storage.isGuest,
          userName: storage.currentUserName ?? '',
          userEmail: storage.currentUserEmail ?? '',
        ),
      );

  void clearMessages() {
    emit(state.copyWith(clearError: true, clearSuccess: true));
  }

  Future<bool> login({required String email, required String password}) async {
    final cleanEmail = email.trim();
    final cleanPassword = password.trim();

    if (cleanEmail.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Please enter your email address.',
          clearSuccess: true,
        ),
      );
      return false;
    }

    if (!cleanEmail.contains('@') || !cleanEmail.contains('.')) {
      emit(
        state.copyWith(
          errorMessage: 'Please enter a valid email address.',
          clearSuccess: true,
        ),
      );
      return false;
    }

    if (cleanPassword.length < 6) {
      emit(
        state.copyWith(
          errorMessage: 'Password must be at least 6 characters.',
          clearSuccess: true,
        ),
      );
      return false;
    }

    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    // Simulate authentication delay for smooth UX
    await Future.delayed(const Duration(milliseconds: 700));

    // Derive display name from email or previous name
    final name = cleanEmail.split('@').first;
    final formattedName =
        name.isNotEmpty
            ? '${name[0].toUpperCase()}${name.substring(1)}'
            : 'Seeker of Wisdom';

    await storage.saveUser(
      name: formattedName,
      email: cleanEmail,
      isGuest: false,
    );

    emit(
      state.copyWith(
        isLoading: false,
        isLoggedIn: true,
        isGuest: false,
        userName: formattedName,
        userEmail: cleanEmail,
        successMessage: 'Welcome back to the House of Wisdom',
      ),
    );
    return true;
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required bool agreedToTerms,
  }) async {
    final cleanName = name.trim();
    final cleanEmail = email.trim();
    final cleanPassword = password.trim();

    if (cleanName.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Please enter your full name.',
          clearSuccess: true,
        ),
      );
      return false;
    }

    if (cleanEmail.isEmpty ||
        !cleanEmail.contains('@') ||
        !cleanEmail.contains('.')) {
      emit(
        state.copyWith(
          errorMessage: 'Please enter a valid email address.',
          clearSuccess: true,
        ),
      );
      return false;
    }

    if (cleanPassword.length < 6) {
      emit(
        state.copyWith(
          errorMessage: 'Password must be at least 6 characters.',
          clearSuccess: true,
        ),
      );
      return false;
    }

    if (cleanPassword != confirmPassword.trim()) {
      emit(
        state.copyWith(
          errorMessage: 'Passwords do not match.',
          clearSuccess: true,
        ),
      );
      return false;
    }

    if (!agreedToTerms) {
      emit(
        state.copyWith(
          errorMessage: 'Please accept the library terms and ethics.',
          clearSuccess: true,
        ),
      );
      return false;
    }

    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    await Future.delayed(const Duration(milliseconds: 800));

    await storage.saveUser(name: cleanName, email: cleanEmail, isGuest: false);

    emit(
      state.copyWith(
        isLoading: false,
        isLoggedIn: true,
        isGuest: false,
        userName: cleanName,
        userEmail: cleanEmail,
        successMessage: 'Welcome to Baitul Hikma!',
      ),
    );
    return true;
  }

  Future<void> loginAsGuest() async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));
    await Future.delayed(const Duration(milliseconds: 400));

    await storage.saveUser(
      name: 'Guest Seeker',
      email: 'guest@baitulhikma.org',
      isGuest: true,
    );

    emit(
      state.copyWith(
        isLoading: false,
        isLoggedIn: true,
        isGuest: true,
        userName: 'Guest Seeker',
        userEmail: 'guest@baitulhikma.org',
        successMessage: 'Entering as guest seeker',
      ),
    );
  }

  Future<bool> updateProfile({required String name, String? email}) async {
    final cleanName = name.trim();
    if (cleanName.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Please enter a valid name.',
          clearSuccess: true,
        ),
      );
      return false;
    }

    final cleanEmail =
        (email != null && email.trim().isNotEmpty)
            ? email.trim()
            : state.userEmail;

    if (cleanEmail.isNotEmpty &&
        (!cleanEmail.contains('@') || !cleanEmail.contains('.'))) {
      emit(
        state.copyWith(
          errorMessage: 'Please enter a valid email address.',
          clearSuccess: true,
        ),
      );
      return false;
    }

    await storage.saveUser(
      name: cleanName,
      email: cleanEmail,
      isGuest: state.isGuest,
    );

    emit(
      state.copyWith(
        userName: cleanName,
        userEmail: cleanEmail,
        successMessage: 'Profile updated successfully.',
        clearError: true,
      ),
    );
    return true;
  }

  Future<void> logout() async {
    await storage.logout();
    emit(
      const AuthState(
        isLoggedIn: false,
        isGuest: false,
        userName: '',
        userEmail: '',
      ),
    );
  }
}
