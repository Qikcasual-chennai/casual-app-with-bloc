import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<void> goToLogin(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("token");
  // ignore: use_build_context_synchronously
  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
}

showFlushBar(BuildContext context, String msg, Color color){
  Flushbar(
    message: msg,
    backgroundColor: color,
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    borderRadius: BorderRadius.circular(10),
    duration: const Duration(seconds: 3),
    icon: const Icon(Icons.error_outline, color: Colors.white),
  ).show(context);
}

showLogoutDialog(BuildContext context){
  showDialog(context: context,barrierDismissible: false, builder: (context) {
    return AlertDialog(
      title: const Text("Are you sure?"),
      actions: [
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: const Text("Cancel")),
        ElevatedButton(onPressed: () {
          goToLogin(context);
        }, child: const Text("Logout")),
      ],
    );
  },);
}