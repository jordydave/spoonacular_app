import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/recipe/recipe.dart';
import '../../../styles/text_styles.dart';

class HomeRecipeWidget extends StatelessWidget {
  final List<Recipe> recipes;
  const HomeRecipeWidget({
    Key? key,
    required this.recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                padding: const EdgeInsets.only(right: 8, top: 8),
                child: InkWell(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: recipe.image ?? '',
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 180,
                child: Text(
                  recipe.title ?? '',
                  style: kSubtitle,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
        itemCount: recipes.length,
      ),
    );
  }
}
