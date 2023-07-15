import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assetmng/bloc/auth_bloc/auth_bloc.dart';
import 'package:assetmng/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../backEndCalls/AuthApi.dart';
import '../../shared/colors.dart';
import '../../shared/text_styles.dart';
import '../../utils/index.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

final useroginController = TextEditingController();
final passwordloginController = TextEditingController();

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  AuthBloc authBloc = AuthBloc(AuthBlocInitialState(), AuthApi());

  bool isApiErroe = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.amber.shade200,
        body: BlocBuilder<AuthBloc, AuthBlocState>(builder: (context, state) {
          // if (state is AuthBlocLodingState) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          return _buildSignUpForm1();
        }),
      ),
    );
  }

  Widget _buildSignUpForm1() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: const Image(
                    image: AssetImage(
                      'assets/images/pngegg.png',
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Center(
                  child: Text(
                    'frames'.toUpperCase(),

                    style: kHeading2TextStyle.copyWith(color: kBlackColor),
                    // TextStyle(
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: MediaQuery.of(context).size.width * 0.1,
                    //   color: Colors.black,
                    // ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'FAILURE RECORDING AND MANAGEMENT ENHANCED SYSTEM ',
                        style: kSubtitleTextStyle.copyWith(color: kBlackColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
              child: Column(
                children: [
                  Text(
                    "Welcome",
                    style: kHeading3TextStyle.copyWith(color: kBlackColor),
                  ),
                  // customText("Welcome!", 20, FontWeight.bold, Colors.black),
                  const SizedBox(height: 40),
                  //For Email
                  //
                  textFormField(
                    useroginController,
                    'Email Address',
                    (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your user name';
                      } else if (value.length < 2) {
                        return 'User must be at least 5 characters long';
                      }
                      return null;
                    },
                    false,
                    Icons.email_outlined,
                    TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  //For Password
                  //
                  textFormField(
                    passwordloginController,
                    'Password',
                    (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 5) {
                        return 'Password must be at least 5 characters long';
                      }
                      return null;
                    },
                    true,
                    Icons.key_outlined,
                    TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black87,
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 1,
                        MediaQuery.of(context).size.height * 0.06,
                      ), // button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      elevation: 5.0,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        isApiErroe = true;

                        // Future.delayed(const Duration(seconds: 1), (() {
                        authBloc.add(UserFetchEvent(useroginController.text));
                        // }));

                        // authBloc.add(
                        //   LoginEvent(useroginController.text,
                        //       passwordloginController.text),
                        // );
                      }
                    },
                    child: BlocConsumer(
                      bloc: authBloc,
                      listener: (context, state) async {
                        if (state is AuthBlocLoginState) {
                          if (state.loginResponse == "ok") {
                            context
                                .read<AuthBloc>()
                                .add(KeepLoginToken(useroginController.text));
                            context.read<HomeBloc>().add(
                                InitialFetchEvent(useroginController.text));
                            Navigator.pushNamed(context, '/home');
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthBlocLodingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is AuthBlocErrorState) {
                          isApiErroe = false;
                          return Center(
                            child: Text(state.apiErroe),
                          );
                        } else if (state is AuthBlocFetchUser) {
                          if (isApiErroe) {
                            if (state.user.currentdevices <
                                state.user.maxdevices) {
                              authBloc.add(
                                UserCurrentDeviceUpdateEvent(
                                  state.user.copyWith(
                                    currentdevices:
                                        state.user.currentdevices + 1,
                                  ),
                                ),
                              );
                              authBloc.add(
                                LoginEvent(useroginController.text,
                                    passwordloginController.text),
                              );
                            } else {
                              // authBloc.add(
                              //   LoginEvent(useroginController.text,
                              //       passwordloginController.text),
                              // );
                              print("Maximum noumber reach");
                              return customText(
                                "Maximum noumbers of user reach".toUpperCase(),
                                14,
                                FontWeight.w600,
                                Colors.white,
                              );
                            }
                          }
                        }
                        return Text(
                          'Login'.toUpperCase(),
                          style:
                              kHeading2TextStyle.copyWith(color: kWhiteColor),
                        );
                      },
                    ),
                    // color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
