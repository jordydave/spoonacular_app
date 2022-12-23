import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:spoonacular/data/datasources/recipe/recipe_remote_data_source.dart';
import 'package:spoonacular/domain/usecases/recipe/get_random_vegetarian_recipe.dart';
import 'package:spoonacular/presentation/bloc/recipe/random_recipe_vegetarian_bloc.dart';
import 'package:spoonacular/utils/network_info.dart';
import 'package:spoonacular/utils/ssl_pinning.dart';

import 'data/repositories/recipe/recipe_repository_impl.dart';
import 'domain/repositories/recipe/recipe_repository.dart';

final locator = GetIt.instance;

void init() {
  // Blocs
  locator.registerFactory(
    () => RandomRecipeVegetarianBloc(
      locator(),
    ),
  );

  // Use cases
  locator.registerLazySingleton(
    () => GetRandomVegetarianRecipe(
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
