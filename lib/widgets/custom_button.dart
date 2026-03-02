
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
 CustomButton({super.key,  this.onTab, required  this.buttonText});
 final dynamic buttonText;
  VoidCallback? onTab;
 
  @override
  Widget build(BuildContext context) {
   
   return  GestureDetector(
    onTap: onTab,
     child: Container(
                  width: double.infinity,
                  height: 60,
                 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                     color: Colors.white,
                  ),
                  child: Center(child: Text('$buttonText',style: TextStyle(fontSize: 16),)),
                ),
   );
  }
}