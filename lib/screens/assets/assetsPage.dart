import 'package:assetmng/bloc/asset_bloc/asset_bloc.dart';
import 'package:assetmng/bloc/auth_bloc/auth_bloc.dart';
import 'package:assetmng/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:assetmng/screens/assets/viewAssetPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/colors.dart';
import '../../shared/edge_insect.dart';
import '../../shared/spacing.dart';
import '../../shared/text_styles.dart';
import '../../utils/index.dart';
import '../../widget/CustomAppBar.dart';
import '../../widget/side_menu.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  bool isAssetsLoad = false;
  @override
  void initState() {
    isAssetsLoad = true;
    super.initState();
  }

// context.read<AssetBloc>().add(AssetFetch("vendor", "TVS"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 240, 240, 240),
      backgroundColor: kWhiteColor,
      appBar: const CustomAppBar(
        title: "Assets",
      ),
      drawer: const SideMenu(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeBlocFetchedState) {
            if (isAssetsLoad) {
              context
                  .read<AssetBloc>()
                  .add(AssetFetch(state.user.role, state.user.locationcode));
            }

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
                    state.user.role == "admin" || state.user.role == "SubAdmin"
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/createAssetPage');
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
                          )
                        : const SizedBox(),
                    horizontalSpaceSmall,
                  ],
                ),
                verticalSpaceSmall,
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<AssetBloc>().add(
                          AssetFetch(state.user.role, state.user.locationcode));
                    },
                    child: BlocBuilder<AssetBloc, AssetBlocState>(
                      builder: (context, state) {
                        if (state is AssetBlocLoding) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is AssetBlocError) {
                          return Center(
                            child: Text(
                              state.error,
                              style: kSubtitleRegularTextStyle,
                            ),
                          );
                        } else if (state is AssetBlocFetched) {
                          return ListView.builder(
                            shrinkWrap: true,
                            padding: kEdgeInsetsAllNormal,
                            itemCount: state.asset.length,
                            itemBuilder: (BuildContext context, int index) {
                              return state.asset.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ViewAssetPage(
                                              asset: state.asset[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          verticalSpaceSmall,
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.11,
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
                                                          state.asset[index]
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
                                                      state.asset[index]
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
                                                      decoration: BoxDecoration(
                                                        color: index.isEven
                                                            ? kWhiteColor
                                                            : kTertiaryColor5,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Text(
                                                        state.asset[index]
                                                            .suppliedto
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        child: Text(
                                                          state.asset[index]
                                                              .supplier
                                                              .toString(),
                                                          // .toUpperCase(),
                                                          overflow: TextOverflow
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
                                                    Flexible(
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        child: Text(
                                                          "expired : ${state.asset[index].warrantyexpired}",
                                                          // .toUpperCase(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.right,
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
                                  : const Center(child: Text("No Asset Found"));
                            },
                          );
                        } else if (state is AssetBlocError) {
                          return Center(
                            child: Text(
                              state.error,
                              style: kSubtitleRegularTextStyle,
                            ),
                          );
                        } else {
                          return Center(
                            child: Text(
                              "Server Error",
                              style: kSubtitleRegularTextStyle,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                "Server Error",
                style: kSubtitleRegularTextStyle,
              ),
            );
          }
        },
      ),
    );
  }
}
