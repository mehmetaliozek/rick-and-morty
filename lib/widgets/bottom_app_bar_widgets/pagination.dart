import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/app_colors.dart';

class Pagination extends StatelessWidget {
  const Pagination({super.key, required this.onPressed, required this.icon});
  final Function onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPressed();
      },
      icon: Icon(
        icon,
        color: AppColors.antiFlashWhite,
      ),
    );
  }
}
