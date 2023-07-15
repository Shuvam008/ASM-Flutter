// import 'package:assetmng/bloc/asset_bloc/asset_bloc.dart';
import 'package:assetmng/bloc/user_bloc/user_bloc.dart';
import 'package:assetmng/model/asset_model.dart';
import 'package:assetmng/model/user_model.dart';
import 'package:assetmng/shared/colors.dart';
import 'package:assetmng/shared/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/edge_insect.dart';
import '../../shared/text_styles.dart';
import '../../utils/index.dart';
import '../../widget/CustomAppBar.dart';
import '../../widget/side_menu.dart';

class UpdateVendorUser extends StatefulWidget {
  final User user;
  const UpdateVendorUser({super.key, required this.user});

  @override
  State<UpdateVendorUser> createState() => _UpdateVendorUserState();
}

class _UpdateVendorUserState extends State<UpdateVendorUser> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final _formKey1 = GlobalKey<FormState>();

  final username = TextEditingController();
  final password = TextEditingController();
  final locationname = TextEditingController();
  final locationcode = TextEditingController();
  final role = TextEditingController();
  final rolegroup = TextEditingController();
  final maxdevices = TextEditingController();
  final email = TextEditingController();
  final phonenumber = TextEditingController();

  List final_details = [
    "Username",
    "Password",
    "Location Name",
    "Location Code",
    "Role",
    "Role Group",
    "Max Devices",
    "Email",
    "Phone Number",
  ];

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    locationname.dispose();
    locationcode.dispose();
    role.dispose();
    maxdevices.dispose();
    email.dispose();
    phonenumber.dispose();

    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    username.text = widget.user.username;
    password.text = widget.user.password;
    locationname.text = widget.user.locationname;
    locationcode.text = widget.user.locationcode;
    role.text = widget.user.role;
    maxdevices.text = widget.user.maxdevices.toString();
    email.text = widget.user.email;
    phonenumber.text = widget.user.phonenumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List final_details_value = [
      username.text,
      password.text,
      locationname.text,
      locationcode.text,
      "vendor",
      "V",
      maxdevices.text,
      email.text,
      phonenumber.text,
    ];

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Update Vendor",
      ),
      drawer: const SideMenu(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is VendorUsersFetched) {
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
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                textFormField(
                                  username,
                                  "Username",
                                  (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Username.';
                                    }
                                    return null;
                                  },
                                  Colors.white,
                                  "Username of the User",
                                ),
                                verticalSpaceMedium,
                                textFormField(
                                  password,
                                  "Password",
                                  (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Password.';
                                    }
                                    return null;
                                  },
                                  Colors.grey.shade200,
                                  "Password of the User",
                                ),
                                verticalSpaceMedium,
                                textFormField(
                                  locationname,
                                  "Location Name",
                                  (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Location Name.';
                                    }
                                    return null;
                                  },
                                  Colors.white,
                                  "Location Nameof the User",
                                ),
                                verticalSpaceMedium,
                                textFormField(
                                  locationcode,
                                  "Location Code",
                                  (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Location Code.';
                                    }
                                    return null;
                                  },
                                  Colors.grey.shade200,
                                  "Sub-Asset Number of the User",
                                ),
                                verticalSpaceMedium,
                                textFormField(
                                  maxdevices,
                                  "Maximum Devices",
                                  (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Maximum Devices.';
                                    }
                                    return null;
                                  },
                                  Colors.grey.shade200,
                                  "Maximum Devices of the User",
                                ),
                                verticalSpaceMedium,
                                textFormField(
                                  email,
                                  "Email",
                                  (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Email.';
                                    }
                                    return null;
                                  },
                                  Colors.white,
                                  "Email of the User",
                                ),
                                verticalSpaceMedium,
                                textFormField(
                                  phonenumber,
                                  "Phone Number",
                                  (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter Phone Number.';
                                    }
                                    return null;
                                  },
                                  Colors.grey.shade200,
                                  "Phone Number of the User",
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
                        verticalSpaceMedium,
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
                                  User user = User(
                                    id: widget.user.id,
                                    username: username.text,
                                    password: password.text,
                                    locationname: locationname.text,
                                    locationcode: locationcode.text,
                                    role: "vendor",
                                    rolegroup: "V",
                                    maxdevices: int.parse(maxdevices.text),
                                    currentdevices: widget.user.currentdevices,
                                    email: email.text,
                                    phonenumber: phonenumber.text,
                                  );
                                  if (user.toJson().toString() ==
                                      widget.user.toJson().toString()) {
                                    Fluttertoast.showToast(
                                      msg: "No changes Found",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                    print("Bloc Not Call");
                                  } else {
                                    context
                                        .read<UserBloc>()
                                        .add(UsersUpdate(user));
                                    print("Bloc Call");
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ),
                          ),
                          horizontalSpaceSmall,
                        ],
                      ),
                      verticalSpaceTiny,
                      BlocListener<UserBloc, UserState>(
                        listener: (context, state) {
                          if (state is UserUpdatedError) {
                            Fluttertoast.showToast(
                              msg: "Updating Vendor failed ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else if (state is UserUpdated) {
                            Fluttertoast.showToast(
                              msg: "Vendor Updated successfully ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            print("Vendor Updated successfully");
                            Navigator.pushNamed(context, '/vendorUsersPage');
                          }
                        },
                        child: const SizedBox(),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else if (state is UserError) {
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

class TaskCheckBox extends StatelessWidget {
  bool? isChecked = false;
  final Function(bool?) onCheckboxchange;
  TaskCheckBox({super.key, required this.onCheckboxchange, this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.teal[400],
      onChanged: onCheckboxchange,
      value: isChecked,
    );
  }
}
