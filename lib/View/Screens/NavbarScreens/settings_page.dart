import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key, required this.pp});
  final String pp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Settings page   $pp"),
      ),
    );
  }
}
