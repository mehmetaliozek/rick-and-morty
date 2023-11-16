import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/rick_and_morty_data_model.dart';
import 'package:rick_and_morty/constants/app_colors.dart';
import 'package:rick_and_morty/widgets/character_widgets/character_avatar.dart';
import 'package:rick_and_morty/widgets/character_widgets/character_name.dart';
import 'package:rick_and_morty/widgets/character_widgets/character_origin.dart';
import 'package:rick_and_morty/widgets/character_widgets/character_status.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.model});
  final RickAndMortyDataModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 179,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.5),
      decoration: BoxDecoration(
        color: AppColors.onyx,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: AppColors.gunmetal,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          CharacterAvatar(name: model.name!, url: model.image!),
          Padding(
            padding: const EdgeInsets.all(12.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CharacterName(name: model.name!),
                CharacterStatus(status: model.status!, species: model.species!),
                const Expanded(child: SizedBox()),
                CharacterInfo(text: "Origin", location: model.origin!),
                const Expanded(child: SizedBox()),
                CharacterInfo(text: "Last known location:", location: model.location!),
              ],
            ),
          )
        ],
      ),
    );
  }
}
