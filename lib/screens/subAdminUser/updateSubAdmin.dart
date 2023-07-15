import 'package:assetmng/bloc/user_bloc/user_bloc.dart';
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

class UpdateSubAdmin extends StatefulWidget {
  final User user;
  const UpdateSubAdmin({super.key, required this.user});

  @override
  State<UpdateSubAdmin> createState() => _UpdateSubAdminState();
}

class _UpdateSubAdminState extends State<UpdateSubAdmin> {
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
    maxdevices.dispose();
    email.dispose();
    phonenumber.dispose();

    _pageController.dispose();
    super.dispose();
  }

  bool notificatin = false;
  List<bool> location = [];
  List<bool> vendor = [];
  List<String> rolegroupInput = [];

  void setRolegroupInput() {
    location = [false, false, false];
    vendor = [false, false, false];
    notificatin = false;

    for (var char in widget.user.rolegroup.characters) {
      if (char == "C") {
        location[0] = true;
        rolegroupInput.add("C");
      }
      if (char == "U") {
        location[1] = true;
        rolegroupInput.add("U");
      }
      if (char == "D") {
        location[2] = true;
        rolegroupInput.add("D");
      }
      if (char == "V") {
        vendor[0] = true;
        rolegroupInput.add("V");
      }
      if (char == "P") {
        vendor[1] = true;
        rolegroupInput.add("P");
      }
      if (char == "T") {
        vendor[2] = true;
        rolegroupInput.add("T");
      }
      if (char == "N") {
        notificatin = true;
        rolegroupInput.add("N");
      }
    }
  }

  @override
  void initState() {
    setRolegroupInput();
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
      "subAdmin",
      rolegroupInput.toString(),
      maxdevices.text,
      email.text,
      phonenumber.text,
    ];

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Update Sub-Admin",
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
                                    id: widget.user.id,
                                    username: username.text,
                                    password: password.text,
                                    locationname: locationname.text,
                                    locationcode: locationcode.text,
                                    role: "subAdmin",
                                    rolegroup: rolegroupInput.toString(),
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
                          if (state is UserError) {
                            Fluttertoast.showToast(
                              msg: "Updating subAdmin user failed ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else if (state is UserUpdated) {
                            Fluttertoast.showToast(
                              msg: "subAdmin user Updated successfully ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            print("subAdmin user Updated successfully");
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
