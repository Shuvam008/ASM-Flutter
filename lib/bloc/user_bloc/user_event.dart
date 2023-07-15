part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SubAdminUsersFetch extends UserEvent {}

class LocationUsersFetch extends UserEvent {}

class VendorUsersFetch extends UserEvent {}

class UsersDelete extends UserEvent {
  final int id;

  const UsersDelete(this.id);
  @override
  List<Object> get props => [id];
}

class UsersUpdate extends UserEvent {
  final User user;

  const UsersUpdate(this.user);
  @override
  List<Object> get props => [user];
}

class UsersAdd extends UserEvent {
  final User user;

  const UsersAdd(this.user);
  @override
  List<Object> get props => [user];
}
