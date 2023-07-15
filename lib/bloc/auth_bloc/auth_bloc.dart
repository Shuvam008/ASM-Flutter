import 'dart:async';

import 'package:assetmng/backEndCalls/AuthApi.dart';
import 'package:assetmng/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../utils/index.dart';
part 'auth_bloc_events.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthApi authrRepository;
  AuthBloc(AuthBlocState initialState, this.authrRepository)
      : super(initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(
    AuthBlocEvent event,
    Emitter<AuthBlocState> emit,
  ) async {
    // print("this is my first bloc");
    emit(AuthBlocLodingState());
    // await Future.delayed(const Duration(milliseconds: 2000));
    // emit(AuthBlocLoginState());
    if (event is LoginEvent) {
      try {
        await AuthApi.logIn(event.email, event.password).then((value) async {
          if (value.toString() == "ok") {
            emit(AuthBlocLoginState(value, event.email));
            print(value);
          } else {
            print(value);
            emit(AuthBlocErrorState(value));
          }
        });
      } catch (e) {
        emit(AuthBlocErrorState(e.toString()));
      }
    }
    if (event is KeepLoginToken) {
      await SessionManager().set("token", event.token);
    }

    if (event is KeepLogin) {
      String ss = await SessionManager().get("token");
      print('get : $ss');
      await AuthApi.getUser(ss).then((value) {
        if (value != null) {
          print('get : $ss');
          emit(AuthBlocKeepLoginState(ss, value));
        } else {
          emit(AuthBlocKeepLoginState(ss, value!));
          print("Somthing went Wrong");
          // emit();
        }
      });
    }

    if (event is LogOut) {
      emit(AuthBlocInitialState());
      await SessionManager().set("token", "");
    }

    if (event is UserFetchEvent) {
      try {
        await AuthApi.getUser(event.user).then((value) {
          if (value != null) {
            emit(AuthBlocFetchUser(value));
            print(value);
          } else {
            emit(AuthBlocErrorState("Error"));
            print("Somthing went Wrong");
            // emit();
          }
        });
      } catch (e) {
        emit(AuthBlocErrorState("Server Error"));
        print(e);
        // emit();
      }
    }

    if (event is UserCurrentDeviceUpdateEvent) {
      try {
        await AuthApi.updateUser(event.user).then((value) {
          if (value != null) {
            print(value);
          } else {
            print(value);
            // emit();
          }
        });
      } catch (e) {
        print(e);
        // emit();
      }
    }
  }
}
