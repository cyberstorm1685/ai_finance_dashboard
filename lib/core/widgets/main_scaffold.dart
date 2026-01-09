import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../main.dart';
import '../constants/colors.dart';

class MainScaffold extends ConsumerWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
          ref.read(bottomNavIndexProvider.notifier).state = i;
          switch (i) {
            case 0: context.go('/dashboard'); break;
            case 1: context.go('/insights'); break;
            case 2: context.go('/profile'); break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Insights'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}