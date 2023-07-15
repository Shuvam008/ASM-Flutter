// import 'package:equatable/equatable.dart';
part of 'package:assetmng/bloc/auth_bloc/auth_bloc.dart';

@immutable
abstract class AuthBlocEvent extends Equatable {
  // const AuthBlocEvent();
}

class LoginEvent extends AuthBlocEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class InitialEvent extends AuthBlocEvent {
  @override
  List<Object?> get props => [];
}

class KeepLoginToken extends AuthBlocEvent {
  final String token;

  KeepLoginToken(this.token);
  @override
  List<Object?> get props => [token];
}

class KeepLogin extends AuthBlocEvent {
  @override
  List<Object?> get props => [];
}

class LogOut extends AuthBlocEvent {
  @override
  List<Object?> get props => [];
}

class UserFetchEvent extends AuthBlocEvent {
  final user;
  UserFetchEvent(this.user);
  @override
  List<Object?> get props => [user];
}

class UserCurrentDeviceUpdateEvent extends AuthBlocEvent {
  final User user;

  UserCurrentDeviceUpdateEvent(this.user);
  @override
  List<Object?> get props => [user];
}
