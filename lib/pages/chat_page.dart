import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatelessWidget{

  static String id='Chat Page';
  CollectionReference message = FirebaseFirestore.instance.collection(kMessageCollection);
  TextEditingController controller =  TextEditingController();
  final scrollController =ScrollController();

  ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    var mediaRout=ModalRoute.of(context)!.settings.arguments ;
    String email='';
    if(mediaRout!=null)
    {email =mediaRout as String;} 
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy(kCreatedAt).snapshots(),
       builder: (context,snapshot)
    {
 
    if (snapshot.hasData) {
      List<Message> messageList=[];

      for (int i=0;i<snapshot.data!.docs.length; i++)
      {
        messageList.add(Message.fromJson(snapshot.data!.docs[i]));
      }

   
  return Scaffold(
  
  appBar: AppBar(
  automaticallyImplyLeading: false,
  backgroundColor: kPrimaryColor,
  title: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [ 
  Image.asset(kLogo, height: 50,),
   Text('Scholar Chat', style: TextStyle(color: Colors.white, fontFamily: kTitleFont, fontSize: 16),),
    ]),
  ),
  body: Column(
    children:[ 
  Expanded(
  child: ListView.builder(
    controller: scrollController,
    itemCount: messageList.length,
    itemBuilder:(context, index)
  {
    
    return messageList[index].id.toLowerCase() == email.toLowerCase()? ChatBubble(message: messageList[index]): ChatBubbleFriend(message: messageList[index]);
  }),
    ),
  Padding(
    padding: EdgeInsetsGeometry.fromLTRB(16,16,16,32),
    child: TextField(
      controller: controller,
      onSubmitted: (data){
        message.add(
          {
            kMessage:data,
            kCreatedAt:DateTime.now(),
            kId:email,
          }
        );
        controller.clear();
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(microseconds: 500), curve: Curves.easeIn);
      },
      decoration: InputDecoration(
        hintText: 'Send Message',
        suffixIcon: Icon(Icons.send,
        color: kPrimaryColor,),
        border: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kPrimaryColor,  ),
          
        )
      ),
    ),
  ),
  ]),
  
  );
}else
{
return Container();
}
    });
}
}