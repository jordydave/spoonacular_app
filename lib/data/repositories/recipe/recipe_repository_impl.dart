import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:spoonacular/domain/entities/recipe/recipe.dart';
import 'package:spoonacular/domain/repositories/recipe/recipe_repository.dart';
import 'package:spoonacular/utils/failure.dart';
import 'package:spoonacular/utils/network_info.dart';

import '../../../utils/exception.dart';
import '../../datasources/recipe/recipe_remote_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RecipeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Recipe>>> getRandomVegetarianRecipes() async {
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
}
