import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../backEndCalls/UserApi.dart';
import '../../model/asset_model.dart';
import '../../model/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<SubAdminUsersFetch>((event, emit) async {
      try {
        await UserApi.getSubAdminUsers().then((value) async {
          if (value != null) {
            emit(UserLoding());
            await Future.delayed(const Duration(milliseconds: 500));
            emit(SubAdminUsersFetched(value));
          } else {
            emit(UserError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(UserError(e.toString()));
        print(e);
        // emit();
      }
    });
    on<LocationUsersFetch>((event, emit) async {
      try {
        await UserApi.getLocationUsers().then((value) async {
          if (value != null) {
            emit(UserLoding());
            await Future.delayed(const Duration(milliseconds: 500));
            emit(LocationUsersFetched(value));
          } else {
            emit(UserError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(UserError(e.toString()));
        print(e);
        // emit();
      }
    });
    on<VendorUsersFetch>((event, emit) async {
      try {
        await UserApi.getVendorUsers().then((value) async {
          if (value != null) {
            emit(UserLoding());
            await Future.delayed(const Duration(milliseconds: 500));
            emit(VendorUsersFetched(value));
          } else {
            emit(UserError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(UserError(e.toString()));
        print(e);
        // emit();
      }
    });

    on<UsersAdd>((event, emit) async {
      try {
        await UserApi.addUser(event.user).then((value) {
          if (value == 'successfullyCreated') {
            emit(UserAdded());
          } else if (value == 'UserExist') {
            emit(const UserAddedError("User already Exist"));
          } else {
            emit(const UserAddedError("Add User Faield"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(UserAddedError(e.toString()));
        print(e);
        // emit();
      }
    });
    on<UsersUpdate>((event, emit) async {
      try {
        await UserApi.updateUser(event.user).then((value) {
          if (value == 'successfullyUpdated') {
            emit(UserUpdated());
          } else {
            emit(const UserUpdatedError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(const UserUpdatedError("Error"));
        print(e);
        // emit();
      }
    });
    on<UsersDelete>((event, emit) async {
      try {
        await UserApi.deleteUser(event.id).then((value) {
          if (value == 'successfullyDeleteUser') {
            emit(UserDeleted());
          } else {
            emit(const UserDeletedError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(UserDeletedError(e.toString()));
        print(e);
        // emit();
      }
    });
  }
}
