import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/recipe/recipe_detail.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/constant.dart';

class InstructionDetailWidget extends StatefulWidget {
  final RecipeDetail? recipeDetail;

  const InstructionDetailWidget({super.key, this.recipeDetail});

  @override
  State<InstructionDetailWidget> createState() =>
      _InstructionDetailWidgetState();
}

class _InstructionDetailWidgetState extends State<InstructionDetailWidget> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.recipeDetail!.analyzedInstructions![0].steps!.length,
      itemBuilder: (BuildContext context, int index) {
        final orientation = MediaQuery.of(context).orientation;
        final analyzedInstructionLength =
            widget.recipeDetail!.analyzedInstructions![0].steps!.length;

        return Container(
          padding: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible:
                          index + 1 != analyzedInstructionLength ? true : false,
                      child: ElevatedButton(
                        onPressed: () {
                          if (index + 1 != analyzedInstructionLength) {
                            if (_pageController.hasClients) {
                              _pageController.animateToPage(
                                index + 1,
                                duration: const Duration(
                                  milliseconds: 400,
                                ),
                                curve: Curves.easeInOut,
                              );
                            }
                          } else {
                            if (_pageController.hasClients) {
                              _pageController.animateToPage(
                                0,
                                duration: const Duration(
                                  milliseconds: 400,
                                ),
                                curve: Curves.easeInOut,
                              );
                            }
                          }
                        },
                        child: Text(
                          index + 1 != analyzedInstructionLength
                              ? 'Next step'
                              : 'Jump to first step',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (index + 1 != analyzedInstructionLength) {
                          if (_pageController.hasClients) {
                            _pageController.animateToPage(
                              index + 2,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        } else {
                          if (_pageController.hasClients) {
                            _pageController.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        }
                      },
                      child: Text(
                        index + 1 != analyzedInstructionLength
                            ? 'Jump 2 step'
                            : 'Jump to first step',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Step ${index + 1} / $analyzedInstructionLength',
                  style: kHeading5,
                ),
                const SizedBox(height: 8),
                Text(
                  widget
                      .recipeDetail!.analyzedInstructions![0].steps![index].step
                      .toString(),
                  style: kSubtitle,
                ),
                const SizedBox(height: 20),
                Text(
                  'Ingredients',
                  style: kHeading6,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          (orientation == Orientation.portrait) ? 3 : 3,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.recipeDetail!.analyzedInstructions![0]
                        .steps![index].ingredients!.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl:
                                  '$baseUrlImageIngredients${widget.recipeDetail!.analyzedInstructions![0].steps![index].ingredients![i].image}',
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.recipeDetail!.analyzedInstructions![0]
                                .steps![index].ingredients![i].name
                                .toString(),
                            style: kSubtitle,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
