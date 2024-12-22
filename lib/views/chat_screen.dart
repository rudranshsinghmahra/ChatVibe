import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:chat_vibe/models/chat_model.dart';
import 'package:chat_vibe/models/message_model.dart';
import 'package:chat_vibe/widgets/received_sent_image_card.dart';
import 'package:chat_vibe/widgets/source_sent_image_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/receiver_chat.dart';
import '../widgets/sender_chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

import 'camera_screen.dart';

class ChatScreen extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel? sourceChat;

  const ChatScreen(
      {super.key, required this.chatModel, required this.sourceChat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  IO.Socket? socket;
  bool isTyping = false;
  List<MessageModel> messagesList = [];

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io("http://192.168.1.5:5000", {
      "transports": ['websocket'],
      "autoConnect": false,
    });
    socket?.connect();
    socket?.emit("signin", widget.sourceChat?.id);
    socket?.onConnect((data) {
      print("Connected");
      //Listening the emitted message from Server
      socket?.on("message", (msg) {
        setMessage(
          "destination",
          msg['message'],
          msg['path'],
        );
        print(msg['message']);
      });
    });
  }

  void sendMessages(String message, int sourceId, int targetId, String path) {
    setMessage("source", message, path);
    socket?.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "path": path,
    });
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
      type: type,
      message: message,
      path: path,
      time: DateTime.now().toString().substring(10, 16),
    );
    setState(() {
      messagesList.add(messageModel);
    });
  }

  void onImageSend(String path) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.1.5:5000/routes/addImage"));
    request.files.add(await http.MultipartFile.fromPath("img", path));
    request.headers.addAll({"Content-type": "multipart/form-data"});
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = jsonDecode(httpResponse.body);
    print("This is the data received: ${data['path']}");
    print(response.statusCode);
    setMessage("source", "", path);
    socket?.emit("message", {
      "message": "",
      "sourceId": widget.sourceChat?.id,
      "targetId": widget.chatModel.id,
      "path": data['path'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 4,
        title: Row(
          children: [
            InkWell(
              child: const Icon(
                CupertinoIcons.back,
                size: 30,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 10),
            ClipOval(
              child: Container(
                color: widget.chatModel.isOnline ? Colors.green : Colors.grey,
                height: 10,
                width: 10,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.chatModel.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ClipOval(
              child: Container(
                color: Colors.blue,
                height: 30,
                width: 30,
                child: const Icon(Icons.phone_in_talk_outlined),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ClipOval(
              child: Container(
                color: Colors.blue,
                height: 30,
                width: 30,
                child: const Icon(Icons.video_call_outlined),
              ),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (messagesList[index].type == "source") {
                      if (messagesList[index].path.isNotEmpty) {
                        return SourceSentImageCard(
                          path: messagesList[index].path,
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: senderChat(
                            context,
                            messagesList[index].message,
                            widget.sourceChat!.profilePicture,
                          ),
                        );
                      }
                    } else {
                      if (messagesList[index].path.isNotEmpty) {
                        return ReceivedSentImageCard(
                            path: messagesList[index].path);
                      } else {
                        return receiverChat(
                          context,
                          messagesList[index].message,
                          widget.chatModel.profilePicture,
                        );
                      }
                    }
                  },
                  itemCount: messagesList.length,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              spreadRadius: 1,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () async {
                                final cameras = await availableCameras();
                                final firstCamera = cameras.first;
                                final imagePath = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CameraScreen(camera: firstCamera),
                                  ),
                                );

                                if (imagePath != null) {
                                  print('Image captured: $imagePath');
                                  onImageSend(imagePath);
                                }
                              },
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                            hintText: 'Type your message here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                isTyping = true;
                              });
                            } else {
                              setState(() {
                                isTyping = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue),
                      child: IconButton(
                        onPressed: () {
                          if (isTyping) {
                            sendMessages(
                              messageController.text,
                              widget.sourceChat!.id,
                              widget.chatModel.id,
                              "",
                            );
                            messageController.clear();
                          }
                        },
                        icon: Icon(
                          isTyping ? Icons.send : Icons.mic,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
