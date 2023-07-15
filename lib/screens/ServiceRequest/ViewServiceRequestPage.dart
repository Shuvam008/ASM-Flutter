import 'package:assetmng/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:assetmng/bloc/service_request_bloc/service_request_bloc.dart';
import 'package:assetmng/bloc/user_bloc/user_bloc.dart';
import 'package:assetmng/model/asset_model.dart';
import 'package:assetmng/model/service_model.dart';
import 'package:assetmng/screens/assets/updateAssetPage.dart';
import 'package:assetmng/screens/subAdminUser/updateSubAdmin.dart';
import 'package:assetmng/screens/venorUser/updateVendorUser.dart';
import 'package:assetmng/widget/CustomAppBar.dart';
import 'package:assetmng/widget/side_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/asset_bloc/asset_bloc.dart';
import '../../model/user_model.dart';
import '../../shared/colors.dart';
import '../../shared/edge_insect.dart';
import '../../shared/spacing.dart';
import '../../shared/text_styles.dart';
import '../../utils/index.dart';

class ViewServiceRequestPage extends StatefulWidget {
  final ServiceR service;
  const ViewServiceRequestPage({super.key, required this.service});

  @override
  State<ViewServiceRequestPage> createState() => _ViewServiceRequestPageState();
}

class _ViewServiceRequestPageState extends State<ViewServiceRequestPage> {
  List final_details = [
    "id",
    "Equipment Type",
    "Serial Number",
    "Location",
    "Supplier",
    "Description Location",
    "Description Vendor",
    "Request Time",
    "Request Date",
    "Request Acknowledge Date",
    "Request Acknowledge Time",
    "Request Close Date",
    "Request Close Time",
    "Location Approve Date",
    "Location Approve Time"
  ];

  @override
  Widget build(BuildContext context) {
    List final_details_values = [
      widget.service.id,
      widget.service.equipmenttype,
      widget.service.serialnumber,
      widget.service.location,
      widget.service.supplier,
      widget.service.descriptionlocation,
      widget.service.descriptionvendor,
      widget.service.requesttime,
      widget.service.requestdate,
      widget.service.requestacknowledgedate,
      widget.service.requestacknowledgetime,
      widget.service.requestclosedate,
      widget.service.requestclosetime,
      widget.service.locationapprovedate,
      widget.service.locationapprovetime,
    ];
    return Scaffold(
      appBar: const CustomAppBar(title: "View Service Request"),
      drawer: const SideMenu(),
      body: Padding(
        padding: kEdgeInsetsAllNormal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: final_details_values.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: index.isEven ? Colors.grey.shade200 : Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          final_details[index],
                          style: kSubtitleTextStyle,
                        ),
                        Text(
                          final_details_values[index].toString(),
                          style: kSubtitleTextStyle,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              kSecondaryColor)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Back'),
                    ),
                  ),
                ),
                horizontalSpaceSmall,
                horizontalSpaceSmall,
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeBlocFetchedState) {
                      if (state.user.role == "admin" ||
                          state.user.role == "subAdmin") {
                        return Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kPrimaryColor2)),
                              onPressed: () {
                                context.read<ServiceRequestBloc>().add(
                                    ServiceRequestEventDelete(
                                        widget.service.id));
                              },
                              child: const Text('Delete'),
                            ),
                          ),
                        );
                      } else if (state.user.role == "location") {
                        return widget.service.requestclosedate == ""
                            ? Expanded(
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  kPrimaryColor2)),
                                      onPressed: () {
                                        // context.read<ServiceRequestBloc>().add(
                                        //     ServiceRequestEventDelete(
                                        //         widget.service.id));
                                      },
                                      child: const Text('Update'),
                                    )),
                              )
                            : const SizedBox();
                      } else if (state.user.role == "vendor") {
                        return const SizedBox();
                      } else {
                        return const SizedBox();
                      }
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                BlocListener<ServiceRequestBloc, ServiceRequestState>(
                  listener: (context, state) {
                    if (state is ServiceRequestError) {
                      Fluttertoast.showToast(
                        msg: "ServiceRequest Deleted failed  ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      print("ServiceRequest Deleted failed ");
                    } else if (state is ServiceRequestDeleted) {
                      Fluttertoast.showToast(
                        msg: "ServiceRequest Deleted successfully ",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 12.0,
                      );
                      print("ServiceRequest Deleted successfully ");
                      Navigator.pushNamed(context, '/serviceRequestPage');
                    }
                  },
                  child: const SizedBox(),
                )
              ],
            ),
            verticalSpaceRegular,
          ],
        ),
      ),
    );
  }
}
