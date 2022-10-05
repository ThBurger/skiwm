import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retroskiing/components/dialog_crashed.dart';
import 'package:retroskiing/utils/theme.dart';
import 'package:retroskiing/widgets/credit.dart';
import 'package:retroskiing/widgets/drawer.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  _DebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      drawer: buildDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        actions: const [CreditChip(), SizedBox(width: 15)],
      ),
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
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: RetroSkiingStyle.buttonHeight,
                      decoration: BoxDecoration(
                        gradient: RetroSkiingStyle.gradient,
                        borderRadius: RetroSkiingStyle.borderRadius,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.dialog(
                            const CrashedDialog(),
                            barrierDismissible: false,
                          );
                        },
                        child: const Text("Show Crashed Dialog"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width),
              const SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }
}
