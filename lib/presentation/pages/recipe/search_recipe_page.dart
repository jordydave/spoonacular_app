import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../styles/text_styles.dart';
import '../../bloc/recipe/search_recipe_bloc.dart';
import '../../widgets/recipe/recipe_card_list_widget.dart';

class SearchRecipePage extends StatelessWidget {
  static const routeName = '/recipe-search';

  const SearchRecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchRecipeBloc>().add(OnQueryChanged(query));
              },
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchRecipeBloc, SearchRecipeState>(
              builder: (context, state) {
                if (state is SearchRecipeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchRecipeHasData) {
                  final result = state.recipes;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: result.length,
                      itemBuilder: (BuildContext context, int index) {
                        final recipe = result[index];
                        return RecipeCardListWidget(recipe);
                      },
                    ),
                  );
                } else if (state is SearchRecipeError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
