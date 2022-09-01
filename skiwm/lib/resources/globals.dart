import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:skiwm/components/stopwatch.dart';
import 'package:skiwm/components/world_collidable.dart';
import 'package:skiwm/components/world_finish.dart';
import 'package:skiwm/models/leaderboard_entry.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/utils/constants.dart';

const TRAINING_1 = '9df070b2-5fb0-43aa-a888-2e8ae5744047';
const TRAINING_2 = '8816a988-7815-41da-b9f1-71fa78f7e977';
const RACE_WENGEN = '4cfdc5e0-2bbc-46c5-93c3-473e6cbcda2a';

double screenWidth = 0;
//all races for leaderboard
List<Race> races = List.empty(growable: true);
//playable races for menu
List<Race> racesPlayable = List.empty(growable: true);
//playable trainings for menu
List<Race> trainings = List.empty(growable: true);
//Leaderboard entries for upsert data afer race and highlight leaderboard
List<LeaderboardEntry> userLeaderboardEntries = List.empty(growable: true);

// race id which is played
String selectedRace = '';
// current Highscore of race played...is loaded in splash before game to have it
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

bool isMusic = false;
bool isSoundFx = false;
