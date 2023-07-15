import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assetmng/backEndCalls/AuthApi.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/home_bloc/bloc/home_bloc.dart';
import '../../utils/index.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

final nameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  AuthBloc authBloc = AuthBloc(AuthBlocInitialState(), AuthApi());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<AuthBloc, AuthBlocState>(builder: (context, state) {
        if (state is AuthBlocLodingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return _buildSignUpForm();
      }),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            MediaQuery.of(context).size.height * 0.1,
            0,
            0,
          ),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      children: [
                        const Image(
                          image: AssetImage(
                            'assets/images/logo.png',
                          ),
                          fit: BoxFit.scaleDown,
                        ),
                        customText(
                          "Quee Chat",
                          30,
                          FontWeight.bold,
                          Colors.blue.shade500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(60),
                  //   topRight: Radius.circular(60),
                  // ),
                ),
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    //For Name
                    //
                    textFormField(
                      nameController,
                      'Full Name',
                      (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      false,
                      Icons.person_2_outlined,
                      TextInputType.name,
                    ),
                    const SizedBox(height: 20),
                    //For Email
                    //
                    textFormField(
                      emailController,
                      'Email Address',
                      (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email address';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
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
                      passwordController,
                      'Password',
                      (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
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
                          MediaQuery.of(context).size.width * 0.95,
                          MediaQuery.of(context).size.height * 0.06,
                        ), // button size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0.0,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (nameController.text.isNotEmpty) {
                            // handleSignup(
                            //   nameController.text,
                            //   emailController.text,
                            //   passwordController.text,
                            // );
                          }

                          // Implement sign up functionality here
                          // Navigator.pushNamed(context, '/home');
                        }
                      },
                      child: customText(
                        'Sign up'.toUpperCase(),
                        20,
                        FontWeight.w600,
                        Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        customText(
                          'have account?',
                          14,
                          FontWeight.normal,
                          Colors.black,
                        ),
                        TextButton(
                          child: customText(
                            'Sign in'.toUpperCase(),
                            16,
                            FontWeight.w600,
                            Colors.blue,
                          ),
                          onPressed: () {
                            // Navigator.of(context).pushReplacement(
                            //   MaterialPageRoute(
                            //     builder: (_) => BlocProvider.value(
                            //       value: BlocProvider.of<AuthBloc>(context),
                            //       child: const SignInPage(),
                            //     ),
                            //   ),
                            // );
                            Navigator.pushNamed(context, '/signin');
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
