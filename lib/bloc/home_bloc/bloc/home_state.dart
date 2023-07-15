part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  // const HomeState();

  @override
  List<Object> get props => [];
}

class HomeBlocInitialState extends HomeState {}

class HomeBlocLodingState extends HomeState {}

class HomeBlocErrorState extends HomeState {
  final String apiErroe;

  HomeBlocErrorState(this.apiErroe);

  @override
  List<Object> get props => [apiErroe];
}

class HomeBlocFetchedState extends HomeState {
  final User user;

  HomeBlocFetchedState(this.user);

  @override
  List<Object> get props => [user];
}
