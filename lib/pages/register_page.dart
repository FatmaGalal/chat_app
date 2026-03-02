import 'package:chat_app/constants.dart';
import 'package:chat_app/helpers/show_snak_bar_helper.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/utils/assets_data.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget{
   const RegisterPage({super.key});
 static String id='RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

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
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
        child: Form(
          key:  formKey,
          child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                //mainAxisAlignment: MainAxisAlignment.center,
           
                children: [
                  SizedBox(height: 20,),
                  Image.asset(AssetsData.scholar, height: 90,),
                  Text('Scholar Chat',style: TextStyle(fontSize: 32, height: 3,
                  fontWeight: FontWeight.bold, fontFamily: 'Pacifico',color: Colors.white),textAlign: TextAlign.center,),
                  SizedBox(height: 22,),
                  Row(
                 
                    children: [
                      Text('Login',textAlign: TextAlign.left,style: TextStyle(fontSize: 16, color: Colors.white),),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormTextfield(onChanged: (data){
                    email=data;
                  },
                  textFieldHint: 'Email'),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormTextfield(onChanged: (data)
                  {
                    password=data;
                  },
                  obscarText: true,
                  textFieldHint: 'Password'),
                  SizedBox(
                    height: 20,
                  ),
                  CustomFormTextfield(textFieldHint: 'Confirm Password', obscarText: true,),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(buttonText: 'Create an account', onTab: ()async{
                  
                  if (formKey.currentState!.validate()) {
                    isLoading=true;
                    setState(() {});

                   try{
                        
                        await registerUser();
              
                    }on FirebaseAuthException catch(firebaseEx)
                    {
                      if(firebaseEx.code== 'weak-password')
                      {
                        showMessage(context, 'Weak Password!');
                      }
                      else if(firebaseEx.code== 'email-already-in-use')
                      {
                        showMessage(context,'credential-already-in-use');
                      }
     
                    }catch(ex)
                    {
                        showMessage(context, 'Error!');
                    };
     
                    isLoading=false;
                    setState(() {});

                    showMessage(context, 'success!');
                    Navigator.pushNamed(context, ChatPage.id);
                   }
                   else{
                  
                   }
                  
                  
                  },),
                  SizedBox(
                    height: 5,
                  ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Text('You already have an acoount! ',style: TextStyle(fontSize: 14, color: Colors.white),),
              GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Text(' Login',style: TextStyle(fontSize: 14, color: Colors.white),)),
            ],),
            SizedBox(height: 5,),
                ],),
        ),
           
      ),
        ),
   );
  }



  Future<void> registerUser() async {
    var auth= FirebaseAuth.instance;
     UserCredential user= await auth.createUserWithEmailAndPassword(email: email!, password: password!);
  }
}