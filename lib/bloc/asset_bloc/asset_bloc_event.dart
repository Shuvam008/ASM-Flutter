part of 'asset_bloc.dart';

abstract class AssetBlocEvent extends Equatable {
  const AssetBlocEvent();

  @override
  List<Object> get props => [];
}

class AssetCreate extends AssetBlocEvent {
  final Asset asset;

  const AssetCreate(this.asset);
  @override
  List<Object> get props => [asset];
}

class AssetFetch extends AssetBlocEvent {
  final String role;
  final String rolecode;

  AssetFetch(this.role, this.rolecode);
  @override
  List<Object> get props => [];
}

class AssetDelete extends AssetBlocEvent {
  final Asset asset;
  const AssetDelete(this.asset);
  @override
  List<Object> get props => [asset];
}

class AssetUpdate extends AssetBlocEvent {
  final Asset asset;

  const AssetUpdate(this.asset);
  @override
  List<Object> get props => [asset];
}
