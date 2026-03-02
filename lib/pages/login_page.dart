import 'package:chat_app/constants.dart';
import 'package:chat_app/helpers/show_snak_bar_helper.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/utils/assets_data.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget{
 const LoginPage({super.key});
 static String id='Login Page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email,password;
  bool isLoading=false;
  GlobalKey<FormState> formKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return ModalProgressHUD(
    inAsyncCall: isLoading,
     child: Scaffold(
      backgroundColor: kPrimaryColor,
      body:  Padding(
        padding: const EdgeInsets.fromLTRB(16, 60, 16, 32),
        child: Form(
          key: formKey,
          child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                //mainAxisAlignment: MainAxisAlignment.center,
           
                children: [
                  Spacer(flex: 2,),
                  Image.asset(AssetsData.scholar),
                  Text('Scholar Chat',style: TextStyle(fontSize: 32, 
                  fontWeight: FontWeight.bold, fontFamily: kTitleFont,color: Colors.white),textAlign: TextAlign.center,),
                  Spacer(flex: 1,),
                  Row(
                    children: [
                      Text('Login',textAlign: TextAlign.left,style: TextStyle(fontSize: 16, color: Colors.white),),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormTextfield(textFieldHint: 'User Name', onChanged: (data)
                  {
                    email=data;
                  },),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormTextfield(textFieldHint: 'Password',onChanged: (data)
                  {
                    password=data;
                  }, obscarText: true,),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(buttonText: 'Login',onTab:()async{
                    if (formKey.currentState!.validate()) { 
                    isLoading=true;
                    setState(() {});
          
                    try {
                      await signIn();
                      showMessage(context, 'success!');
                      Navigator.pushNamed(context, ChatPage.id, arguments: email);
                    }on FirebaseAuthException catch(firebaseEx)
                      {
                        if(firebaseEx.code== 'user-not-found')
                        {
                          showMessage(context, 'User not found!');
                        }
                        else if(firebaseEx.code=='invalid-credential')
                        {
                          showMessage(context,'Invalid credential'); 
                        }
                        else if(firebaseEx.code== 'rejected-credential')
                        {
                          showMessage(context,'rejected credential');
                        }
                        else
                        {
                          showMessage(context,'Auth Error');
                        }
               
                      }catch(ex)
                      {
                          showMessage(context, 'Error!');
                      };
                  
                      isLoading=false;
                      setState(() {});
                    }
                    else{
                      
                    }
                  },),
                  SizedBox(
                    height: 10,
                  ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                
                Text('You don\'t have an account! ',style: TextStyle(fontSize: 14, color: Colors.white),),
                GestureDetector(
          onTap: (){
             Navigator.pushNamed(context, RegisterPage.id);
          },
          child: Text(' Sign-Up ',style: TextStyle(fontSize: 14, color: Colors.white),)),
                 ],),
                  Spacer(flex:4,),
                ],),
        ),
           
      ),
        ),
   );

  }

   Future<void> signIn() async {
    var auth= FirebaseAuth.instance;
     UserCredential user= await auth.signInWithEmailAndPassword(email: email!, password: password!);
  }
}