import 'package:assetmng/shared/spacing.dart';
import 'package:assetmng/widget/side_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../bloc/service_request_bloc/service_request_bloc.dart';
import '../../model/service_model.dart';
import '../../shared/colors.dart';
import '../../shared/text_styles.dart';
import '../../utils/index.dart';
import '../../widget/CustomAppBar.dart';

class CloseRequestPage extends StatefulWidget {
  final ServiceR service;
  const CloseRequestPage({super.key, required this.service});

  @override
  State<CloseRequestPage> createState() => _CloseRequestPageState();
}

class _CloseRequestPageState extends State<CloseRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionVendor = TextEditingController();

  List final_details = [
    "Service Number",
    "Equipment Type",
    "Serial Number",
    "Location",
    "Description Location",
    "Request Date",
    "Request Time",
  ];
  @override
  Widget build(BuildContext context) {
    List final_details_values = [
      widget.service.id,
      widget.service.equipmenttype,
      widget.service.serialnumber,
      widget.service.location,
      widget.service.descriptionlocation,
      widget.service.requestdate,
      widget.service.requesttime,
    ];
    // Get current date
    DateTime currentDate = DateTime.now();
// Format date as dd/mm/yy
    String formattedDate = DateFormat('dd/MM/yy').format(currentDate);
    String formattedTime = DateFormat('H:mm').format(currentDate);
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: const CustomAppBar(
          title: "Close Request",
        ),
        drawer: const SideMenu(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              verticalSpaceMedium,
              Expanded(
                flex: 3,
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
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter your reamarks",
                      style: kSubtitleTextStyle,
                    ),
                    verticalSpaceTiny,
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        maxLines: null,
                        minLines: 5,
                        keyboardType: TextInputType.multiline,
                        controller: descriptionVendor,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a Reamarks.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  horizontalSpaceMedium,
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                kTertiaryColor2)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ServiceRequestBloc>().add(
                                  ServiceRequestEventClose(
                                    widget.service.copyWith(
                                      requestclosedate: formattedDate,
                                      requestclosetime: formattedTime,
                                      descriptionvendor: descriptionVendor.text,
                                    ),
                                  ),
                                );
                          }
                        },
                        child: const Text('Close Request'),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpaceMedium,
              BlocListener<ServiceRequestBloc, ServiceRequestState>(
                listener: (context, state) {
                  if (state is ServiceRequestClosed) {
                    Fluttertoast.showToast(
                      msg: "Service Request Close successfully ",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 12.0,
                    );
                    print("ServiceRequest Close successfully ");
                    Navigator.pushNamed(context, '/serviceRequestPage');
                  } else if (state is ServiceRequestError) {
                    Fluttertoast.showToast(
                      msg: "Service Request Close failed  ",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                child: Container(),
              )
            ],
          ),
        ));
  }
}
