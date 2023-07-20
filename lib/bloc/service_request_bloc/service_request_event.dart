part of 'service_request_bloc.dart';

abstract class ServiceRequestEvent extends Equatable {
  const ServiceRequestEvent();

  @override
  List<Object> get props => [];
}

class ServiceRequestEventCreate extends ServiceRequestEvent {
  final ServiceR service;

  const ServiceRequestEventCreate(this.service);
  @override
  List<Object> get props => [service];
}

class ServiceRequestEventFetch extends ServiceRequestEvent {
  final String role;
  final String rolecode;

  const ServiceRequestEventFetch(this.role, this.rolecode);
  @override
  List<Object> get props => [];
}

class ServiceRequestEventDelete extends ServiceRequestEvent {
  final int id;
  const ServiceRequestEventDelete(this.id);
  @override
  List<Object> get props => [id];
}

class ServiceRequestEventUpdate extends ServiceRequestEvent {
  final ServiceR service;

  const ServiceRequestEventUpdate(this.service);
  @override
  List<Object> get props => [service];
}

class ServiceRequestEventClose extends ServiceRequestEvent {
  final ServiceR service;

  const ServiceRequestEventClose(this.service);
  @override
  List<Object> get props => [service];
}
