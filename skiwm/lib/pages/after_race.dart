import 'package:flutter/material.dart';

class AfterRacePage extends StatelessWidget {
  const AfterRacePage({Key? key}) : super(key: key);

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
        child: Center(
          child: Column(
            children: const [
              SizedBox(
                height: 80,
              ),
              Expanded(
                flex: 6,
                child: Align(
                  child: Text("saving score show results etc..."),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
