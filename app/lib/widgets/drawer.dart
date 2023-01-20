import 'package:flag/flag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retroskiing/pages/account.dart';
import 'package:retroskiing/pages/debug.dart';
import 'package:retroskiing/pages/leaderboard.dart';
import 'package:retroskiing/pages/menu.dart';
import 'package:retroskiing/pages/news.dart';
import 'package:retroskiing/pages/settings.dart';
import 'package:retroskiing/pages/shop.dart';
import 'package:retroskiing/resources/globals.dart';
import 'package:retroskiing/utils/theme.dart';

Drawer buildDrawer() {
  return Drawer(
    child: Container(
      padding: const EdgeInsets.only(left: 16.0, right: 40),
      decoration: const BoxDecoration(
          color: RetroSkiingColors.bgColorScreen,
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
                ),
                child: const Image(
                  image: AssetImage("assets/images/skier.png"),
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                userProfile.username ?? "Anonymous",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600),
              ),
              Flag.fromString(
                userProfile.country ?? "XX",
                height: 30,
                width: 30,
              ),
              const SizedBox(height: 30.0),
              _buildRow(Icons.home, "Home", MenuPage()),
              _buildDivider(),
              _buildRow(
                  Icons.leaderboard, "Leaderboard", const LeaderboardPage()),
              _buildDivider(),
              _buildRow(Icons.newspaper, "News", const NewsPage()),
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
    color: RetroSkiingColors.border,
  );
}

Widget _buildRow(IconData icon, String title, dynamic page) {
  const TextStyle tStyle =
      TextStyle(color: RetroSkiingColors.black, fontSize: 16.0);
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
          color: RetroSkiingColors.black,
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