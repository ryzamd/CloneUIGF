import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../domain/usecases/login_usecase.dart';
import '../view_model/login_view_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginWithSocial>(_onLoginWithSocial);
    on<LoginWithPhone>(_onLoginWithPhone);
    on<LoginWithFaceId>(_onLoginWithFaceId);
  }

  Future<void> _onLoginWithSocial(LoginWithSocial event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final result = await loginUseCase.loginWithSocial(event.method.name);
      
      result.fold(
        (failure) => emit(LoginFailure(failure.message)),
        (user) => emit(LoginSuccess(UserViewModel.fromEntity(user))),
      );
    } catch (e) {
      emit(LoginFailure('Đã có lỗi xảy ra: ${e.toString()}'));
      debugPrint(e.toString());
    }
  }

  Future<void> _onLoginWithPhone(LoginWithPhone event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    
    emit(LoginInitial());
  }

  Future<void> _onLoginWithFaceId(LoginWithFaceId event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final result = await loginUseCase.loginWithBiometric();
      
      result.fold(
        (failure) => emit(LoginFailure(failure.message)),
        (user) => emit(LoginSuccess(UserViewModel.fromEntity(user))),
      );
    } catch (e) {
      emit(LoginFailure('Đã có lỗi xảy ra: ${e.toString()}'));
    }
  }
}