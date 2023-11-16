import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/constants/app_colors.dart';

class CharacterInfo extends StatelessWidget {
  const CharacterInfo({super.key, required this.text, required this.location});

  final String text;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.robotoCondensed(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 191,
          child: AutoSizeText(
            location,
            style: GoogleFonts.robotoCondensed(color: AppColors.antiFlashWhite),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
