import 'package:flutter/material.dart';
import 'package:skiwm/components/stopwatch.dart';
import 'package:skiwm/models/leaderboard_entry.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/utils/constants.dart';

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

GameState gameState = GameState.init;

GlobalKey<StopWatchState> stopwatch = GlobalKey();
