import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/controllers/rick_and_morty_controller.dart';
import 'package:rick_and_morty/constants/app_colors.dart';
import 'package:rick_and_morty/utils/tutorial.dart';
import 'package:rick_and_morty/widgets/bottom_app_bar_widgets/page_number.dart';
import 'package:rick_and_morty/widgets/bottom_app_bar_widgets/pagination.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static final RickAndMortyController _controller = Get.put(RickAndMortyController());

  static const iconTheme = IconThemeData(color: AppColors.antiFlashWhite);

  @override
  Widget build(BuildContext context) {
    _controller.tutorialDoneListener(context);
    return Scaffold(
      backgroundColor: AppColors.gunmetal,
      appBar: EasySearchBar(
        title: Text(
          "Rick and Morty",
          style: GoogleFonts.robotoCondensed(color: AppColors.antiFlashWhite),
        ),
        onSearch: (search) {
          _controller.search.value = search.toLowerCase();
          _controller.maxPage.value = _controller.getLength(_controller.filteredModels());
          _controller.currentPage.value = 0;
        },
        elevation: 0,
        backgroundColor: AppColors.gunmetal,
        searchTextStyle: const TextStyle(color: AppColors.antiFlashWhite),
        iconTheme: iconTheme,
        searchBackIconTheme: iconTheme,
        searchClearIconTheme: iconTheme,
        searchCursorColor: AppColors.antiFlashWhite,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: AppColors.gunmetal),
        isFloating: true,
      ),
      bottomNavigationBar: Obx(
        () => GestureDetector(
          key: Tutorial.filterKey,
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (details) {
            if (details.delta.dy < 0) {
              _controller.filterBottomSheet(context);
            }
          },
          child: BottomAppBar(
            height: kToolbarHeight,
            color: AppColors.gunmetal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Pagination(
                  onPressed: () {
                    _controller.prev();
                  },
                  icon: Icons.arrow_back_ios_rounded,
                ),
                PageNumber(
                  onPressed: () {
                    _controller.paginationBottomSheet();
                  },
                  maxPage: _controller.maxPage.value,
                  currentPage: _controller.currentPage.value + 1,
                ),
                Pagination(
                  onPressed: () {
                    _controller.next();
                  },
                  icon: Icons.arrow_forward_ios_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => !_controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.antiFlashWhite),
                  ),
                )
              : _controller.characterCards().isEmpty
                  ? Center(
                      child: Text(
                        "Please connect it to the internet when using it for the first time",
                        style: GoogleFonts.robotoCondensed(color: AppColors.antiFlashWhite),
                      ),
                    )
                  : ListView.builder(
                      controller: _controller.scrollController,
                      itemCount: _controller.characterCards().length,
                      itemBuilder: (context, index) {
                        return _controller.characterCards()[index];
                      },
                    ),
        ),
      ),
    );
  }
}
