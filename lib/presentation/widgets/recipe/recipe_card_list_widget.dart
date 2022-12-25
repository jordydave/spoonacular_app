import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spoonacular/domain/entities/recipe/recipe.dart';

import '../../../styles/text_styles.dart';
import '../../pages/recipe/recipe_detail_page.dart';

class RecipeCardListWidget extends StatelessWidget {
  final Recipe recipe;

  const RecipeCardListWidget(this.recipe, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            RecipeDetailPage.routeName,
            arguments: recipe.id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  left: 122,
                  bottom: 8,
                  right: 8,
                ),
                child: Text(
                  recipe.title ?? '-',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kSubtitle,
                ),
              ),
            ),
            Container(
              width: 100,
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              padding: const EdgeInsets.only(right: 5),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: recipe.image ?? '',
                  width: 80,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
