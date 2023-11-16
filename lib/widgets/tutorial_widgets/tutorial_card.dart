import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/constants/app_colors.dart';

class TutorialCard extends StatelessWidget {
  const TutorialCard({super.key, required this.text, required this.bottom});
  final String text;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.5),
      margin: EdgeInsets.only(bottom: bottom),
      decoration: BoxDecoration(
        color: AppColors.onyx,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.circle,
          color: AppColors.antiFlashWhite,
          size: 10,
        ),
        title: Text(
          text,
          style: GoogleFonts.robotoCondensed(
            fontSize: 20,
            color: AppColors.antiFlashWhite,
          ),
        ),
      ),
    );
  }
}
