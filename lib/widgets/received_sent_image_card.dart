import 'dart:io';

import 'package:flutter/material.dart';

class ReceivedSentImageCard extends StatefulWidget {
  const ReceivedSentImageCard({super.key, required this.path});

  final String path;

  @override
  State<ReceivedSentImageCard> createState() => _ReceivedSentImageCardState();
}

class _ReceivedSentImageCardState extends State<ReceivedSentImageCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,top: 4.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 2.3,
            width: MediaQuery.of(context).size.width / 1.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue.shade500),
            child: Card(
              margin: EdgeInsets.all(3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    "http://192.168.1.5:5000/uploads/${widget.path}",
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
