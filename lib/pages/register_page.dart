import 'package:chat_app/blocs/register_bloc/register_bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helpers/show_snak_bar_helper.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/utils/assets_data.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static String id = 'RegisterPage';

  @override
  Widget build(BuildContext context) {
    String? email;

    String? password;

    bool isLoading = false;

    GlobalKey<FormState> formKey = GlobalKey();

    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterFailure) {
          isLoading = false;
          showMessage(context, state.errorMessage);
        } else if (state is RegisterSucessed) {
          isLoading = false;
          showMessage(context, 'success!');
          Navigator.pushNamed(context, ChatPage.id);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(color: kPSecondryColor),
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
              child: Form(
                key: formKey,
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Image.asset(AssetsData.scholar, height: 90),
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        height: 3,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 22),
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
                      onChanged: (data) {
                        email = data;
                      },
                      textFieldHint: 'Email',
                    ),
                    SizedBox(height: 10),
                    CustomFormTextfield(
                      onChanged: (data) {
                        password = data;
                      },
                      obscarText: true,
                      textFieldHint: 'Password',
                    ),
                    SizedBox(height: 20),
                    CustomFormTextfield(
                      textFieldHint: 'Confirm Password',
                      obscarText: true,
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      buttonText: 'Create an account',
                      onTab: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterBloc>(context).add(
                            RegisterSubmittedEvent(
                              email: email!,
                              password: password!,
                            ),
                          );
                        } else {}
                      },
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You already have an acoount! ',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            ' Login',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
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
