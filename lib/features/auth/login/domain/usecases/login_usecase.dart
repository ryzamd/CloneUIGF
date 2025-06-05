import 'package:dartz/dartz.dart';
import '../../../../../core/failures/failure.dart';
import '../entities/user.dart';
import '../repositories/i_auth_repository.dart';

class LoginUseCase {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> loginWithCredentials({
    required String email,
    required String password,
  }) {
    return repository.loginWithCredentials(
      email: email,
      password: password,
    );
  }

  Future<Either<Failure, User>> loginWithSocial(String method) {
    return repository.loginWithSocial(method);
  }

  Future<Either<Failure, User>> loginWithBiometric() {
    return repository.loginWithBiometric();
  }
}