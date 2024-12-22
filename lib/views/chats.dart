import 'package:chat_vibe/models/chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';

class RecentChats extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel? sourceChat;

  const RecentChats(
      {super.key, required this.chatModel, required this.sourceChat});

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              chatModel: widget.chatModel,
              sourceChat: widget.sourceChat,
            ),
          ),
        );
      },
      title: Text(
        widget.chatModel.name.toString(),
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      subtitle: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.done_all,
              color: Colors.yellow,
            ),
          ),
          Expanded(
            child: Text(
              widget.chatModel.currentMessage ??
                  widget.chatModel.about.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.white60,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: Colors.white60,
          child: widget.chatModel.isGroup
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(CupertinoIcons.group_solid),
                )
              : Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: widget.chatModel.profilePicture,
                ),
        ),
      ),
      trailing: Text(
        widget.chatModel.time.toString(),
        style: TextStyle(
          color: Colors.black54,
          fontSize: 10,
        ),
      ),
    );
  }
}
