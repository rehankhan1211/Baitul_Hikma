import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool isLoggedIn;
  final bool isGuest;
  final String userName;
  final String userEmail;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const AuthState({
    this.isLoggedIn = false,
    this.isGuest = false,
    this.userName = '',
    this.userEmail = '',
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    bool? isGuest,
    String? userName,
    String? userEmail,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isGuest: isGuest ?? this.isGuest,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage:
          clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [
    isLoggedIn,
    isGuest,
    userName,
    userEmail,
    isLoading,
    errorMessage,
    successMessage,
  ];
}
