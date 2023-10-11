import 'package:casual_app/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "Settings", homeVisible: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications_none_outlined),
                  title: const Text("Notification"),
                  trailing: Switch(
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    },
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                InkWell(
                  child: ListTile(
                    onTap: () {
                      print('Change Email ID');
                    },
                    leading: const Icon(Icons.mark_email_read_outlined),
                    title: const Text('Change Email ID'),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                InkWell(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/change-password");
                    },
                    leading: const Icon(Icons.password_outlined),
                    title: const Text('Change Password'),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                InkWell(
                  child: ListTile(
                    onTap: () {
                      print('change location');
                    },
                    leading: const Icon(Icons.change_circle_outlined),
                    title: const Text('Change Location'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
