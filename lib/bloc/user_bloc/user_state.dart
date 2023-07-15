part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoding extends UserState {}

class UserError extends UserState {
  final String error;

  UserError(this.error);
  @override
  List<Object> get props => [error];
}

class UserAddedError extends UserState {
  final String error;

  const UserAddedError(this.error);
  @override
  List<Object> get props => [error];
}

class UserUpdatedError extends UserState {
  final String error;

  const UserUpdatedError(this.error);
  @override
  List<Object> get props => [error];
}

class UserDeletedError extends UserState {
  final String error;

  const UserDeletedError(this.error);
  @override
  List<Object> get props => [error];
}

class SubAdminUsersFetched extends UserState {
  final List<User> user;

  const SubAdminUsersFetched(this.user);

  @override
  List<Object> get props => [user];
}

class LocationUsersFetched extends UserState {
  final List<User> user;

  const LocationUsersFetched(this.user);

  @override
  List<Object> get props => [user];
}

class VendorUsersFetched extends UserState {
  final List<User> user;

  const VendorUsersFetched(this.user);

  @override
  List<Object> get props => [user];
}

class UserAdded extends UserState {}

class UserUpdated extends UserState {}

class UserDeleted extends UserState {}
