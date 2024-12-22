import 'package:chat_vibe/models/chat_model.dart';
import 'package:chat_vibe/views/home_page.dart';
import 'package:flutter/material.dart';

class SelectSourceUserScreen extends StatefulWidget {
  const SelectSourceUserScreen({super.key});

  @override
  State<SelectSourceUserScreen> createState() => _SelectSourceUserScreenState();
}

class _SelectSourceUserScreenState extends State<SelectSourceUserScreen> {
  ChatModel? sourceChat;
  List<ChatModel> chatList = [
    ChatModel(
      about: "Loves hiking and photography",
      profilePicture: Icon(Icons.person, color: Colors.pink),
      name: "Alice Johnson",
      isGroup: false,
      time: "10:45 AM",
      currentMessage: "Hey, are you coming to the party?",
      isOnline: true,
      id: 1,
    ),
    ChatModel(
      about: "Coding enthusiast and gamer",
      profilePicture: Icon(Icons.computer, color: Colors.green),
      name: "Bob's Tech Group",
      isGroup: true,
      time: "09:30 AM",
      currentMessage: "Reminder: Hackathon at 6 PM!",
      isOnline: false,
      id: 2,
    ),
    ChatModel(
      about: "Fitness freak",
      profilePicture: Icon(Icons.fitness_center, color: Colors.orange),
      name: "Chris Evans",
      isGroup: false,
      time: "Yesterday",
      currentMessage: "Don't forget the gym session tomorrow!",
      isOnline: true,
      id: 3,
    ),
    ChatModel(
      about: "Movie Buffs Group",
      profilePicture: Icon(Icons.movie, color: Colors.red),
      name: "Movie Night Crew",
      isGroup: true,
      time: "12:00 PM",
      currentMessage: "Which movie are we watching next?",
      isOnline: false,
      id: 4,
    ),
    ChatModel(
      about: "Traveler and explorer",
      profilePicture: Icon(Icons.airplanemode_active, color: Colors.purple),
      name: "Diana Richards",
      isGroup: false,
      time: "5 mins ago",
      currentMessage: "Just landed in Paris! 🗼",
      isOnline: true,
      id: 5,
    ),
    ChatModel(
      about: "Book club discussions",
      profilePicture: Icon(Icons.book, color: Colors.brown),
      name: "Reader Corner",
      isGroup: true,
      time: "7:45 PM",
      currentMessage: "Next meeting: The Great Gatsby review.",
      isOnline: true,
      id: 6,
    ),
    ChatModel(
      about: "Musician and songwriter",
      profilePicture: Icon(Icons.music_note, color: Colors.deepPurple),
      name: "Ella Harmony",
      isGroup: false,
      time: "11:15 AM",
      currentMessage: "Here's the new song demo. Let me know your thoughts!",
      isOnline: false,
      id: 7,
    ),
    ChatModel(
      about: "Team collaboration",
      profilePicture: Icon(Icons.group, color: Colors.purpleAccent),
      name: "Project Phoenix",
      isGroup: true,
      time: "Yesterday",
      currentMessage: "Deadline is extended to Friday.",
      isOnline: true,
      id: 8,
    ),
    ChatModel(
      about: "Chef and foodie",
      profilePicture: Icon(Icons.restaurant, color: Colors.redAccent),
      name: "Gordon Smith",
      isGroup: false,
      time: "6:30 PM",
      currentMessage: "Try this new recipe I sent you!",
      isOnline: false,
      id: 9,
    ),
    ChatModel(
      about: "Family group",
      profilePicture: Icon(Icons.home, color: Colors.yellow),
      name: "Family Chat",
      isGroup: true,
      time: "2:00 PM",
      currentMessage: "Don't forget the family reunion on Sunday!",
      isOnline: false,
      id: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Select user to log-in"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  setState(() {
                    sourceChat = chatList.removeAt(index);
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        chatModels: chatList,
                        sourceChat: sourceChat,
                      ),
                    ),
                  );
                },
                title: Text(chatList[index].name),
                leading: chatList[index].profilePicture,
              );
            },
            itemCount: chatList.length,
            shrinkWrap: true,
          )
        ],
      ),
    ));
  }
}
