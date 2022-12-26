import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/domain/entities/recipe/recipe_detail.dart';
import 'package:spoonacular/presentation/bloc/recipe/similar_recipe_bloc.dart';
import 'package:spoonacular/presentation/widgets/recipe/home_recipe_widget.dart';

import '../../../styles/colors.dart';
import '../../../styles/text_styles.dart';
import '../../bloc/recipe/recipe_detail_bloc.dart';

class RecipeDetailPage extends StatefulWidget {
  static const routeName = '/recipe-detail';
  final int id;

  const RecipeDetailPage({super.key, required this.id});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RecipeDetailBloc>().add(RecipeDetailRequested(widget.id));
    });
    Future.microtask(() {
      context.read<SimilarRecipeBloc>().add(SimilarRecipeRequested(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
        builder: (context, state) {
          if (state is RecipeDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RecipeDetailHasData) {
            return SafeArea(
              child: DetailContent(recipeDetail: state.recipeDetail),
            );
          } else if (state is RecipeDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final RecipeDetail? recipeDetail;
  const DetailContent({
    super.key,
    required this.recipeDetail,
  });

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  bool _customTileExpanded = false;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: widget.recipeDetail?.image ?? '',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        DraggableScrollableSheet(
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: const EdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
              ),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.recipeDetail?.title ?? '',
                            style: kHeading5.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Ingredients',
                            style: kHeading6,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.recipeDetail?.nutrition
                                    ?.ingredients?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: index + 1 !=
                                            widget.recipeDetail?.nutrition
                                                ?.ingredients?.length
                                        ? const BorderSide(
                                            width: 0.3,
                                            color: kDavysGrey,
                                          )
                                        : BorderSide.none,
                                  ),
                                ),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                    horizontal: 0,
                                    vertical: -4,
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  leading: Text(
                                    widget.recipeDetail?.nutrition
                                            ?.ingredients![index].name ??
                                        "",
                                  ),
                                  trailing: Text(
                                    "${widget.recipeDetail?.nutrition?.ingredients![index].amount.toString()} ${widget.recipeDetail?.nutrition?.ingredients![index].unit}",
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          widget.recipeDetail!.nutrition!.nutrients!.isNotEmpty
                              ? ExpansionTile(
                                  tilePadding: EdgeInsets.zero,
                                  onExpansionChanged: (bool expanded) {
                                    setState(
                                        () => _customTileExpanded = expanded);
                                  },
                                  title: Text(
                                    'Nutrition Info',
                                    style: kHeading6,
                                  ),
                                  trailing: Text(
                                    _customTileExpanded
                                        ? 'View Info -'
                                        : 'View Info +',
                                    style: kSubtitle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: kMikadoYellow,
                                    ),
                                  ),
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: widget.recipeDetail?.nutrition!
                                          .nutrients?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(width: 0.5),
                                            ),
                                          ),
                                          child: ListTile(
                                            visualDensity: const VisualDensity(
                                              horizontal: 0,
                                              vertical: -4,
                                            ),
                                            dense: true,
                                            contentPadding: EdgeInsets.zero,
                                            leading: Text(
                                              widget.recipeDetail!.nutrition!
                                                      .nutrients![index].name ??
                                                  "",
                                            ),
                                            trailing: Text(
                                              "${widget.recipeDetail!.nutrition!.nutrients![index].amount.toString()} ${widget.recipeDetail!.nutrition!.nutrients![index].unit!}",
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(height: 16),
                          BlocBuilder<SimilarRecipeBloc, SimilarRecipeState>(
                            builder: (context, state) {
                              if (state is SimilarRecipeLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is SimilarRecipeHasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Similar Recipes',
                                      style: kHeading6,
                                    ),
                                    HomeRecipeWidget(
                                      recipes: state.recipes,
                                    ),
                                  ],
                                );
                              } else if (state is SimilarRecipeError) {
                                return Text(state.message);
                              } else {
                                return Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.red,
                                );
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Instructions',
                                style: kHeading6,
                              ),
                              TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return PageView.builder(
                                            controller: _pageController,
                                            itemCount: widget
                                                .recipeDetail!
                                                .analyzedInstructions![0]
                                                .steps!
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final orientation =
                                                  MediaQuery.of(context)
                                                      .orientation;
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 50.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            'Step ${index + 1} / ${widget.recipeDetail!.analyzedInstructions![0].steps!.length}',
                                                            style: kHeading6,
                                                          ),
                                                          TextButton(
                                                              onPressed: () {
                                                                if (index + 1 !=
                                                                    widget
                                                                        .recipeDetail!
                                                                        .analyzedInstructions![
                                                                            0]
                                                                        .steps!
                                                                        .length) {
                                                                  if (_pageController
                                                                      .hasClients) {
                                                                    _pageController
                                                                        .animateToPage(
                                                                      index + 2,
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              400),
                                                                      curve: Curves
                                                                          .easeInOut,
                                                                    );
                                                                  }
                                                                } else {
                                                                  if (_pageController
                                                                      .hasClients) {
                                                                    _pageController
                                                                        .animateToPage(
                                                                      0,
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              400),
                                                                      curve: Curves
                                                                          .easeInOut,
                                                                    );
                                                                  }
                                                                }
                                                              },
                                                              child: Text(
                                                                index + 1 !=
                                                                        widget
                                                                            .recipeDetail!
                                                                            .analyzedInstructions![0]
                                                                            .steps!
                                                                            .length
                                                                    ? 'Jump 2 step'
                                                                    : 'Jump to first step',
                                                              ))
                                                        ],
                                                      ),
                                                      Text(
                                                        'Step ${index + 1}',
                                                        style: kHeading6,
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        widget
                                                            .recipeDetail!
                                                            .analyzedInstructions![
                                                                0]
                                                            .steps![index]
                                                            .step
                                                            .toString(),
                                                        style: kSubtitle,
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Text(
                                                        'Ingredients',
                                                        style: kHeading6,
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Expanded(
                                                        child: GridView.builder(
                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount:
                                                                  (orientation ==
                                                                          Orientation
                                                                              .portrait)
                                                                      ? 3
                                                                      : 3),
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          itemCount: widget
                                                              .recipeDetail!
                                                              .analyzedInstructions![
                                                                  0]
                                                              .steps![index]
                                                              .ingredients!
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int i) {
                                                            return Column(
                                                              children: [
                                                                Text(
                                                                  widget
                                                                      .recipeDetail!
                                                                      .analyzedInstructions![
                                                                          0]
                                                                      .steps![
                                                                          index]
                                                                      .ingredients![
                                                                          i]
                                                                      .name
                                                                      .toString(),
                                                                  style:
                                                                      kSubtitle,
                                                                ),
                                                                CachedNetworkImage(
                                                                  imageUrl:
                                                                      'https://spoonacular.com/cdn/ingredients_100x100/${widget.recipeDetail!.analyzedInstructions![0].steps![index].ingredients![i].image}',
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.15,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .error),
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
                                            });
                                      });
                                },
                                child: Text(
                                  'View All',
                                  style:
                                      kSubtitle.copyWith(color: kMikadoYellow),
                                ),
                              )
                            ],
                          ),
                          widget.recipeDetail!.analyzedInstructions!.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.recipeDetail!
                                      .analyzedInstructions![0].steps!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Step ${index + 1}',
                                          style: kHeading6,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          widget
                                                  .recipeDetail
                                                  ?.analyzedInstructions![0]
                                                  .steps![index]
                                                  .step ??
                                              '',
                                          style: kSubtitle,
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                    );
                                  },
                                )
                              : const Text('No Instructions'),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: kMikadoYellow,
                      height: 4,
                      width: 48,
                    ),
                  ),
                ],
              ),
            );
          },
          initialChildSize: 0.70,
          minChildSize: 0.70,
          maxChildSize: 0.70,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            foregroundColor: kMikadoYellow,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
