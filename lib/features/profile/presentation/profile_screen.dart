import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../main.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kSpacingLarge),
        child: Column(
          children: [
            GestureDetector(onTap: _pickImage, child: CircleAvatar(radius: 50, backgroundImage: _image != null ? FileImage(_image!) : null)),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: isDark,
              onChanged: (val) => ref.read(themeModeProvider.notifier).state = val ? ThemeMode.dark : ThemeMode.light,
            ),
            DropdownButton<String>(
              value: 'English',
              items: ['English', 'Hindi'].map((lang) => DropdownMenuItem(value: lang, child: Text(lang))).toList(),
              onChanged: (_) {},
            ),
            CustomButton(
              text: 'Logout',
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => FadeTransition(
                  opacity: const AlwaysStoppedAnimation(1),
                  child: AlertDialog(
                    title: const Text('Logout?'),
                    actions: [TextButton(onPressed: () => context.go('/login'), child: const Text('Yes'))],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}