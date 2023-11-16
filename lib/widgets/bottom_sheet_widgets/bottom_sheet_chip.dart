import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/constants/app_colors.dart';

class BottomSheetChip extends StatelessWidget {
  const BottomSheetChip({super.key, required this.text, required this.isSelected, required this.onSelected});
  final String text;
  final Function(bool value) onSelected;
  final RxBool isSelected;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: FilterChip(
          label: Text(
            firstLetterUpper(text),
            style: GoogleFonts.robotoCondensed(),
          ),
          onSelected: (value) {
            onSelected(isSelected.value);
          },
          selected: isSelected.value,
          backgroundColor: Colors.grey,
          selectedColor: AppColors.antiFlashWhite,
          shape: const StadiumBorder(),
        ),
      ),
    );
  }

  String firstLetterUpper(String text) {
    String word = "";
    word += text[0].toUpperCase();
    for (var i = 1; i < text.length; i++) {
      word += text[i];
    }
    return word;
  }
}
