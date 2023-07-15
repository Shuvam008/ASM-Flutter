import 'package:intl/intl.dart';
import 'package:assetmng/widget/CustomAppBar.dart';
import 'package:assetmng/widget/side_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/service_request_bloc/service_request_bloc.dart';
import '../../model/service_model.dart';
import '../../shared/colors.dart';
import '../../shared/spacing.dart';
import '../../shared/text_styles.dart';
import '../../utils/index.dart';

class CreateServiceRequestPage extends StatefulWidget {
  final ServiceR service;
  const CreateServiceRequestPage({super.key, required this.service});

  @override
  State<CreateServiceRequestPage> createState() =>
      _CreateServiceRequestPageState();
}

class _CreateServiceRequestPageState extends State<CreateServiceRequestPage> {
  final _formKey12 = GlobalKey<FormState>();

  final equipmenttypeController = TextEditingController();
  final serialnumberController = TextEditingController();
  final suppliedtoController = TextEditingController();
  final supplierController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  void initState() {
    equipmenttypeController.text = widget.service.equipmenttype;
    serialnumberController.text = widget.service.serialnumber;
    suppliedtoController.text = widget.service.location;
    supplierController.text = widget.service.supplier;
    descriptionController.text = widget.service.descriptionlocation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get current date
    DateTime currentDate = DateTime.now();
// Format date as dd/mm/yy
    String formattedDate = DateFormat('dd/MM/yy').format(currentDate);
    String formattedTime = DateFormat('H:mm').format(currentDate);
    return Scaffold(
      appBar: const CustomAppBar(title: "Create Service Request"),
      drawer: const SideMenu(),
      body: BlocBuilder<ServiceRequestBloc, ServiceRequestState>(
        builder: (context, state) {
          if (state is ServiceRequestFetched ||
              state is ServiceRequestNoDataFound) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            textFormField(
                              equipmenttypeController,
                              "Equipment Type",
                              (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Equipment Type.';
                                }
                                return null;
                              },
                              Colors.white,
                              "Equipment Type of the Asset",
                            ),
                            verticalSpaceMedium,
                            textFormField(
                              serialnumberController,
                              "Serial Number",
                              (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Serial Number.';
                                }
                                return null;
                              },
                              Colors.grey.shade200,
                              "Serial Number of the Asset",
                            ),
                            verticalSpaceMedium,
                            textFormField(
                              suppliedtoController,
                              "Supplied To",
                              (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Supplied To.';
                                }
                                return null;
                              },
                              Colors.white,
                              "Supplied To of the Asset",
                            ),
                            verticalSpaceMedium,
                            textFormField(
                              supplierController,
                              "Supplier",
                              (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Supplier.';
                                }
                                return null;
                              },
                              Colors.grey.shade200,
                              "Supplier the Asset",
                            ),
                            verticalSpaceMedium,
                            textFormField(
                              descriptionController,
                              "Description",
                              (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Description.';
                                }
                                return null;
                              },
                              Colors.grey.shade200,
                              "Description of the Asset Problem",
                            ),
                            verticalSpaceMedium,
                          ],
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kSecondaryColor)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Back'),
                            ),
                          ),
                        ),
                        horizontalSpaceSmall,
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kSecondaryColor)),
                              onPressed: () {
                                if (_formKey12.currentState!.validate()) {
                                  final ServiceR createNewService = ServiceR(
                                    id: widget.service.id,
                                    equipmenttype: widget.service.equipmenttype,
                                    serialnumber: widget.service.serialnumber,
                                    location: widget.service.location,
                                    supplier: widget.service.supplier,
                                    requestdate: formattedDate,
                                    requesttime: formattedTime,
                                    requestacknowledgedate: "",
                                    requestacknowledgetime: "",
                                    requestclosedate: "",
                                    requestclosetime: "",
                                    descriptionlocation:
                                        descriptionController.text,
                                    descriptionvendor: "",
                                    locationapprovedate: "",
                                    locationapprovetime: "",
                                  );
                                  context.read<ServiceRequestBloc>().add(
                                      ServiceRequestEventCreate(
                                          createNewService));
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                        ),
                        horizontalSpaceSmall,
                      ],
                    ),
                    verticalSpaceMedium,
                  ],
                ),
              ),
            );
          } else if (state is ServiceRequestCreated) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(
                  child: Center(
                    child: Icon(
                      Icons.done_outline_rounded,
                      color: Colors.green,
                      size: 80,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kSecondaryColor)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/serviceRequestPage');
                    },
                    child: const Text('Done'),
                  ),
                ),
              ],
            );
          } else if (state is ServiceRequestError) {
            return Center(
              child: Text(
                state.error,
                style: kSubtitleRegularTextStyle,
              ),
            );
          } else if (state is ServiceRequestLoding) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Text(
                "Error",
                style: kSubtitleRegularTextStyle,
              ),
            );
          }
        },
      ),
    );
  }

  Widget textFormField(
    TextEditingController controller,
    String hintText,
    FormFieldValidator<String> validator,
    Color colors,
    String helperText,
  ) {
    return TextFormField(
      controller: controller,
      style: kBodyTextStyle,
      decoration: InputDecoration(
        filled: true,
        fillColor: colors,
        labelText: hintText,
        border: const UnderlineInputBorder(),
        helperText: helperText,
      ),
      validator: validator,
    );
  }
}
