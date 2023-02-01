import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:retroskiing/components/stopwatch.dart';
import 'package:retroskiing/components/world_collidable.dart';
import 'package:retroskiing/components/world_finish.dart';
import 'package:retroskiing/models/race.dart';
import 'package:retroskiing/utils/constants.dart';

const uuidTraining1 = '9df070b2-5fb0-43aa-a888-2e8ae5744047';
const uuidTraining2 = '8816a988-7815-41da-b9f1-71fa78f7e977';
const uuidRaceWengen = '4cfdc5e0-2bbc-46c5-93c3-473e6cbcda2a';

bool showOnboarding = true;

double screenWidth = 0;
//playable races for menu
List<Race> racesPlayable = List.empty(growable: true);
//playable trainings for menu
List<Race> trainings = List.empty(growable: true);
//races and trainings for leaderboard
List<Race> racesAndTrainings = List.empty(growable: true);

// race id which is played
String selectedRace = '';
// current Highscore of race played...is loaded in race loading to have it
// in race after
int selectedRaceCurrentHighscore = maxTimeResult;

GameState gameState = GameState.init;
GlobalKey<StopWatchState> stopwatch = GlobalKey();
AudioPlayer audioPlayer = AudioPlayer();

// Gates
List<WorldCollidable> collidableGates = List.empty(growable: true);
// Finish
List<WorldFinish> collidableFinish = List.empty(growable: true);
// slow Snow TODO not used yet
List<Rect> collidableSlow = List.empty(growable: true);

String userNameGlobal = 'Anonymous';
String userCountryGlobal = 'XX';
bool isMusic = false;
bool isSoundFx = false;
bool isDarkMode = false;
