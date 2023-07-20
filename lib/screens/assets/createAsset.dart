import 'package:assetmng/bloc/asset_bloc/asset_bloc.dart';
import 'package:assetmng/model/asset_model.dart';
import 'package:assetmng/shared/colors.dart';
import 'package:assetmng/shared/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/home_bloc/bloc/home_bloc.dart';
import '../../shared/edge_insect.dart';
import '../../shared/text_styles.dart';
import '../../utils/index.dart';
import '../../widget/CustomAppBar.dart';
import '../../widget/side_menu.dart';

class CreateAssetPage extends StatefulWidget {
  const CreateAssetPage({super.key});

  @override
  State<CreateAssetPage> createState() => _CreateAssetPageState();
}

class _CreateAssetPageState extends State<CreateAssetPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  final equipmenttypeController = TextEditingController();
  final makeController = TextEditingController();
  final serialnumberController = TextEditingController();
  final subassetnumberController = TextEditingController();
  final suppliedtoController = TextEditingController();
  final ponumberController = TextEditingController();
  final purchasedateController = TextEditingController();
  final supplierController = TextEditingController();
  final supplytostationdateController = TextEditingController();
  final warrantyexpiredController = TextEditingController();
  final codallifeController = TextEditingController();
  final codallifeexpiredController = TextEditingController();
  final warrantyController = TextEditingController();
  final amcController = TextEditingController();
  final purchasefromController = TextEditingController();
  final fundController = TextEditingController();
  final suppliermailController = TextEditingController();
  final supplierphonenumberController = TextEditingController();

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
  void dispose() {
    equipmenttypeController.dispose();
    makeController.dispose();
    serialnumberController.dispose();
    subassetnumberController.dispose();
    suppliedtoController.dispose();
    ponumberController.dispose();
    purchasedateController.dispose();
    supplierController.dispose();
    supplytostationdateController.dispose();
    warrantyexpiredController.dispose();
    codallifeController.dispose();
    codallifeexpiredController.dispose();
    warrantyController.dispose();
    amcController.dispose();
    purchasefromController.dispose();
    fundController.dispose();
    suppliermailController.dispose();
    supplierphonenumberController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List final_details_value = [
      equipmenttypeController.text,
      makeController.text,
      serialnumberController.text,
      subassetnumberController.text,
      suppliedtoController.text,
      ponumberController.text,
      purchasedateController.text,
      supplierController.text,
      supplytostationdateController.text,
      warrantyexpiredController.text,
      codallifeController.text,
      codallifeexpiredController.text,
      warrantyController.text,
      amcController.text,
      purchasefromController.text,
      fundController.text,
      suppliermailController.text,
      supplierphonenumberController.text,
    ];

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Create Asset",
      ),
      drawer: const SideMenu(),
      body: BlocBuilder<AssetBloc, AssetBlocState>(
        builder: (context, state) {
          if (state is AssetBlocFetched) {
            return PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                // Step 1

                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          "Equipment Type of the asset",
                        ),
                        verticalSpaceMedium,
                        textFormField(
                          makeController,
                          "Make",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Make.';
                            }
                            return null;
                          },
                          Colors.grey.shade200,
                          "Make of the asset",
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
                          Colors.white,
                          "Serial Number of the asset",
                        ),
                        verticalSpaceMedium,
                        textFormField(
                          subassetnumberController,
                          "Sub-Asset Number",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Sub-Asset Number.';
                            }
                            return null;
                          },
                          Colors.grey.shade200,
                          "Sub-Asset Number of the asset",
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
                          "Asset Supplied To",
                        ),
                        verticalSpaceMedium,
                        textFormField(
                          ponumberController,
                          "P.O. Number",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a P.O. Number.';
                            }
                            return null;
                          },
                          Colors.grey.shade200,
                          "P.O. Number Number of the asset",
                        ),
                        verticalSpaceMedium,
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                kSecondaryColor)),
                                    onPressed: () {
                                      if (_formKey1.currentState!.validate()) {
                                        _pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInCubic,
                                        );
                                      }
                                    },
                                    child: const Text('Next'),
                                  ),
                                ),
                              ),
                              horizontalSpaceSmall,
                            ],
                          ),
                        ),
                        verticalSpaceMedium,
                      ],
                    ),
                  ),
                ),

                // Step 2
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        textFormField(
                          purchasedateController,
                          "Purchase Date",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a purchasedate.';
                            }
                            return null;
                          },
                          Colors.white,
                          "Purchase Date of the asset",
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
                          "Supplier of the asset",
                        ),
                        verticalSpaceMedium,
                        textFormField(
                          supplytostationdateController,
                          "Supply to Station Date",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Supply to Station Date.';
                            }
                            return null;
                          },
                          Colors.white,
                          "Supply to Station Date of the asset",
                        ),
                        verticalSpaceMedium,
                        textFormField(
                          warrantyexpiredController,
                          "Warranty Expired",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Warranty Expired.';
                            }
                            return null;
                          },
                          Colors.grey.shade200,
                          "Warranty Expired of the asset",
                        ),
                        verticalSpaceMedium,
                        textFormField(
                          codallifeController,
                          "Codal Life",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Codal Life.';
                            }
                            return null;
                          },
                          Colors.white,
                          "Codal Life of the asset",
                        ),
                        verticalSpaceMedium,
                        textFormField(
                          codallifeexpiredController,
                          "Codal Life Expired",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Codal Life Expired.';
                            }
                            return null;
                          },
                          Colors.grey.shade200,
                          "Codal Life Expired of the asset",
                        ),
                        verticalSpaceMedium,
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                kSecondaryColor)),
                                    onPressed: () {
                                      _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInCubic,
                                      );
                                    },
                                    child: const Text('Back'),
                                  ),
                                ),
                              ),
                              horizontalSpaceSmall,
                              Expanded(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                kSecondaryColor)),
                                    onPressed: () {
                                      if (_formKey2.currentState!.validate()) {
                                        _pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInCubic,
                                        );
                                      }
                                    },
                                    child: const Text('Next'),
                                  ),
                                ),
                              ),
                              horizontalSpaceSmall,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //step 3
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        textFormField(
                          warrantyController,
                          "Warranty",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter warranty.';
                            }
                            return null;
                          },
                          Colors.white,
                          "warranty Date of the asset",
                        ),
                        verticalSpaceMedium,
                        textFormField(
                          amcController,
                          "AMC",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter amc.';
                            }
                            return null;
                          },
                          Colors.grey.shade200,
                          "amc of the asset",
                        ),
                        verticalSpaceMedium,
                        textFormField(
                          purchasefromController,
                          "Purchase From",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Purchase From.';
                            }
                            return null;
                          },
                          Colors.white,
                          "Asset Purchase From",
                        ),
                        verticalSpaceMedium,
                        textFormField(
                          fundController,
                          "Fund",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Fund.';
                            }
                            return null;
                          },
                          Colors.grey.shade200,
                          "Fund of the asset",
                        ),
                        verticalSpaceMedium,
                        textFormField(
                          suppliermailController,
                          "Supplier Mail",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Supplier Mail.';
                            }
                            return null;
                          },
                          Colors.white,
                          "Supplier Mail of the asset",
                        ),
                        verticalSpaceMedium,
                        textFormField(
                          supplierphonenumberController,
                          "Supplier Phone Number",
                          (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Supplier Phone Number.';
                            }
                            return null;
                          },
                          Colors.grey.shade200,
                          "Supplier Phone Number of the asset",
                        ),
                        verticalSpaceMedium,
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                kSecondaryColor)),
                                    onPressed: () {
                                      _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInCubic,
                                      );
                                    },
                                    child: const Text('Back'),
                                  ),
                                ),
                              ),
                              horizontalSpaceSmall,
                              Expanded(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                kSecondaryColor)),
                                    onPressed: () {
                                      if (_formKey3.currentState!.validate()) {
                                        _pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInCubic,
                                        );
                                      }
                                    },
                                    child: const Text('Next'),
                                  ),
                                ),
                              ),
                              horizontalSpaceSmall,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //Final
                Padding(
                  padding: kEdgeInsetsAllNormal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: final_details.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              color: index.isEven
                                  ? Colors.grey.shade200
                                  : Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    final_details[index],
                                    style: kSubtitleTextStyle,
                                  ),
                                  Text(
                                    final_details_value[index],
                                    style: kSubtitleTextStyle,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      verticalSpaceMedium,
                      Row(
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
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInCubic,
                                  );
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
                                  Asset asset = Asset(
                                    id: state.asset.length + 1,
                                    equipmenttype: equipmenttypeController.text,
                                    make: makeController.text,
                                    serialnumber: serialnumberController.text,
                                    subassetnumber: int.parse(
                                        subassetnumberController.text),
                                    suppliedto:
                                        suppliedtoController.text.toUpperCase(),
                                    ponumber: ponumberController.text,
                                    purchasedate: purchasedateController.text,
                                    supplier:
                                        supplierController.text.toUpperCase(),
                                    supplytostationdate:
                                        supplytostationdateController.text,
                                    warrantyexpired:
                                        warrantyexpiredController.text,
                                    codallife: codallifeController.text,
                                    codallifeexpired:
                                        codallifeexpiredController.text,
                                    warranty: warrantyController.text,
                                    amc: amcController.text,
                                    purchasefrom: purchasefromController.text,
                                    fund: fundController.text,
                                    suppliermail: suppliermailController.text,
                                    supplierphonenumber:
                                        supplierphonenumberController.text,
                                    isActive: true,
                                  );

                                  context
                                      .read<AssetBloc>()
                                      .add(AssetCreate(asset));
                                },
                                child: const Text('Submit'),
                              ),
                            ),
                          ),
                          horizontalSpaceSmall,
                        ],
                      ),
                      verticalSpaceTiny,
                      BlocListener<AssetBloc, AssetBlocState>(
                        listener: (context, state) {
                          if (state is AssetBlocError) {
                            Fluttertoast.showToast(
                              msg: "Saving Asset failed ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInCubic,
                            );
                          } else if (state is AssetBlocCreated) {
                            Fluttertoast.showToast(
                              msg: "Asset Save successfully ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            print("Asset Save successfully");
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                if (state is HomeBlocFetchedState) {
                                  context.read<AssetBloc>().add(AssetFetch(
                                      state.user.role,
                                      state.user.locationcode));
                                  Navigator.pushNamed(context, '/asset');
                                }
                                return const SizedBox();
                              },
                            );
                            Navigator.pushNamed(context, '/asset');
                          }
                        },
                        child: const SizedBox(),
                      )
                    ],
                  ),
                ),
              ],
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
