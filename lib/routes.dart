import 'package:assetmng/screens/ServiceRequest/ServiceRequestPage.dart';
import 'package:assetmng/screens/assets/assetsPage.dart';
import 'package:assetmng/screens/assets/createAsset.dart';
import 'package:assetmng/screens/locationUser/LocationUserPage.dart';
import 'package:assetmng/screens/locationUser/createLocationUser.dart';
import 'package:assetmng/screens/profile/profilePage.dart';
import 'package:assetmng/screens/subAdminUser/createSubAdmin.dart';
import 'package:assetmng/screens/subAdminUser/subAdminUsersPage.dart';
import 'package:assetmng/screens/venorUser/VendorUserPage.dart';
import 'package:assetmng/screens/venorUser/createVendorUser.dart';

import 'utils/index.dart';

class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static const String signin = '/signin';
  static const String profile = '/profile';
  static const String asset = '/asset';
  static const String createAssetPage = '/createAssetPage';
  static const String subAdminUserPage = '/subAdminUserPage';
  static const String createSubAdmin = '/createSubAdmin';
  static const String locationUsersPage = '/locationUsersPage';
  static const String createLocationUser = '/createLocationUser';
  static const String createVendorUser = '/createVendorUser';
  static const String vendorUsersPage = '/vendorUsersPage';
  static const String serviceRequestPage = '/serviceRequestPage';

  static final Map<String, WidgetBuilder> routes = {
    home: (BuildContext context) => const HomePage(),
    signin: (BuildContext context) => const SignInPage(),
    profile: (BuildContext context) => const ProfilePage(),
    asset: (BuildContext context) => const AssetsPage(),
    createAssetPage: (BuildContext context) => const CreateAssetPage(),
    subAdminUserPage: (BuildContext context) => const SubAdminUsersPage(),
    createSubAdmin: (BuildContext context) => const CreateSubAdmin(),
    locationUsersPage: (BuildContext context) => const LocationUsersPage(),
    createLocationUser: (BuildContext context) => const CreateLocationUser(),
    createVendorUser: (BuildContext context) => const CreateVendorUser(),
    vendorUsersPage: (BuildContext context) => const VendorUsersPage(),
    serviceRequestPage: (BuildContext context) => const ServiceRequestPage(),
    // Add more routes here as needed
  };
}
