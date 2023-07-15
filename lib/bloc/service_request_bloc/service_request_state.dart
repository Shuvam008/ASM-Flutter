part of 'service_request_bloc.dart';

abstract class ServiceRequestState extends Equatable {
  const ServiceRequestState();

  @override
  List<Object> get props => [];
}

class ServiceRequestInitial extends ServiceRequestState {}

class ServiceRequestLoding extends ServiceRequestState {}

class ServiceRequestNoDataFound extends ServiceRequestState {
  final String error;

  const ServiceRequestNoDataFound(this.error);

  @override
  List<Object> get props => [error];
}

class ServiceRequestError extends ServiceRequestState {
  final String error;

  const ServiceRequestError(this.error);

  @override
  List<Object> get props => [error];
}

class ServiceRequestFetched extends ServiceRequestState {
  final List<ServiceR> service;

  const ServiceRequestFetched(this.service);

  @override
  List<Object> get props => [service];
}

class ServiceRequestCreated extends ServiceRequestState {
  @override
  List<Object> get props => [];
}

class ServiceRequestDeleted extends ServiceRequestState {
  @override
  List<Object> get props => [];
}

class ServiceRequestUpdate extends ServiceRequestState {
  @override
  List<Object> get props => [];
}
