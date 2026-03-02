import 'package:flutter/material.dart';


class CustomFormTextfield extends StatelessWidget{
  const CustomFormTextfield({super.key, this.onChanged, required this.textFieldHint, this.obscarText=false,});
  final String textFieldHint;
  final Function(String)? onChanged;
 
  final bool obscarText;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return TextFormField( 
   
    obscureText: obscarText,
    validator: (data)
    {
      if(data!.isEmpty)
      {
        return 'Field is required';
      }
    },
    onChanged: onChanged, decoration: 
              InputDecoration(
                hintText: textFieldHint,hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                  )
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                  ),
                ),
                
              ),
              cursorColor: Colors.deepOrange,
              style: TextStyle(color: Colors.white),
              );
  }
}