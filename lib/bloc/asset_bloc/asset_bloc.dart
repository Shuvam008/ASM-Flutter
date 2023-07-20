import 'package:assetmng/backEndCalls/AssetApi.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/asset_model.dart';

part 'asset_bloc_event.dart';
part 'asset_bloc_state.dart';

class AssetBloc extends Bloc<AssetBlocEvent, AssetBlocState> {
  AssetBloc() : super(AssetBlocInitial()) {
    on<AssetFetch>((event, emit) async {
      try {
        await AssetApi.getAssets(event.role, event.rolecode)
            .then((value) async {
          if (value != null) {
            emit(AssetBlocLoding());
            await Future.delayed(const Duration(milliseconds: 500));

            emit(AssetBlocFetched(value));
            print("object");
          } else {
            emit(const AssetBlocError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(AssetBlocLoding());
        await Future.delayed(const Duration(milliseconds: 500));
        emit(AssetBlocError(e.toString()));
        print(e);
        // emit();
      }
    });
    on<AssetCreate>((event, emit) async {
      try {
        await AssetApi.AddAssets(event.asset).then((value) {
          if (value == 'successfullyCreated') {
            emit(AssetBlocCreated());
          } else {
            emit(const AssetBlocError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(AssetBlocError(e.toString()));
        print(e);
        // emit();
      }
    });
    on<AssetDelete>((event, emit) async {
      try {
        await AssetApi.UpdateAssets(
          event.asset.copyWith(
            isActive: false,
          ),
        ).then((value) {
          if (value == 'successfullyUpdateAsset') {
            emit(AssetBlocDeleted());
            print("Delete successfully");
          } else {
            emit(const AssetBlocError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(AssetBlocError(e.toString()));
        print(e);
        // emit();
      }
    });

    on<AssetUpdate>((event, emit) async {
      try {
        await AssetApi.UpdateAssets(event.asset).then((value) {
          if (value == 'successfullyUpdateAsset') {
            emit(AssetBlocUpdate());
            print(value.toString());
            print("dfdfd");
          } else {
            emit(const AssetBlocError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(AssetBlocLoding());
        Future.delayed(const Duration(milliseconds: 500));
        emit(AssetBlocError(e.toString()));
        print(e);
        // emit();
      }
    });
  }
}
