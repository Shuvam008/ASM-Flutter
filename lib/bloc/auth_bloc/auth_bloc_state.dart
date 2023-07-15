part of 'package:assetmng/bloc/auth_bloc/auth_bloc.dart';

// import 'package:equatable/equatable.dart';
// @immutable
class AuthBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBlocInitialState extends AuthBlocState {}

class AuthBlocLodingState extends AuthBlocState {}

class AuthBlocErrorState extends AuthBlocState {
  final String apiErroe;

  AuthBlocErrorState(this.apiErroe);
  @override
  List<Object?> get props => [apiErroe];
}

class AuthBlocLoginState extends AuthBlocState {
  final String loginResponse;
  final String user;

  AuthBlocLoginState(this.loginResponse, this.user);
  @override
  List<Object?> get props => [loginResponse, user];
}

class AuthBlocKeepLoginState extends AuthBlocState {
  final String user;
  final User userinfo;

  AuthBlocKeepLoginState(this.user, this.userinfo);
  @override
  List<Object?> get props => [user, userinfo];
}

class AuthBlocFetchUser extends AuthBlocState {
  final User user;

  AuthBlocFetchUser(this.user);

  @override
  List<Object> get props => [user];
}
