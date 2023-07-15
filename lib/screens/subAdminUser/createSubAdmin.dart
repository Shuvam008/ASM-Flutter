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

class CreateSubAdmin extends StatefulWidget {
  const CreateSubAdmin({super.key});

  @override
  State<CreateSubAdmin> createState() => _CreateSubAdminState();
}

class _CreateSubAdminState extends State<CreateSubAdmin> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

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
    rolegroup.dispose();
    maxdevices.dispose();
    email.dispose();
    phonenumber.dispose();

    _pageController.dispose();
    super.dispose();
  }

  bool notificatin = false;
  List<bool> location = [false, false, false];
  List<bool> vendor = [false, false, false];
  List<String> rolegroupInput = [];
  @override
  void initState() {
    rolegroupInput = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List final_details_value = [
      username.text,
      password.text,
      locationname.text,
      locationcode.text,
      "subAdmin",
      rolegroupInput.toString(),
      maxdevices.text,
      email.text,
      phonenumber.text,
    ];

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Create Sub-Admin",
      ),
      drawer: const SideMenu(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is SubAdminUsersFetched) {
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
                        Expanded(
                          child: Row(
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
                        // textFormField(
                        //   role,
                        //   "Role",
                        //   (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Please enter a Role.';
                        //     }
                        //     return null;
                        //   },
                        //   Colors.white,
                        //   "Asset Supplied To",
                        // ),

                        verticalSpaceMedium,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Location Create Update Delete",
                              style: kBodyTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Create",
                                      style: kBodyTextStyle,
                                    ),
                                    TaskCheckBox(
                                      onCheckboxchange: (value) {
                                        setState(() {
                                          if (value == true) {
                                            location[0] = true;
                                            rolegroupInput.add("C");
                                          } else {
                                            location[0] = false;
                                            rolegroupInput.remove("C");
                                          }
                                        });
                                      },
                                      isChecked: location[0],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Update",
                                      style: kBodyTextStyle,
                                    ),
                                    TaskCheckBox(
                                      onCheckboxchange: (value) {
                                        setState(() {
                                          if (value == true) {
                                            location[1] = true;
                                            rolegroupInput.add("U");
                                          } else {
                                            location[1] = false;
                                            rolegroupInput.remove("U");
                                          }
                                        });
                                      },
                                      isChecked: location[1],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Delete",
                                      style: kBodyTextStyle,
                                    ),
                                    TaskCheckBox(
                                      onCheckboxchange: (value) {
                                        setState(() {
                                          if (value == true) {
                                            location[2] = true;
                                            rolegroupInput.add("D");
                                          } else {
                                            location[2] = false;
                                            rolegroupInput.remove("D");
                                          }
                                        });
                                      },
                                      isChecked: location[2],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        verticalSpaceTiny,
                        Container(
                          color: Colors.grey.shade200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vendor Create Update Delete",
                                style: kBodyTextStyle,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Create",
                                        style: kBodyTextStyle,
                                      ),
                                      TaskCheckBox(
                                        onCheckboxchange: (value) {
                                          setState(() {
                                            if (value == true) {
                                              vendor[0] = true;
                                              rolegroupInput.add("V");
                                            } else {
                                              vendor[0] = false;
                                              rolegroupInput.remove("V");
                                            }
                                          });
                                        },
                                        isChecked: vendor[0],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Update",
                                        style: kBodyTextStyle,
                                      ),
                                      TaskCheckBox(
                                        onCheckboxchange: (value) {
                                          setState(() {
                                            if (value == true) {
                                              vendor[1] = true;
                                              rolegroupInput.add("P");
                                            } else {
                                              vendor[1] = false;
                                              rolegroupInput.remove("P");
                                            }
                                          });
                                        },
                                        isChecked: vendor[1],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Delete",
                                        style: kBodyTextStyle,
                                      ),
                                      TaskCheckBox(
                                        onCheckboxchange: (value) {
                                          setState(() {
                                            if (value == true) {
                                              vendor[2] = true;
                                              rolegroupInput.add("T");
                                            } else {
                                              vendor[2] = false;
                                              rolegroupInput.remove("T");
                                            }
                                          });
                                        },
                                        isChecked: vendor[2],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        verticalSpaceMedium,
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Notification",
                                  style: kBodyTextStyle,
                                ),
                                TaskCheckBox(
                                  onCheckboxchange: (value) {
                                    setState(() {
                                      if (value == true) {
                                        notificatin = true;
                                        rolegroupInput.add("N");
                                      } else {
                                        notificatin = false;
                                        rolegroupInput.remove("N");
                                      }
                                    });
                                  },
                                  isChecked: notificatin,
                                ),
                              ],
                            ),
                          ],
                        ),
                        verticalSpaceTiny,
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

                        // verticalSpaceMedium,
                        Expanded(
                          child: Row(
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
                                    id: 0,
                                    username: username.text.toLowerCase(),
                                    password: password.text,
                                    locationname: locationname.text,
                                    locationcode: locationcode.text,
                                    role: "subAdmin",
                                    rolegroup: rolegroupInput.toString(),
                                    maxdevices: int.parse(maxdevices.text),
                                    currentdevices: 0,
                                    email: email.text,
                                    phonenumber: phonenumber.text,
                                  );

                                  context.read<UserBloc>().add(UsersAdd(user));
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
                          if (state is UserAddedError) {
                            Fluttertoast.showToast(
                              msg: "Saving Asset failed ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            context.read<UserBloc>().add(SubAdminUsersFetch());
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInCubic,
                            );
                          } else if (state is UserAdded) {
                            Fluttertoast.showToast(
                              msg: "Asset Save successfully ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            print("Asset Save successfully");
                            Navigator.pushNamed(context, '/subAdminUserPage');
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
          } else if (state is UserLoding) {
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
