import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skiwm/pages/account.dart';
import 'package:skiwm/pages/debug.dart';
import 'package:skiwm/pages/leaderboard.dart';
import 'package:skiwm/pages/menu.dart';
import 'package:skiwm/pages/settings.dart';
import 'package:skiwm/pages/shop.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/theme.dart';

Drawer buildDrawer() {
  return Drawer(
    child: Container(
      padding: const EdgeInsets.only(left: 16.0, right: 40),
      decoration: const BoxDecoration(
          color: SkiWmColors.bgColorScreen,
          boxShadow: [BoxShadow(color: Colors.black45)]),
      width: 300,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 60,
              ),
              Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange])),
                  child: const Icon(FontAwesomeIcons.portrait)),
              const SizedBox(height: 5.0),
              Text(
                userProfile.username ?? "Anonymous",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                userProfile.country ?? "",
                style:
                    const TextStyle(color: SkiWmColors.border, fontSize: 16.0),
              ),
              const SizedBox(height: 30.0),
              _buildRow(Icons.home, "Home", MenuPage()),
              _buildDivider(),
              _buildRow(
                  Icons.leaderboard, "Leaderboard", const LeaderboardPage()),
              _buildDivider(),
              _buildRow(Icons.person_pin, "My profile", const AccountPage()),
              _buildDivider(),
              _buildRow(Icons.settings, "Settings", const SettingsPage()),
              _buildDivider(),
              _buildRow(Icons.shopping_cart, "Shop", const ShopPage()),
              _buildDivider(),
              if (kDebugMode)
                _buildRow(Icons.dangerous, "Debug!", const DebugPage()),
              //_buildDivider(),
              //_buildRow(Icons.email, "Contact us"),
            ],
          ),
        ),
      ),
    ),
  );
}

Divider _buildDivider() {
  return const Divider(
    color: SkiWmColors.border,
  );
}

Widget _buildRow(IconData icon, String title, dynamic page) {
  const TextStyle tStyle = TextStyle(color: SkiWmColors.black, fontSize: 16.0);
  return GestureDetector(
    onTap: () {
      Navigator.pushReplacement<void, void>(
        Get.context!,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => page,
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: SkiWmColors.black,
        ),
        const SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        const SizedBox(width: 60.0),
      ]),
    ),
  );
}
