import 'package:dartz/dartz.dart';
import '../../../../../core/failures/failure.dart';
import '../entities/user.dart';

abstract class IAuthRepository {
  Future<Either<Failure, User>> loginWithCredentials({
    required String email,
    required String password,
  });
  
  Future<Either<Failure, User>> loginWithSocial(String method);
  
  Future<Either<Failure, User>> loginWithBiometric();
  
  Future<Either<Failure, void>> logout();
}