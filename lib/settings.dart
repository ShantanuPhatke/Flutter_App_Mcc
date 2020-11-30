import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isAllowed = false;

  Future _getPermissionFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final permission = prefs.getBool("permission");
    if (permission == null) {
      await prefs.setBool("permission", false);
      setState(() {
        isAllowed = false;
      });
    }
    // print("Permissions: $permission");
    setState(() {
      isAllowed = permission;
      print(isAllowed);
    });
  }

  Future _togglePermission() async {
    final prefs = await SharedPreferences.getInstance();
    bool permission = prefs.getBool("permission");
    await prefs.setBool("permission", !permission);
    // print("Old Permission: $permission");
  }

  @override
  void initState() {
    super.initState();
    _getPermissionFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.redAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Do you want to receive Weather notifications?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                LiteRollingSwitch(
                  value: isAllowed,
                  textOn: "Yes",
                  textOff: "No",
                  colorOn: Colors.greenAccent,
                  colorOff: Colors.redAccent,
                  iconOn: Icons.notifications_active,
                  iconOff: Icons.not_interested,
                  textSize: 18,
                  onChanged: (bool position) {},
                  onTap: () {
                    _togglePermission();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
