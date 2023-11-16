import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/constants/app_colors.dart';

class PaginationBottomSheet extends StatelessWidget {
  const PaginationBottomSheet({super.key, required this.currentPage, required this.childCount, required this.onSelectedItemChanged});
  final Function(int value) onSelectedItemChanged;
  final int currentPage;
  final int childCount;
  static int _value = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Page",
              style: GoogleFonts.robotoCondensed(fontSize: 24, color: AppColors.antiFlashWhite),
            ),
          ),
          Expanded(
            child: CupertinoPicker.builder(
              childCount: childCount,
              itemExtent: 60,
              scrollController: FixedExtentScrollController(initialItem: currentPage),
              onSelectedItemChanged: (value) {
                _value = value;
              },
              itemBuilder: (context, index) {
                return TextButton(
                  onPressed: () {
                    onSelectedItemChanged(_value);
                    Get.back();
                  },
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: GoogleFonts.robotoCondensed(fontSize: 24, color: AppColors.antiFlashWhite),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
