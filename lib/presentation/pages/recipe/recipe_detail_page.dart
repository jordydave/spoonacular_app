import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonacular/domain/entities/recipe/recipe_detail.dart';
import 'package:spoonacular/presentation/bloc/recipe/recipe_favorite_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/similar_recipe_bloc.dart';
import 'package:spoonacular/presentation/pages/recipe/favorite_recipe_page.dart';
import 'package:spoonacular/presentation/widgets/recipe/home_recipe_widget.dart';

import '../../../styles/colors.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/constant.dart';
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
      context.read<SimilarRecipeBloc>().add(SimilarRecipeRequested(widget.id));
      context.read<RecipeFavoriteBloc>().add(RecipeFavoriteStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isRecipeAddToFavorite = context.select<RecipeFavoriteBloc, bool>(
      (bloc) {
        if (bloc.state is RecipeFavoriteAdded) {
          return (bloc.state as RecipeFavoriteAdded).isAdd;
        } else {
          return false;
        }
      },
    );
    return Scaffold(
      body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
        builder: (context, state) {
          if (state is RecipeDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RecipeDetailHasData) {
            return SafeArea(
              child: DetailContent(
                recipeDetail: state.recipeDetail,
                isAddedToFavorite: isRecipeAddToFavorite,
              ),
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

// ignore: must_be_immutable
class DetailContent extends StatefulWidget {
  final RecipeDetail? recipeDetail;
  bool? isAddedToFavorite;
  DetailContent({
    super.key,
    required this.recipeDetail,
    this.isAddedToFavorite,
  });

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  bool _customTileExpanded = false;
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
                          ElevatedButton(
                            onPressed: () async {
                              if (!widget.isAddedToFavorite!) {
                                context.read<RecipeFavoriteBloc>().add(
                                    RecipeFavoriteAdd(widget.recipeDetail!));
                              } else {
                                context.read<RecipeFavoriteBloc>().add(
                                    RecipeFavoriteRemove(widget.recipeDetail!));
                              }
                              final state =
                                  BlocProvider.of<RecipeFavoriteBloc>(context)
                                      .state;
                              String message = '';

                              if (state is RecipeFavoriteAdded) {
                                final isAdded = state.isAdd;
                                message = isAdded == false
                                    ? recipeAddToFarite
                                    : recipeRemoveFromFarite;
                              } else {
                                message = !widget.isAddedToFavorite!
                                    ? recipeAddToFarite
                                    : recipeRemoveFromFarite;
                              }
                              if (message == recipeAddToFarite ||
                                  message == recipeRemoveFromFarite) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(message),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                FavoriteRecipePage.routeName,
                                              );
                                            },
                                            child: Text(
                                              "Go To Favorite",
                                              style: kBodyText.copyWith(
                                                color: kPrussianBlue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(message),
                                    );
                                  },
                                );
                              }
                              setState(() {
                                widget.isAddedToFavorite =
                                    !widget.isAddedToFavorite!;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                widget.isAddedToFavorite!
                                    ? const Icon(Icons.check)
                                    : const Icon(Icons.add),
                                const Text('Favorite'),
                              ],
                            ),
                          ),
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
