import 'package:get_it/get_it.dart';
import '../features/auth/login/domain/usecases/login_usecase.dart';
import '../features/auth/login/domain/repositories/i_auth_repository.dart';
import '../features/auth/login/data/repositories_impl/auth_repository_impl.dart';
import '../features/auth/login/bloc/login_bloc.dart';
import '../features/auth/logout/bloc/logout_bloc.dart';
import '../features/dashboard/view/bloc/dashboard_bloc.dart';
import '../features/payment/bloc/payment_bloc.dart';
import '../features/profile/bloc/profile_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> setupDependencies() async {
  // Repositories
  locator.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(),
  );
  
  // Use Cases
  locator.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(locator()),
  );
  
  // BloCs
  locator.registerFactory<LoginBloc>(
    () => LoginBloc(loginUseCase: locator()),
  );

  locator.registerFactory<DashboardBloc>(
    () => DashboardBloc(),
  );

  locator.registerFactory<PaymentBloc>(
    () => PaymentBloc(),
  );

  locator.registerFactory<LogoutBloc>(
    () => LogoutBloc(),
  );

  locator.registerFactory<ProfileBloc>(
    () => ProfileBloc(),
  );
}