part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class InitialFetchEvent extends HomeEvent {
  final user;

  const InitialFetchEvent(this.user);
  @override
  List<Object> get props => [user];
}
