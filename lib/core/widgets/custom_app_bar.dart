import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primary, AppColors.secondary]),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26)],
      ),
      child: Center(child: Text('Dashboard', style: TextStyle(color: Colors.white, fontSize: 20))),
    );
  }
}