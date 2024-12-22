import 'package:chat_vibe/models/chat_model.dart';
import 'package:flutter/material.dart';
import '../Widgets/my_app_bar.dart';
import 'camera.dart';
import 'chats.dart';
import 'contacts.dart';
import 'group.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.chatModels,required this.sourceChat});
  final List<ChatModel> chatModels;
  final ChatModel? sourceChat;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xff2196f3).withOpacity(0.8),
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              title: SafeArea(
                child: MyAppBar(),
              ),
              expandedHeight: 120,
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    icon: Icon(Icons.history, size: 40),
                  ),
                  Tab(
                    icon: Icon(Icons.people, size: 40),
                  ),
                  Tab(
                    icon: Icon(Icons.perm_contact_cal_sharp, size: 40),
                  ),
                  Tab(
                    icon: Icon(Icons.camera, size: 40),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemBuilder: (context, int index) {
                      return RecentChats(
                        chatModel: widget.chatModels[index],
                        sourceChat: widget.sourceChat,
                      );
                    },
                    itemCount: widget.chatModels.length,
                    padding: EdgeInsets.zero,
                  ),
                  const Groups(),
                  const Contacts(),
                  const Camera(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
