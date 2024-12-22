import 'package:flutter/material.dart';

class FlexibleAppBar extends StatelessWidget {
  const FlexibleAppBar({super.key});
  final double appBarHeight = 66.0;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + appBarHeight,
      child: Center(
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Here...',
                hintStyle: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white60,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
