import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/constants/app_colors.dart';
import 'package:rick_and_morty/utils/tutorial.dart';

class PageNumber extends StatelessWidget {
  const PageNumber({super.key, required this.onPressed, required this.maxPage, required this.currentPage});
  final Function onPressed;
  final int maxPage;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: Tutorial.pageKey,
      onPressed: () {
        onPressed();
      },
      child: Text(
        "$currentPage/$maxPage",
        style: GoogleFonts.robotoCondensed(color: AppColors.antiFlashWhite),
      ),
    );
  }
}
