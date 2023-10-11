import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

AppBar customAppbar({required BuildContext context, required String title, required bool homeVisible}){
  return AppBar(
    title: Text(title),
    actions: [
      homeVisible ?
      Container(
        margin: const EdgeInsets.all(10),
        // decoration: const ShapeDecoration(
        //   shape: CircleBorder(side: BorderSide(width: 1, color: Colors.grey))
        // ),
        child: CircleAvatar(
          child: IconButton(onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, "/bottom-bar", (route) => false);
          }, icon: const Icon(Icons.home),iconSize: 20),
        ),
      ): const Gap(1),
    ],
  );
}