import 'package:assetmng/backEndCalls/ServiceRequestApi.dart';
import 'package:assetmng/model/service_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'service_request_event.dart';
part 'service_request_state.dart';

class ServiceRequestBloc
    extends Bloc<ServiceRequestEvent, ServiceRequestState> {
  ServiceRequestBloc() : super(ServiceRequestInitial()) {
    on<ServiceRequestEventFetch>((event, emit) async {
      try {
        await ServiceRequestApi.getServiceRequests(event.role, event.rolecode)
            .then((value) async {
          if (value != null) {
            // emit(ServiceRequestLoding());
            // await Future.delayed(const Duration(milliseconds: 500));

            emit(ServiceRequestFetched(value));
            print("object");
          } else {
            emit(const ServiceRequestNoDataFound("No Data Found"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(ServiceRequestLoding());
        await Future.delayed(const Duration(milliseconds: 500));
        emit(ServiceRequestError(e.toString()));
        print(e);
        // emit();
      }
    });
    on<ServiceRequestEventCreate>((event, emit) async {
      try {
        await ServiceRequestApi.addserviceRequests(event.service).then((value) {
          if (value == 'successfullyServiceCreated') {
            emit(ServiceRequestCreated());
            print(value);
          } else {
            emit(const ServiceRequestError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(ServiceRequestError(e.toString()));
        print(e);
        // emit();
      }
    });
    on<ServiceRequestEventDelete>((event, emit) async {
      try {
        await ServiceRequestApi.deleteserviceRequests(event.id).then((value) {
          if (value == 'successfullyDeleteAsset') {
            emit(ServiceRequestDeleted());
            print("Delete successfully");
          } else {
            emit(const ServiceRequestError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(ServiceRequestError(e.toString()));
        print(e);
        // emit();
      }
    });

    on<ServiceRequestEventUpdate>((event, emit) async {
      try {
        await ServiceRequestApi.updateserviceRequests(event.service)
            .then((value) {
          if (value == 'successfullyUpdateService') {
            emit(ServiceRequestUpdate());
            print(value.toString());
            print("dfdfd");
          } else {
            emit(const ServiceRequestError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(ServiceRequestLoding());
        Future.delayed(const Duration(milliseconds: 500));
        emit(ServiceRequestError(e.toString()));
        print(e);
        // emit();
      }
    });

    on<ServiceRequestEventClose>((event, emit) async {
      try {
        await ServiceRequestApi.updateserviceRequests(event.service)
            .then((value) {
          if (value == 'successfullyUpdateService') {
            emit(ServiceRequestClosed());
            print(value.toString());
            print("dfdfd");
          } else {
            emit(const ServiceRequestError("Error"));
            print(value);
            // emit();
          }
        });
      } catch (e) {
        emit(ServiceRequestLoding());
        Future.delayed(const Duration(milliseconds: 500));
        emit(ServiceRequestError(e.toString()));
        print(e);
        // emit();
      }
    });
  }
}
