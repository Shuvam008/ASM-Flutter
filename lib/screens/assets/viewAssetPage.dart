import 'package:assetmng/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:assetmng/bloc/service_request_bloc/service_request_bloc.dart';
import 'package:assetmng/model/asset_model.dart';
import 'package:assetmng/screens/assets/updateAssetPage.dart';
import 'package:assetmng/widget/CustomAppBar.dart';
import 'package:assetmng/widget/side_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/asset_bloc/asset_bloc.dart';
import '../../model/service_model.dart';
import '../../shared/colors.dart';
import '../../shared/edge_insect.dart';
import '../../shared/spacing.dart';
import '../../shared/text_styles.dart';
import '../../utils/index.dart';
import '../ServiceRequest/CreateServiceRequestPage.dart';

class ViewAssetPage extends StatefulWidget {
  final Asset asset;
  const ViewAssetPage({super.key, required this.asset});

  @override
  State<ViewAssetPage> createState() => _ViewAssetPageState();
}

class _ViewAssetPageState extends State<ViewAssetPage> {
  List final_details = [
    "Equipment Type",
    "Make",
    "Serial Number",
    "Subasset Number",
    "Supplied To",
    "P.O. Number",
    "Purchase Date",
    "Supplier",
    "Supplyto Station Date",
    "Warranty Expired",
    "Codal Life",
    "Codal Life Expired",
    "Warranty",
    "AMC",
    "Purchase From",
    "Fund",
    "Supplier Mail",
    "Supplier Phone Number",
  ];

  @override
  Widget build(BuildContext context) {
    List final_details_Values = [
      widget.asset.equipmenttype,
      widget.asset.make,
      widget.asset.serialnumber,
      widget.asset.subassetnumber,
      widget.asset.suppliedto,
      widget.asset.ponumber,
      widget.asset.purchasedate,
      widget.asset.supplier,
      widget.asset.supplytostationdate,
      widget.asset.warrantyexpired,
      widget.asset.codallife,
      widget.asset.codallifeexpired,
      widget.asset.warranty,
      widget.asset.amc,
      widget.asset.purchasefrom,
      widget.asset.fund,
      widget.asset.suppliermail,
      widget.asset.supplierphonenumber,
    ];
    return Scaffold(
      appBar: const CustomAppBar(title: "View Asset"),
      drawer: const SideMenu(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeBlocFetchedState) {
            return Padding(
              padding: kEdgeInsetsAllNormal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: final_details_Values.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: index.isEven
                              ? Colors.grey.shade200
                              : Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                final_details[index],
                                style: kSubtitleTextStyle,
                              ),
                              Text(
                                final_details_Values[index].toString(),
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
                      state.user.role != "location" &&
                              state.user.role != "vendor"
                          ? Expanded(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kTertiaryColor)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateAssetPage(
                                                asset: widget.asset,
                                              )),
                                    );
                                  },
                                  child: const Text('Update'),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      horizontalSpaceSmall,
                      state.user.role != "location" &&
                              state.user.role != "vendor"
                          ? Expanded(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kPrimaryColor2)),
                                  onPressed: () {
                                    context
                                        .read<AssetBloc>()
                                        .add(AssetDelete(widget.asset.id));
                                  },
                                  child: const Text('Delete'),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      state.user.role == "location"
                          ? Expanded(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      kPrimaryColor2,
                                    ),
                                  ),
                                  onPressed: () {
                                    final ServiceR createNewService = ServiceR(
                                      id: widget.asset.id,
                                      equipmenttype: widget.asset.equipmenttype,
                                      serialnumber: widget.asset.serialnumber,
                                      location: widget.asset.suppliedto,
                                      supplier: widget.asset.supplier,
                                      requestdate: "",
                                      requesttime: "",
                                      requestacknowledgedate: "",
                                      requestacknowledgetime: "",
                                      requestclosedate: "",
                                      requestclosetime: "",
                                      descriptionlocation: "",
                                      descriptionvendor: "",
                                      locationapprovedate: "",
                                      locationapprovetime: "",
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CreateServiceRequestPage(
                                          service: createNewService,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Service Request'),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      BlocListener<AssetBloc, AssetBlocState>(
                        listener: (context, state) {
                          if (state is AssetBlocError) {
                            Fluttertoast.showToast(
                              msg: "Asset Deleted failed  ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            print("Asset Deleted failed ");
                          } else if (state is AssetBlocDeleted) {
                            Fluttertoast.showToast(
                              msg: "Asset Deleted successfully ",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 12.0,
                            );
                            print("Asset Deleted successfully ");
                            Navigator.pushNamed(context, '/asset');
                          }
                        },
                        child: const SizedBox(),
                      )
                    ],
                  ),
                  verticalSpaceRegular,
                ],
              ),
            );
          } else if (state is HomeBlocErrorState) {
            return Center(
              child: Text(
                state.apiErroe,
                style: kSubtitleRegularTextStyle,
              ),
            );
          } else if (state is HomeBlocLodingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
}
