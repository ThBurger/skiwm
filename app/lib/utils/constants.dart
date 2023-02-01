import 'package:flutter/material.dart';
import 'package:retroskiing/models/race.dart';
import 'package:retroskiing/utils/theme.dart';

const maxTimeResult = 9999999999999;

const dailyRaceStarted = 'dailyRaceStarted';
const dailyRaceFinished = 'dailyRaceFinished';
const profileRaces = 'races';
const profileCrashed = 'crashed';
const profileFinished = 'finished';
const profileTime = 'time';
const profileUsername = 'username';
const profileCountry = 'country';

enum GameState {
  init,
  start,
  playing,
  paused,
  gameOver,
  inFinish,
  finish,
}

final List<Race> racesList = [
  const Race(
      id: '8816a988-7815-41da-b9f1-71fa78f7e977',
      racename: 'Training 2',
      difficulty: 3,
      training: true,
      img: 'assets/images/Training_2.png',
      raceType: 'Super-G'),
  const Race(
      id: '9df070b2-5fb0-43aa-a888-2e8ae5744047',
      racename: 'Training 1',
      difficulty: 1,
      training: true,
      img: 'assets/images/Training_1.png',
      raceType: 'Super-G'),
  const Race(
      id: '4cfdc5e0-2bbc-46c5-93c3-473e6cbcda2a',
      racename: 'Wengen',
      difficulty: 4,
      training: false,
      img: 'assets/images/Race_Wengen.png',
      raceType: 'Super-G'),
  const Race(
      id: 'c433aec7-56cb-409f-9e00-d135a54ac97b',
      racename: 'Kitzbühel',
      difficulty: 5,
      training: false,
      img: 'assets/images/Race_Kitzbühel.png',
      raceType: 'Super-G'),
  //const Race(
  //    id: '51022032-bfa4-408e-9979-89915f9b3983',
  //    racename: 'Bormio',
  //    difficulty: 3,
  //    training: false,
  //    img: null,
  //    raceType: 'Super-G'),
];

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: RetroSkiingColors.black),
      ),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}
