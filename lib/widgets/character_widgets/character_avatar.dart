import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty/constants/app_colors.dart';

class CharacterAvatar extends StatelessWidget {
  const CharacterAvatar({super.key, required this.name, required this.url});
  final String name;
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
          title: name,
          titleStyle: const TextStyle(color: AppColors.antiFlashWhite),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.width * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    url,
                    cacheManager: CacheManager(
                      Config(
                        "network_images",
                        maxNrOfCacheObjects: 1000,
                        stalePeriod: const Duration(days: 30),
                      ),
                    ),
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          backgroundColor: AppColors.gunmetal,
        );
      },
      child: Container(
        height: 125,
        width: 125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: CachedNetworkImageProvider(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
