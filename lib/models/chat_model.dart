import 'package:flutter/material.dart';

class ChatModel {
  String about;
  Icon profilePicture;
  String name;
  bool isGroup;
  String time;
  String currentMessage;
  bool isOnline;
  int id;

  ChatModel({
    required this.about,
    required this.profilePicture,
    required this.name,
    required this.isGroup,
    required this.time,
    required this.currentMessage,
    required this.isOnline,
    required this.id,
  });
}
