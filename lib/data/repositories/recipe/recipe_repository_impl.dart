import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:spoonacular/data/datasources/recipe/recipe_local_data_source.dart';
import 'package:spoonacular/data/models/recipe/recipe_table.dart';
import 'package:spoonacular/domain/entities/recipe/recipe.dart';
import 'package:spoonacular/domain/entities/recipe/recipe_detail.dart';
import 'package:spoonacular/domain/repositories/recipe/recipe_repository.dart';
import 'package:spoonacular/utils/failure.dart';
import 'package:spoonacular/utils/network_info.dart';

import '../../../utils/exception.dart';
import '../../datasources/recipe/recipe_remote_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  final RecipeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RecipeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Recipe>>> getRandomVegetarianRecipes() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getRandomVegetarianRecipes();
        localDataSource.cacheRandomRecipeVegetarian(
            result.map((recipe) => RecipeTable.fromDTO(recipe)).toList());

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(''));
      } on TlsException {
        return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedRandomRecipeVegetarian();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getRandomDessertRecipes() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getRandomVegetarianRecipes();

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(''));
      } on TlsException {
        return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
      }
    } else {
      return const Left(ConnectionFailure('No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, RecipeDetail>> getRecipeDetail(int id) async {
    try {
      final result = await remoteDataSource.getRecipeDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> searchRecipe(String query) async {
    try {
      final result = await remoteDataSource.getSearchRecipe(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getSimilarRecipe(int id) async {
    try {
      final result = await remoteDataSource.getSimilarRecipe(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, String>> saveRecipe(RecipeDetail recipe) async {
    try {
      final result =
          await localDataSource.insertRecipe(RecipeTable.fromEntity(recipe));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeRecipe(RecipeDetail recipe) async {
    try {
      final result =
          await localDataSource.removeRecipe(RecipeTable.fromEntity(recipe));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getFavoriteRecipe() async {
    final result = await localDataSource.getFavoriteRecipe();
    return Right(result.map((model) => model.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToFavorite(int id) async {
    final result = await localDataSource.getRecipeById(id);
    return result != null;
  }
}
