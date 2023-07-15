import 'package:assetmng/bloc/asset_bloc/asset_bloc.dart';
import 'package:assetmng/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import '../shared/colors.dart';
import '../shared/text_styles.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kTertiaryColor5,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return ListView(
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    const Icon(
                      Icons.assessment,
                      color: kBlackColor,
                    ),
                    Expanded(
                      child: Text(
                        'frames'.toUpperCase(),
                        style: kHeading3TextStyle,
                      ),
                    )
                  ],
                ),
              ),
              DrawerListTile(
                title: "Home",
                icon: Icons.home,
                press: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              DrawerListTile(
                title: "Assets",
                icon: Icons.auto_awesome_mosaic,
                press: () {
                  Navigator.pushNamed(context, '/asset');
                },
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeBlocFetchedState) {
                    if (state.user.role == "admin") {
                      return DrawerListTile(
                        title: "Sub-admins",
                        icon: Icons.admin_panel_settings,
                        press: () {
                          Navigator.pushNamed(context, '/subAdminUserPage');
                        },
                      );
                    }
                  }
                  return const SizedBox();
                },
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeBlocFetchedState) {
                    if (state.user.role == "admin") {
                      return DrawerListTile(
                        title: "Locations",
                        icon: Icons.directions_transit,
                        press: () {
                          Navigator.pushNamed(context, '/locationUsersPage');
                        },
                      );
                    }
                  }
                  return const SizedBox();
                },
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeBlocFetchedState) {
                    if (state.user.role == "admin") {
                      return DrawerListTile(
                        title: "Vendors",
                        icon: Icons.group,
                        press: () {
                          Navigator.pushNamed(context, '/vendorUsersPage');
                        },
                      );
                    }
                  }
                  return const SizedBox();
                },
              ),

              DrawerListTile(
                title: "Service Requests",
                icon: Icons.query_builder_outlined,
                press: () {
                  Navigator.pushNamed(context, '/serviceRequestPage');
                },
              ),

              // DrawerListTile(
              //   title: "Complete Requests",
              //   icon: Icons.done,
              //   press: () {},
              // ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeBlocFetchedState) {
                    if (state.user.role == "subAdmin" ||
                        state.user.role == "admin") {
                      if (state.user.rolegroup.contains("N") ||
                          state.user.rolegroup.contains("AA")) {
                        return DrawerListTile(
                          title: "Notification",
                          icon: Icons.group,
                          press: () {},
                        );
                      }
                    }
                  }
                  return const SizedBox();
                },
              ),
              // DrawerListTile(
              //   title: "Statistics",
              //   icon: Icons.calculate,
              //   press: () {},
              // ),
              // DrawerListTile(
              //   title: "Settings",
              //   icon: Icons.settings,
              //   press: () {},
              // ),
              DrawerListTile(
                title: "Logout",
                icon: Icons.logout,
                press: () {
                  if (state is HomeBlocFetchedState) {
                    context.read<AuthBloc>().add(
                          UserCurrentDeviceUpdateEvent(
                            state.user.copyWith(
                              currentdevices: state.user.currentdevices > 0
                                  ? state.user.currentdevices - 1
                                  : 0,
                            ),
                          ),
                        );
                    try {
                      context.read<AuthBloc>().add(LogOut());

                      Navigator.pushNamed(context, '/signin');
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: kBlackColor,
      ),
      title: Text(
        title,
        style: const TextStyle(color: kBlackColor),
      ),
    );
  }
}
