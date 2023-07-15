import 'package:assetmng/bloc/user_bloc/user_bloc.dart';
import 'package:assetmng/screens/subAdminUser/updateSubAdmin.dart';
import 'package:assetmng/widget/CustomAppBar.dart';
import 'package:assetmng/widget/side_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/user_model.dart';
import '../../shared/colors.dart';
import '../../shared/edge_insect.dart';
import '../../shared/spacing.dart';
import '../../shared/text_styles.dart';
import '../../utils/index.dart';

class ViewSubAdminPage extends StatefulWidget {
  final User user;
  const ViewSubAdminPage({super.key, required this.user});

  @override
  State<ViewSubAdminPage> createState() => _ViewSubAdminPageState();
}

class _ViewSubAdminPageState extends State<ViewSubAdminPage> {
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
  Widget build(BuildContext context) {
    List final_details_values = [
      widget.user.username,
      widget.user.password,
      widget.user.locationname,
      widget.user.locationcode,
      widget.user.role,
      widget.user.rolegroup,
      widget.user.maxdevices,
      widget.user.email,
      widget.user.phonenumber,
    ];
    return Scaffold(
      appBar: const CustomAppBar(title: "View Sub-Admin"),
      drawer: const SideMenu(),
      body: Padding(
        padding: kEdgeInsetsAllNormal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                horizontalSpaceSmall,
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kTertiaryColor)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateSubAdmin(
                                    user: widget.user,
                                  )),
                        );
                      },
                      child: const Text('Update'),
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
                              MaterialStateProperty.all<Color>(kPrimaryColor2)),
                      onPressed: () {
                        context
                            .read<UserBloc>()
                            .add(UsersDelete(widget.user.id));
                      },
                      child: const Text('Delete'),
                    ),
                  ),
                ),
                BlocListener<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserError) {
                      Fluttertoast.showToast(
                        msg: "subAdmin user Deleted failed  ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      print("subAdmin user Deleted failed ");
                    } else if (state is UserDeleted) {
                      Fluttertoast.showToast(
                        msg: "subAdmin user Deleted successfully ",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 12.0,
                      );
                      print("subAdmin user Deleted successfully ");
                      Navigator.pushNamed(context, '/subAdminUserPage');
                    }
                  },
                  child: const SizedBox(),
                )
              ],
            ),
            verticalSpaceRegular,
          ],
        ),
      ),
    );
  }
}
