import 'package:assetmng/backEndCalls/UserApi.dart';
import 'package:assetmng/bloc/asset_bloc/asset_bloc.dart';
import 'package:assetmng/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:assetmng/bloc/service_request_bloc/service_request_bloc.dart';
import 'package:assetmng/bloc/user_bloc/user_bloc.dart';
import 'package:assetmng/model/service_model.dart';
import 'package:assetmng/screens/ServiceRequest/CloseRequestPage.dart';
import 'package:assetmng/screens/ServiceRequest/ViewServiceRequestPage.dart';
import 'package:assetmng/screens/assets/viewAssetPage.dart';
import 'package:assetmng/screens/locationUser/viewLocationUserPage.dart';
import 'package:assetmng/screens/subAdminUser/viewSubAdminUserPage.dart';
import 'package:assetmng/screens/venorUser/viewVendorUserPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../shared/colors.dart';
import '../../shared/edge_insect.dart';
import '../../shared/spacing.dart';
import '../../shared/text_styles.dart';
import '../../utils/index.dart';
import '../../widget/CustomAppBar.dart';
import '../../widget/side_menu.dart';

class ServiceRequestPage extends StatefulWidget {
  const ServiceRequestPage({super.key});

  @override
  State<ServiceRequestPage> createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  @override
  Widget build(BuildContext context) {
    // Get current date
    DateTime currentDate = DateTime.now();
// Format date as dd/mm/yy
    String formattedDate = DateFormat('dd/MM/yy').format(currentDate);
    String formattedTime = DateFormat('H:mm').format(currentDate);
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 240, 240, 240),
      backgroundColor: kWhiteColor,
      appBar: const CustomAppBar(
        title: "Service Request",
      ),
      drawer: const SideMenu(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeBlocFetchedState) {
            context.read<ServiceRequestBloc>().add(ServiceRequestEventFetch(
                state.user.role, state.user.locationcode));
            return Column(
              children: [
                verticalSpaceSmall,
                Row(
                  children: [
                    horizontalSpaceSmall,
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          cursorColor: kPrimaryColor,
                          enabled: true,
                          autofocus: false,
                          style: const TextStyle(color: kBlackColor),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: kSecondaryColor3, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: kSecondaryColor3, width: 2),
                            ),
                            labelText: 'Search',
                            labelStyle: kBodyRegularTextStyle.copyWith(
                                color: kBlackColor),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: kSecondaryColor4,
                            ),
                          ),
                        ),
                      ),
                    ),
                    horizontalSpaceSmall,
                    GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: "Sort",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      child: Container(
                        padding: kEdgeInsetsAllNormal,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: kTertiaryColor5,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 15,
                              offset: Offset(5, 5),
                              color: Colors.grey,
                            ),
                            BoxShadow(
                              blurRadius: 15,
                              offset: Offset(-10, -10),
                              color: Colors.white,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.sort,
                          color: kBlackColor,
                          size: 25,
                        ),
                      ),
                    ),
                    horizontalSpaceSmall,
                  ],
                ),
                verticalSpaceSmall,
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<ServiceRequestBloc>().add(
                          ServiceRequestEventFetch(
                              state.user.role, state.user.locationcode));
                    },
                    child: BlocBuilder<ServiceRequestBloc, ServiceRequestState>(
                      builder: (context, state) {
                        if (state is ServiceRequestLoding) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ServiceRequestError) {
                          return Center(
                            child: Text(
                              state.error,
                              style: kSubtitleRegularTextStyle,
                            ),
                          );
                        } else if (state is ServiceRequestNoDataFound) {
                          return Center(
                            child: Text(
                              state.error,
                              style: kSubtitleRegularTextStyle,
                            ),
                          );
                        } else if (state is ServiceRequestUpdate) {
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
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kSecondaryColor)),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/serviceRequestPage');
                                  },
                                  child: const Text('Done'),
                                ),
                              ),
                            ],
                          );
                        } else if (state is ServiceRequestFetched) {
                          if (state.service.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              padding: kEdgeInsetsAllNormal,
                              itemCount: state.service.length,
                              itemBuilder: (BuildContext context, int index) {
                                return state.service.isNotEmpty
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewServiceRequestPage(
                                                service: state.service[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            verticalSpaceSmall,
                                            Container(
                                              // height: MediaQuery.of(context)
                                              //         .size
                                              //         .height *
                                              //     0.11,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: kEdgeInsetsAllSmall,
                                              decoration: BoxDecoration(
                                                color: index.isEven
                                                    ? kTertiaryColor5
                                                    : kWhiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                // color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 15,
                                                    offset: Offset(1, 1),
                                                    color: Colors.grey,
                                                  ),
                                                  BoxShadow(
                                                    blurRadius: 15,
                                                    offset: Offset(-5, -5),
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${index + 1} . ",
                                                            style:
                                                                kSubtitleTextStyle
                                                                    .copyWith(
                                                              color:
                                                                  kSecondaryColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            state.service[index]
                                                                .equipmenttype
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: kSubtitleTextStyle
                                                                .copyWith(
                                                                    color:
                                                                        kSecondaryColor),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        state.service[index]
                                                            .serialnumber
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: kSubtitleTextStyle
                                                            .copyWith(
                                                                color:
                                                                    kSecondaryColor),
                                                      ),
                                                      Container(
                                                        padding:
                                                            kEdgeInsetsAllTiny,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: index.isEven
                                                              ? kWhiteColor
                                                              : kTertiaryColor5,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Text(
                                                          state.service[index]
                                                              .location
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: kHeading3TextStyle
                                                              .copyWith(
                                                                  color:
                                                                      kSecondaryColor),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  verticalSpaceMedium,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        flex: 2,
                                                        child: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                          child: Text(
                                                            state.service[index]
                                                                .id
                                                                .toString(),
                                                            // .toUpperCase(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                kSubtitleTextStyle
                                                                    .copyWith(
                                                              color:
                                                                  kSecondaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      BlocBuilder<HomeBloc,
                                                          HomeState>(
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is HomeBlocFetchedState) {
                                                            if (state.user
                                                                        .role ==
                                                                    "admin" ||
                                                                state.user
                                                                        .role ==
                                                                    "subAdmin" ||
                                                                state.user
                                                                        .role ==
                                                                    "location") {
                                                              return BlocBuilder<
                                                                  ServiceRequestBloc,
                                                                  ServiceRequestState>(
                                                                builder:
                                                                    (context,
                                                                        state) {
                                                                  if (state
                                                                      is ServiceRequestFetched) {
                                                                    return state.service[index].locationapprovedate ==
                                                                            ""
                                                                        ? state.service[index].requestacknowledgedate ==
                                                                                ""
                                                                            ? SizedBox(
                                                                                child: Row(
                                                                                  children: [
                                                                                    const Icon(
                                                                                      Icons.hourglass_empty,
                                                                                      color: Colors.amber,
                                                                                    ),
                                                                                    horizontalSpaceTiny,
                                                                                    Text(
                                                                                      "Wating",
                                                                                      style: kSubtitleTextStyle,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : state.service[index].requestclosedate == ""
                                                                                ? SizedBox(
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.access_time,
                                                                                          color: Colors.deepOrangeAccent.shade400,
                                                                                        ),
                                                                                        horizontalSpaceTiny,
                                                                                        Text(
                                                                                          "Inprogress",
                                                                                          style: kSubtitleTextStyle,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )
                                                                                : SizedBox(
                                                                                    child: ElevatedButton(
                                                                                      onPressed: () {
                                                                                        context.read<ServiceRequestBloc>().add(ServiceRequestEventUpdate(state.service[index].copyWith(
                                                                                              locationapprovedate: formattedDate,
                                                                                              locationapprovetime: formattedTime,
                                                                                            )));
                                                                                      },
                                                                                      child: const Text(
                                                                                        "Approve",
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                        : SizedBox(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                const Icon(
                                                                                  Icons.done_all,
                                                                                  color: Colors.green,
                                                                                ),
                                                                                horizontalSpaceTiny,
                                                                                Text(
                                                                                  "Completed",
                                                                                  style: kSubtitleRegularTextStyle,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                  }
                                                                  return SizedBox(
                                                                    child: Text(
                                                                      "Error",
                                                                      style:
                                                                          kSubtitleRegularTextStyle,
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            } else if (state
                                                                    .user
                                                                    .role ==
                                                                "vendor") {
                                                              return BlocBuilder<
                                                                  ServiceRequestBloc,
                                                                  ServiceRequestState>(
                                                                builder:
                                                                    (context,
                                                                        state) {
                                                                  if (state
                                                                      is ServiceRequestFetched) {
                                                                    return SizedBox(
                                                                      child: state.service[index].requestacknowledgedate ==
                                                                              ""
                                                                          ? ElevatedButton(
                                                                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor2)),
                                                                              onPressed: () {
                                                                                context.read<ServiceRequestBloc>().add(ServiceRequestEventUpdate(state.service[index].copyWith(
                                                                                      requestacknowledgedate: formattedDate,
                                                                                      requestacknowledgetime: formattedTime,
                                                                                    )));
                                                                              },
                                                                              child: const Text('Acknowledge'),
                                                                            )
                                                                          : state.service[index].requestclosedate == ""
                                                                              ? ElevatedButton(
                                                                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kTertiaryColor2)),
                                                                                  onPressed: () {
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(builder: (context) => CloseRequestPage(service: state.service[index])),
                                                                                    );
                                                                                  },
                                                                                  child: const Text('Close Request'),
                                                                                )
                                                                              : state.service[index].locationapprovedate == ""
                                                                                  ? SizedBox(
                                                                                      child: Text(
                                                                                        "Wating to Approve",
                                                                                        style: kSubtitleRegularTextStyle,
                                                                                      ),
                                                                                    )
                                                                                  : SizedBox(
                                                                                      child: Text(
                                                                                        "Done",
                                                                                        style: kSubtitleRegularTextStyle,
                                                                                      ),
                                                                                    ),
                                                                    );
                                                                  } else {
                                                                    print(
                                                                        "Not Enter1");
                                                                    return const SizedBox();
                                                                  }
                                                                },
                                                              );
                                                            } else {
                                                              print(
                                                                  "Not Enter2");
                                                              return const SizedBox();
                                                            }
                                                          } else {
                                                            print("Not Enter3");
                                                            return const SizedBox();
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            verticalSpaceSmall
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                        "No Requests Found",
                                        style: kSubtitleTextStyle,
                                      ));
                              },
                            );
                          } else {
                            return Center(
                              child: Text(
                                "No Request Found",
                                style: kSubtitleRegularTextStyle,
                              ),
                            );
                          }
                        } else {
                          return Center(
                            child: Text(
                              "Server Error",
                              style: kSubtitleTextStyle,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (state is HomeBlocErrorState) {
            print("jj");
            return Center(
              child: Text(
                state.apiErroe,
                style: kSubtitleRegularTextStyle,
              ),
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
