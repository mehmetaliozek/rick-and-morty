import 'package:flutter/material.dart';
import 'package:rick_and_morty/widgets/tutorial_widgets/tutorial_card.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class Tutorial {
  late final TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];

  static GlobalKey pageKey = GlobalKey();
  static GlobalKey filterKey = GlobalKey();

  Tutorial() {
    targets = [
      TargetFocus(
        identify: "page",
        keyTarget: pageKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const TutorialCard(
                text: "Click here to quickly switch between pages",
                bottom: 20,
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: "filter",
        keyTarget: filterKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const TutorialCard(
                text: "Swipe up to filter",
                bottom: 10,
              );
            },
          ),
        ],
      ),
    ];
  }

  showTutorialCoachMark(BuildContext context) {
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      pulseEnable: false,
      hideSkip: true,
      opacityShadow: 0.5,
    )..show(context: context);
  }
}
