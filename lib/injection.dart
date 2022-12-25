import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:spoonacular/data/datasources/recipe/recipe_remote_data_source.dart';
import 'package:spoonacular/domain/usecases/recipe/get_random_vegetarian_recipe.dart';
import 'package:spoonacular/domain/usecases/recipe/get_recipe_detail.dart';
import 'package:spoonacular/domain/usecases/recipe/get_search_recipe.dart';
import 'package:spoonacular/domain/usecases/recipe/get_similar_recipe.dart';
import 'package:spoonacular/presentation/bloc/recipe/random_recipe_dessert_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/random_recipe_vegetarian_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/recipe_detail_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/search_recipe_bloc.dart';
import 'package:spoonacular/presentation/bloc/recipe/similar_recipe_bloc.dart';
import 'package:spoonacular/utils/network_info.dart';
import 'package:spoonacular/utils/ssl_pinning.dart';

import 'data/repositories/recipe/recipe_repository_impl.dart';
import 'domain/repositories/recipe/recipe_repository.dart';
import 'domain/usecases/recipe/get_random_dessert_recipe.dart';

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

  // Repository
  locator.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(
      networkInfo: locator(),
      remoteDataSource: locator(),
    ),
  );

  // Data sources
  locator.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(
      client: locator(),
    ),
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
