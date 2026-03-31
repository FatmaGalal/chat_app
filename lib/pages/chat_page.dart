import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'Chat Page';

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var mediaRout = ModalRoute.of(context)!.settings.arguments;
    final email =
        mediaRout as String? ?? FirebaseAuth.instance.currentUser?.email ?? '';

    context.read<ChatCubit>().getChatMessages();

    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        final messageList = BlocProvider.of<ChatCubit>(
          context,
        ).getChatMessages();

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(kLogo, height: 50),
                Text(
                  'Scholar Chat',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: kTitleFont,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  //reverse: true,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return messageList[index].id.toLowerCase() ==
                            email.toLowerCase()
                        ? ChatBubble(message: messageList[index])
                        : ChatBubbleFriend(message: messageList[index]);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(16, 16, 16, 32),
                child: TextField(
                  controller: controller,
                  onSubmitted: (data) async {
                    if (data.trim().isEmpty) {
                      return;
                    }

                    await BlocProvider.of<ChatCubit>(
                      context,
                    ).sendMessage(message: data.trim(), id: email);
                    controller.clear();
                  },
                  decoration: InputDecoration(
                    hintText: 'Send Message',
                    suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
