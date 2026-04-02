import 'package:chat_app/constants.dart';
import 'package:chat_app/blocs/login_bloc/login_bloc.dart';
import 'package:chat_app/helpers/show_snak_bar_helper.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/utils/assets_data.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String id = 'Login Page';
  //@override
  //State<LoginPage> createState() => _LoginPageState();

  @override
  Widget build(BuildContext context) {
    String? email, password;
    bool isLoading = false;
    GlobalKey<FormState> formKey = GlobalKey();
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginFailure) {
          isLoading = false;
          showMessage(context, state.message);
        } else if (state is LoginSuccess) {
          isLoading = false;
          showMessage(context, 'success!');
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
        }
      },
      builder: (BuildContext context, LoginState state) {
        return ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(color: kPSecondryColor),
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 32),
              child: Form(
                key: formKey,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(flex: 2),
                    Image.asset(AssetsData.scholar),
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: kTitleFont,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(flex: 1),
                    Row(
                      children: [
                        Text(
                          'Login',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomFormTextfield(
                      textFieldHint: 'User Name',
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                    SizedBox(height: 10),
                    CustomFormTextfield(
                      textFieldHint: 'Password',
                      onChanged: (data) {
                        password = data;
                      },
                      obscarText: true,
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      buttonText: 'Login',
                      onTab: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginBloc>(context).add(
                            LoginSubmittedEvent(
                              email: email!,
                              password: password!,
                            ),
                          );
                        } else {}
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You don\'t have an account! ',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: Text(
                            ' Sign-Up ',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Spacer(flex: 4),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// class _LoginPageState extends State<LoginPage> {

// }
