import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:assetmng/backEndCalls/AuthApi.dart';
import 'package:assetmng/model/user_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeBlocInitialState()) {
    on<InitialFetchEvent>((event, emit) async {
      emit(HomeBlocLodingState());
      // await Future.delayed(const Duration(milliseconds: 1000));
      try {
        await AuthApi.getUser(event.user).then((value) {
          if (value != null) {
            emit(HomeBlocFetchedState(value));
            print(value);
          } else {
            print("Somthing went Wrong");
            emit(HomeBlocErrorState("Somthing went Wrong"));
          }
        });
      } catch (e) {
        emit(HomeBlocErrorState(e.toString()));
      }
      // emit(HomeBlocErrorState());
    });
  }
}
