import 'package:dartz/dartz.dart';
import '../../../../../core/failures/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/i_auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  static const String _validEmail = 'user';
  static const String _validPassword = '123456';

  @override
  Future<Either<Failure, User>> loginWithCredentials({required String email, required String password}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (email != _validEmail) {
        return Left(AuthFailure.userNotFound());
      }

      if (password != _validPassword) {
        return Left(AuthFailure.invalidCredentials());
      }

      final user = User(
        id: '1',
        email: email,
        name: 'Test User',
        phoneNumber: '0123456789',
        avatarUrl: null,
        createdAt: DateTime.now(),
      );

      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithSocial(String method) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final user = User(
      id: '2',
      email: '$method@example.com',
      name: '$method User',
      phoneNumber: null,
      avatarUrl: null,
      createdAt: DateTime.now(),
    );
    
    return Right(user);
  }

  @override
  Future<Either<Failure, User>> loginWithBiometric() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return Left(PermissionFailure(
      message: 'Biometric authentication not available',
    ));
  }

  @override
  Future<Either<Failure, void>> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const Right(null);
  }
}