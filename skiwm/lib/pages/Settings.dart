import 'package:flutter/material.dart';
import 'package:skiwm/constants.dart';

class SettingsPage extends StatelessWidget {
  static final String path = "settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Settings"),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("GAME", style: TextStyle(color: Colors.white)),
            Card(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: Column(
                children: <Widget>[
                  SwitchListTile(
                    activeColor: Colors.purple,
                    value: true,
                    title: Text("Music On/Off"),
                    onChanged: (val) {},
                  ),
                  _buildDivider(),
                  SwitchListTile(
                    activeColor: Colors.purple,
                    value: false,
                    title: Text("Receive Notification"),
                    onChanged: (val) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }
}
