import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/main_game_page.dart';
import 'package:skiwm/main_training_page.dart';
import 'package:skiwm/pages/Settings.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/background.jpg',
                    fit: BoxFit.cover,
                  ),
                  foregroundDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ListView(
                    padding: const EdgeInsets.all(32.0),
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: kToolbarHeight),
                      const Text(
                        "Retro Ski WM!",
                        textAlign: TextAlign.center,
                      ),
                      // const SizedBox(height: 10.0),
                      // TextField(
                      //   decoration: InputDecoration(
                      //     contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 16.0, horizontal: 32.0),
                      //     suffixIcon: Icon(
                      //       Icons.lock,
                      //       color: Colors.blueGrey,
                      //     ),
                      //     hintText: "Password",
                      //     hintStyle: TextStyle(color: Colors.blueGrey),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(40.0),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.blueGrey),
                      //       borderRadius: BorderRadius.circular(40.0),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 30.0),
                      RaisedButton(
                        textColor: Colors.red,
                        child: Text(
                          "Race",
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: () {
                          Get.to(const MainGamePage());
                        },
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                      ),
                      RaisedButton(
                        textColor: Colors.red,
                        child: const Text(
                          "Training",
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: () {
                          Get.to(const MainTrainingPage());
                        },
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                      ),
                      RaisedButton(
                        textColor: Colors.red,
                        child: Text(
                          "Leaderboards",
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: () {
                          Get.defaultDialog(
                              title: "Not yet implemented",
                              middleText: "Click outside");
                        },
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                      ),
                      RaisedButton(
                        textColor: Colors.red,
                        child: Text(
                          "Profile",
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: () {
                          Get.defaultDialog(
                              title: "Not yet implemented",
                              middleText: "Click outside");
                        },
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                      ),
                      RaisedButton(
                        textColor: Colors.red,
                        child: Text(
                          "Settings",
                          style: TextStyle(fontSize: 25),
                        ),
                        onPressed: () {
                          Get.to(SettingsPage());
                        },
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)),
                      ),
                      const SizedBox(height: 100.0),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ListView(
                    physics:
                        MediaQuery.of(context).viewInsets == EdgeInsets.zero
                            ? NeverScrollableScrollPhysics()
                            : null,
                    padding: const EdgeInsets.all(32.0),
                    shrinkWrap: true,
                    children: const [
                      SizedBox(height: kToolbarHeight),
                      Text(
                        "Made with ❤ by Toburg Labs.",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
