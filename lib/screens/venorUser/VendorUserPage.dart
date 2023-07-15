import 'package:assetmng/backEndCalls/UserApi.dart';
import 'package:assetmng/bloc/asset_bloc/asset_bloc.dart';
import 'package:assetmng/bloc/user_bloc/user_bloc.dart';
import 'package:assetmng/screens/assets/viewAssetPage.dart';
import 'package:assetmng/screens/locationUser/viewLocationUserPage.dart';
import 'package:assetmng/screens/subAdminUser/viewSubAdminUserPage.dart';
import 'package:assetmng/screens/venorUser/viewVendorUserPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/colors.dart';
import '../../shared/edge_insect.dart';
import '../../shared/spacing.dart';
import '../../shared/text_styles.dart';
import '../../utils/index.dart';
import '../../widget/CustomAppBar.dart';
import '../../widget/side_menu.dart';

class VendorUsersPage extends StatefulWidget {
  const VendorUsersPage({super.key});

  @override
  State<VendorUsersPage> createState() => _VendorUsersPageState();
}

class _VendorUsersPageState extends State<VendorUsersPage> {
  @override
  void initState() {
    context.read<UserBloc>().add(VendorUsersFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 240, 240, 240),
      backgroundColor: kWhiteColor,
      appBar: const CustomAppBar(
        title: "Vendors",
      ),
      drawer: const SideMenu(),
      body: Column(
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
                        borderSide:
                            const BorderSide(color: kSecondaryColor3, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: kSecondaryColor3, width: 2),
                      ),
                      labelText: 'Search',
                      labelStyle:
                          kBodyRegularTextStyle.copyWith(color: kBlackColor),
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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/createVendorUser');
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
                    Icons.add,
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
                context.read<UserBloc>().add(VendorUsersFetch());
              },
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoding) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is UserError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: kSubtitleRegularTextStyle,
                      ),
                    );
                  } else if (state is VendorUsersFetched) {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: kEdgeInsetsAllNormal,
                      itemCount: state.user.length,
                      itemBuilder: (BuildContext context, int index) {
                        return state.user.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewVendorPage(
                                        user: state.user[index],
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    verticalSpaceSmall,
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.11,
                                      width: MediaQuery.of(context).size.width,
                                      padding: kEdgeInsetsAllSmall,
                                      decoration: BoxDecoration(
                                        color: index.isEven
                                            ? kTertiaryColor5
                                            : kWhiteColor,
                                        borderRadius: BorderRadius.circular(10),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${index + 1} . ",
                                                    style: kSubtitleTextStyle
                                                        .copyWith(
                                                      color: kSecondaryColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    state.user[index]
                                                        .locationcode
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
                                                state.user[index].locationname
                                                    .toString()
                                                    .toUpperCase(),
                                                style:
                                                    kSubtitleTextStyle.copyWith(
                                                        color: kSecondaryColor),
                                              ),
                                              Container(
                                                padding: kEdgeInsetsAllTiny,
                                                decoration: BoxDecoration(
                                                  color: index.isEven
                                                      ? kWhiteColor
                                                      : kTertiaryColor5,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  state.user[index].email
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: Text(
                                                    state
                                                        .user[index].phonenumber
                                                        .toString(),
                                                    // .toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: kSubtitleTextStyle
                                                        .copyWith(
                                                      color: kSecondaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Text(
                                                    "Role Group : ${state.user[index].rolegroup}",
                                                    // .toUpperCase(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.right,
                                                    style: kSubtitleTextStyle
                                                        .copyWith(
                                                            color:
                                                                kSecondaryColor),
                                                  ),
                                                ),
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
                                "No Vendor Found",
                                style: kSubtitleTextStyle,
                              ));
                      },
                    );
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
      ),
    );
  }
}
