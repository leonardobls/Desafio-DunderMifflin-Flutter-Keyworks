import 'package:dunder_mifflin/config/app_styles.dart';
import 'package:dunder_mifflin/data/blocs/login_bloc.dart';
import 'package:dunder_mifflin/data/blocs/login_event.dart';
import 'package:dunder_mifflin/data/models/user_model.dart';
import 'package:dunder_mifflin/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../data/blocs/login_state.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final LoginBloc _loginBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late User user = User();

  var keyboardVisibilityController = KeyboardVisibilityController();
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();

    _loginBloc = LoginBloc();

    initialization();
    KeyboardVisibilityController().onChange.listen((event) {
      setState(() {
        isKeyboardVisible = event;
      });
      event ? print("aberto") : print("fechado");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Route: ${ModalRoute.of(context)!.settings.name}");

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outputLogin,
          builder: (context, state) {
            if (state.data is LoginLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.data is LoginErrorState) {
              return const Center(child: Text("error"));
            }
            return SafeArea(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          width: MediaQuery.of(context).size.width,
                          height: isKeyboardVisible
                              ? MediaQuery.of(context).size.height * 0.20
                              : MediaQuery.of(context).size.height * 0.40,
                          duration: const Duration(milliseconds: 250),
                          child: Image.asset(
                            "assets/images/splashscreen.png",
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  labelText: "E-mail",
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 16,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  errorStyle: TextStyle(
                                    color: AppStyles.errorColor,
                                  ),
                                  focusColor: AppStyles.primaryColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppStyles.primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppStyles.errorColor,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppStyles.errorColor,
                                      width: 1,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black12,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Campo obrigatório";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 45),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: "Senha",
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 16,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  errorStyle: TextStyle(
                                    color: AppStyles.errorColor,
                                  ),
                                  focusColor: AppStyles.primaryColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppStyles.primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppStyles.errorColor,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppStyles.errorColor,
                                      width: 1,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black12,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Campo obrigatório";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 45),
                              InkWell(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    user.userNameOrEmailAddress =
                                        _emailController.text;
                                    user.password = _passwordController.text;
                                    user.rememberClient = true;

                                    _loginBloc.inputLogin
                                        .add(PostLogin(user: user));

                                    // Navigator.push(
                                    //   context,
                                    //   PageRouteBuilder(
                                    //     settings:
                                    //         const RouteSettings(name: "home"),
                                    //     pageBuilder:
                                    //         (context, animation1, animation2) =>
                                    //             const Home(),
                                    //     transitionDuration: Duration.zero,
                                    //     reverseTransitionDuration:
                                    //         Duration.zero,
                                    //   ),
                                    // );
                                  }
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppStyles.primaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(200),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Center(
                                      child: Text(
                                        "Acessar",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void initialization() async {
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc.inputLogin.close();
    super.dispose();
  }
}
