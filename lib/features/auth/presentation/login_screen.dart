import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/colors.dart';
import 'login_notifier.dart';
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final notifier = ref.read(loginProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kSpacingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              label: 'Email',
              onChanged: notifier.updateEmail,
              errorText: loginState['emailValid'] ? null : '',
            ),
            CustomTextField(
              label: 'Password',
              obscureText: true,
              onChanged: notifier.updatePassword,
            ),
            const SizedBox(height: kSpacingMedium),
            LinearProgressIndicator(
              value: loginState['passwordStrength'] / 2.0,
              backgroundColor: Colors.grey[300],
              color: loginState['passwordStrength'] == 2
                  ? AppColors.secondary
                  : (loginState['passwordStrength'] == 1 ? Colors.orange : AppColors.error),
            ),
            const SizedBox(height: kSpacingLarge),
            CustomButton(
              text: 'Login',
              onPressed: () => context.go('/dashboard'),
            ),
            const SizedBox(height: kSpacingMedium),
            CustomButton(
              text: 'Login with Google',
              icon: Icons.g_mobiledata,
              isGoogle: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}