part of 'asset_bloc.dart';

abstract class AssetBlocState extends Equatable {
  const AssetBlocState();

  @override
  List<Object> get props => [];
}

class AssetBlocInitial extends AssetBlocState {}

class AssetBlocLoding extends AssetBlocState {}

class AssetBlocError extends AssetBlocState {
  final String error;

  const AssetBlocError(this.error);

  @override
  List<Object> get props => [error];
}

class AssetBlocFetched extends AssetBlocState {
  final List<Asset> asset;

  const AssetBlocFetched(this.asset);

  @override
  List<Object> get props => [asset];
}

class AssetBlocCreated extends AssetBlocState {
  @override
  List<Object> get props => [];
}

class AssetBlocDeleted extends AssetBlocState {
  @override
  List<Object> get props => [];
}

class AssetBlocUpdate extends AssetBlocState {
  @override
  List<Object> get props => [];
}
