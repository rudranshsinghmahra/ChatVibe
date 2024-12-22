import 'package:flutter/material.dart';

Widget receiverChat(BuildContext context, String text,Icon profilePicture) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 12),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 10, bottom: 10, right: 70),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.red.shade100, borderRadius: BorderRadius.circular(30)),
              child: ClipOval(
                child: profilePicture,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(right: 16,bottom: 2),
            child: Text(
              "05:23PM",
              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10,color: Colors.black54),
            ),
          ),
        )
      ],
    ),
  );
}
