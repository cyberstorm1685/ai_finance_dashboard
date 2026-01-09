import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends AutoDisposeNotifier<Map<String, dynamic>> {
  @override
  Map<String, dynamic> build() => {
    'email': '',
    'password': '',
    'emailValid': false,
    'passwordStrength': 1,  // 0: weak, 1: medium, 2: strong
  };

  void updateEmail(String email) {
    final isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    state = {...state, 'email': email, 'emailValid': isValid};
  }

  void updatePassword(String password) {
    int strength = 0;
    if (password.length > 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password) && RegExp(r'[0-9]').hasMatch(password)) strength++;
    state = {...state, 'password': password, 'passwordStrength': strength};
  }
}

final loginProvider = AutoDisposeNotifierProvider<LoginNotifier, Map<String, dynamic>>(LoginNotifier.new);