import 'package:flutter/material.dart';
import 'package:retroskiing/models/race.dart';
import 'package:retroskiing/utils/theme.dart';
import 'package:retroskiing/widgets/credit.dart';
import 'package:retroskiing/widgets/results.dart';

class RaceLeaderboardPage extends StatelessWidget {
  const RaceLeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Race;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(args.racename!),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: RetroSkiingColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [CreditChip(), SizedBox(width: 15)],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            ResultPage(
              raceId: args.id!,
              maxResults: 300,
            ),
          ],
        ),
      ),
    );
  }
}
