import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({UniqueKey? key}) : super(key: key);

  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed('/trainig_easy')?.then((_) => setState(() {}));
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Expanded(
                flex: 12,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/skier.png"),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 6,
                child: Align(
                  child: Text("preparing slope..."),
                ),
              ),
              Expanded(
                flex: 4,
                child: Align(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      color: Colors.green,
                      minHeight: 7,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
