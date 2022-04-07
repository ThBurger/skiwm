import 'package:flutter/material.dart';
import 'package:skiwm/utils/theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 50.0),
              const Text("GAME", style: TextStyle(color: Colors.white)),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    SwitchListTile(
                      activeColor: SkiWmColors.primary,
                      value: true,
                      title: const Text("Music On/Off"),
                      onChanged: (val) {},
                    ),
                    _buildDivider(),
                    SwitchListTile(
                      activeColor: SkiWmColors.primary,
                      value: false,
                      title: const Text("Receive Notification"),
                      onChanged: (val) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60.0),
            ],
          ),
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
