import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:spoonacular/data/datasources/recipe/recipe_local_data_source.dart';
import 'package:spoonacular/data/datasources/recipe/recipe_remote_data_source.dart';
import 'package:spoonacular/domain/usecases/recipe/get_random_vegetarian_recipe.dart';
import 'package:spoonacular/domain/usecases/recipe/get_recipe_detail.dart';
import 'package:spoonacular/domain/usecases/recipe/get_search_recipe.dart';
import 'package:spoonacular/domain/usecases/recipe/get_similar_recipe.dart';
import 'package:spoonacular/presentation/bloc/recipe/random_recipe_dessert_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/random_recipe_vegetarian_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/recipe_detail_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/recipe_favorite_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/search_recipe_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/similar_recipe_bloc.dart';
import 'package:spoonacular/utils/network_info.dart';
import 'package:spoonacular/utils/ssl_pinning.dart';

import 'data/datasources/db/database_helper.dart';
import 'data/repositories/recipe/recipe_repository_impl.dart';
import 'domain/repositories/recipe/recipe_repository.dart';
import 'domain/usecases/recipe/get_favorite_recipe.dart';
import 'domain/usecases/recipe/get_favorite_recipe_status.dart';
import 'domain/usecases/recipe/get_random_dessert_recipe.dart';
import 'domain/usecases/recipe/remove_favorite_recipe.dart';
import 'domain/usecases/recipe/save_favorite_recipe.dart';

final locator = GetIt.instance;

void init() {
  // Blocs
  locator.registerFactory(
    () => RandomRecipeVegetarianBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RandomRecipeDessertBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecipeDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchRecipeBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SimilarRecipeBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecipeFavoriteBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // Use cases
  locator.registerLazySingleton(
    () => GetRandomVegetarianRecipe(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetRandomDessertRecipe(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetRecipeDetail(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetSearchRecipe(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetSimilarRecipe(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetFavoriteRecipe(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetFavoriteRecipeStatus(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SaveFavoriteRecipe(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => RemoveFavoriteRecipe(
      locator(),
    ),
  );

  // Repository
  locator.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(
      networkInfo: locator(),
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // Data sources
  locator.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<RecipeLocalDataSource>(
    () => RecipeLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper(),
  );

  // Network info
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      locator(),
    ),
  );

  // External
  locator.registerLazySingleton(() => SSLPinning.client);
  locator.registerLazySingleton(() => InternetConnectionChecker());
}
