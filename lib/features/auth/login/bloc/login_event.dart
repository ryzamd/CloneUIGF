part of 'login_bloc.dart';

enum LoginMethod { facebook, google, apple }

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithSocial extends LoginEvent {
  final LoginMethod method;

  const LoginWithSocial(this.method);

  @override
  List<Object?> get props => [method];
}

class LoginWithPhone extends LoginEvent {
  const LoginWithPhone();
}

class LoginWithFaceId extends LoginEvent {
  const LoginWithFaceId();
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