import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/constants/app_colors.dart';
import 'package:rick_and_morty/controllers/rick_and_morty_controller.dart';
import 'package:rick_and_morty/utils/gender.dart';
import 'package:rick_and_morty/utils/status.dart';
import 'package:rick_and_morty/widgets/bottom_sheet_widgets/bottom_sheet_chip.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});
  static final RickAndMortyController _controller = Get.put(RickAndMortyController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: _filterTitle("Filter", 16.0)),
          _filterTitle("Gender", 8.0),
          _filterGenderChips(),
          _filterTitle("Status", 8.0),
          _filterStatusChips(),
        ],
      ),
    );
  }

  Widget _filterTitle(String text, double vPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vPadding),
      child: Text(
        text,
        style: GoogleFonts.robotoCondensed(fontSize: 24, color: AppColors.antiFlashWhite),
      ),
    );
  }

  Widget _filterGenderChips() {
    return Wrap(
      children: [
        BottomSheetChip(
          text: Gender.male.gender,
          isSelected: _controller.isSelecteds[0],
          onSelected: (value) {
            _controller.updateIsSelectedValue(0);
            _controller.updateFilterGender(Gender.male);
          },
        ),
        BottomSheetChip(
          text: Gender.female.gender,
          isSelected: _controller.isSelecteds[1],
          onSelected: (value) {
            _controller.updateIsSelectedValue(1);
            _controller.updateFilterGender(Gender.female);
          },
        ),
        BottomSheetChip(
          text: Gender.genderless.gender,
          isSelected: _controller.isSelecteds[2],
          onSelected: (value) {
            _controller.updateIsSelectedValue(2);
            _controller.updateFilterGender(Gender.genderless);
          },
        ),
      ],
    );
  }

  Widget _filterStatusChips() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        BottomSheetChip(
          text: Status.alive.status,
          isSelected: _controller.isSelecteds[4],
          onSelected: (value) {
            _controller.updateIsSelectedValue(4);
            _controller.updateFilterStatus(Status.alive);
          },
        ),
        BottomSheetChip(
          text: Status.dead.status,
          isSelected: _controller.isSelecteds[5],
          onSelected: (value) {
            _controller.updateIsSelectedValue(5);
            _controller.updateFilterStatus(Status.dead);
          },
        ),
        BottomSheetChip(
          text: Status.unknown.status,
          isSelected: _controller.isSelecteds[6],
          onSelected: (value) {
            _controller.updateIsSelectedValue(6);
            _controller.updateFilterStatus(Status.unknown);
          },
        ),
      ],
    );
  }
}
