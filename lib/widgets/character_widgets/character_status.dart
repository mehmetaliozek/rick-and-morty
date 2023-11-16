import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/constants/app_colors.dart';

class CharacterStatus extends StatelessWidget {
  const CharacterStatus({super.key, required this.status, required this.species});

  final String status;
  final String species;

  Color _statusColor(String s) {
    switch (s) {
      case "alive":
        return Colors.green;
      case "dead":
        return Colors.red;
      case "unknown":
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: _statusColor(status.toLowerCase()),
          size: 12.5,
        ),
        const SizedBox(width: 6.25),
        SizedBox(
          width: MediaQuery.of(context).size.width - 210,
          child: AutoSizeText(
            "$status - $species",
            style: GoogleFonts.robotoCondensed(color: AppColors.antiFlashWhite),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
