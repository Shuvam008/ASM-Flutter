import 'package:assetmng/backEndCalls/AssetApi.dart';
import 'package:assetmng/backEndCalls/ServiceRequestApi.dart';
import 'package:assetmng/backEndCalls/UserApi.dart';
import 'package:assetmng/bloc/asset_bloc/asset_bloc.dart';
import 'package:assetmng/bloc/service_request_bloc/service_request_bloc.dart';
import 'package:assetmng/bloc/user_bloc/user_bloc.dart';
import 'package:assetmng/shared/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assetmng/backEndCalls/AuthApi.dart';
import 'package:assetmng/bloc/auth_bloc/auth_bloc.dart';
import 'package:assetmng/screens/profile/profilePage.dart';
import 'package:assetmng/utils/index.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bloc/home_bloc/bloc/home_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthBlocInitialState(), AuthApi()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<AssetBloc>(
          create: (context) => AssetBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<ServiceRequestBloc>(
          create: (context) => ServiceRequestBloc(),
        ),
      ],
      // child: MyApp(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AuthApi(),
          ),
          RepositoryProvider(
            create: (context) => AssetApi(),
          ),
          RepositoryProvider(
            create: (context) => UserApi(),
          ),
          RepositoryProvider(
            create: (context) => ServiceRequestApi(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(KeepLogin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: kWhiteColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Color.fromARGB(255, 119, 117, 117)),
        canvasColor: kTertiaryColor5,
      ),
      home: BlocBuilder<AuthBloc, AuthBlocState>(
        builder: (context, state) {
          if (state is AuthBlocKeepLoginState) {
            if (state.user != "") {
              if (state.userinfo.currentdevices > 0) {
                context.read<HomeBloc>().add(InitialFetchEvent(state.user));
                print("1");
                return const HomePage();
              } else {
                print("2");
                return const SignInPage();
              }
            } else {
              print("3");
              return const SignInPage();
            }
          } else {
            print("4");
            return const SignInPage();
          }
        },
      ),
      // initialRoute: token.isEmpty ? Routes.signin : Routes.home,
      routes: Routes.routes,
    );
  }
}
