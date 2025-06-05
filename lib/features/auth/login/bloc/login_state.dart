part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserViewModel user;

  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginWithCredentials extends LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentials({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}