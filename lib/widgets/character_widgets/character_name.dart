import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/constants/app_colors.dart';

class CharacterName extends StatelessWidget {
  const CharacterName({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 191,
      child: AutoSizeText(
        name,
        style: GoogleFonts.robotoCondensed(fontSize: 24, color: AppColors.antiFlashWhite),
        maxLines: 1,
      ),
    );
  }
}
