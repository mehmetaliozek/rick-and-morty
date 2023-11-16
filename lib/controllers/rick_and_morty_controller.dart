import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/constants/app_colors.dart';
import 'package:rick_and_morty/models/rick_and_morty_data_model.dart';
import 'package:rick_and_morty/services/rick_and_morty_data_service.dart';
import 'package:rick_and_morty/services/shared_preferences_service.dart';
import 'package:rick_and_morty/utils/gender.dart';
import 'package:rick_and_morty/utils/status.dart';
import 'package:rick_and_morty/utils/tutorial.dart';
import 'package:rick_and_morty/widgets/bottom_app_bar_widgets/pagination_bottom_sheet.dart';
import 'package:rick_and_morty/widgets/bottom_sheet_widgets/filter_bottom_sheet.dart';
import 'package:rick_and_morty/widgets/character_widgets/character_card.dart';

class RickAndMortyController extends GetxController {
  final ScrollController scrollController = ScrollController();

  late RickAndMortyDataService _rickAndMortyDataService;
  late SharedPreferencesService _preferencesService;

  RxList<RickAndMortyDataModel> model = <RickAndMortyDataModel>[].obs;
  RxList<RickAndMortyDataModel> filteredModel = <RickAndMortyDataModel>[].obs;

  RxList<Status> filteredStatus = <Status>[].obs;
  RxList<Gender> filteredGender = <Gender>[].obs;

  RxList<RxBool> isSelecteds = <RxBool>[false.obs, false.obs, false.obs, false.obs, false.obs, false.obs, false.obs].obs;

  RxBool isLoading = false.obs;
  bool? isTutorialDone;

  RxString search = "".obs;

  RxInt maxPage = 0.obs;
  RxInt currentPage = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    _preferencesService = await SharedPreferencesService.getInstance();
    isTutorialDone = await _preferencesService.getValue(SharedPreferencesService.tutorialKey);

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      final data = _preferencesService.getData(SharedPreferencesService.dataKey);
      if (data.isNotEmpty) {
        maxPage.value = await _preferencesService.getValue(SharedPreferencesService.pageKey);
        model = data.obs;
        filteredModel = data.obs;
      }
    } else {
      _rickAndMortyDataService = RickAndMortyDataService();

      await _rickAndMortyDataService.fetchPageCount().then((pageCount) async {
        maxPage.value = pageCount;
        for (var i = 1; i <= pageCount; i++) {
          await _rickAndMortyDataService.fetchCharacterData(i).then((characters) {
            for (var character in characters) {
              model.add(RickAndMortyDataModel.fromJson(character));
              filteredModel.add(RickAndMortyDataModel.fromJson(character));
            }
          });
        }
      });
      _preferencesService.clearAllData();
      _preferencesService.saveData(SharedPreferencesService.dataKey, model);
      _preferencesService.setValue(SharedPreferencesService.pageKey, maxPage.value);
    }
    isLoading.value = true;
  }

  int getLength(int length) {
    return (length ~/ 20) + (length % 20 == 0 ? 0 : 1);
  }

  int filteredModels() {
    filteredModel.clear();

    for (var i = 0; i < model.length; i++) {
      if (model[i].name!.toLowerCase().contains(search.value)) {
        if (filteredGender.isEmpty && filteredStatus.isEmpty) {
          filteredModel.add(model[i]);
        } else {
          if (filteredStatus.containStatus(model[i].status!) && filteredGender.isEmpty) {
            filteredModel.add(model[i]);
          } else if (filteredGender.containStatus(model[i].gender!) && filteredStatus.isEmpty) {
            filteredModel.add(model[i]);
          } else if (filteredStatus.containStatus(model[i].status!) && filteredGender.containStatus(model[i].gender!)) {
            filteredModel.add(model[i]);
          }
        }
      }
    }
    scrollController.jumpTo(scrollController.position.minScrollExtent);
    return filteredModel.length;
  }

  List<Widget> characterCards() {
    List<Widget> characterCards = [];
    for (var i = 0; i < 20; i++) {
      if (i + (currentPage.value * 20) < i + ((maxPage.value - 1) * 20)) {
        if (filteredModel[i + (currentPage.value * 20)].name!.toLowerCase().contains(search.value)) {
          characterCards.add(CharacterCard(model: filteredModel[i + (currentPage.value * 20)]));
        }
      } else if (i + (currentPage.value * 20) < filteredModel.length) {
        if (filteredModel[i + (currentPage.value * 20)].name!.toLowerCase().contains(search.value)) {
          characterCards.add(CharacterCard(model: filteredModel[i + (currentPage.value * 20)]));
        }
      }
    }
    return characterCards;
  }

  void paginationBottomSheet() {
    Get.bottomSheet(
      PaginationBottomSheet(
        currentPage: currentPage.value,
        childCount: maxPage.value,
        onSelectedItemChanged: (value) {
          currentPage.value = value;
        },
      ),
      backgroundColor: AppColors.gunmetal,
    );
  }

  void prev() {
    if (currentPage.value != 0) {
      if (scrollController.hasClients) {
        currentPage.value--;
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      }
    }
  }

  void next() {
    if (currentPage.value + 1 != maxPage.value) {
      if (scrollController.hasClients) {
        currentPage.value++;
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      }
    }
  }

  void filterBottomSheet(BuildContext context) {
    Get.bottomSheet(
      const FilterBottomSheet(),
      backgroundColor: AppColors.gunmetal,
    );
  }

  void updateFilterStatus(Status status) {
    if (filteredStatus.contains(status)) {
      filteredStatus.remove(status);
    } else {
      filteredStatus.add(status);
    }
    maxPage.value = getLength(filteredModels());
    currentPage.value = 0;
  }

  void updateFilterGender(Gender gender) {
    if (filteredGender.contains(gender)) {
      filteredGender.remove(gender);
    } else {
      filteredGender.add(gender);
    }
    maxPage.value = getLength(filteredModels());
    currentPage.value = 0;
  }

  void updateIsSelectedValue(int index) => isSelecteds[index].value = !isSelecteds[index].value;

  void tutorialDoneListener(BuildContext context) {
    ever(isLoading, (callback) async {
      if (isLoading.value) {
        if (isTutorialDone == null) {
          _preferencesService.setValue(SharedPreferencesService.tutorialKey, true);
          Tutorial tutorial = Tutorial();
          tutorial.showTutorialCoachMark(context);
        }
      }
    });
  }
}
