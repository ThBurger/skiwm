import 'package:flutter/material.dart';
import 'package:skiwm/components/stopwatch.dart';
import 'package:skiwm/models/leaderboard_entry.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/utils/constants.dart';

List<Race> races = List.empty(growable: true);
List<LeaderboardEntry> userLeaderboard = List.empty(growable: true);

GameState gameState = GameState.init;

GlobalKey<StopWatchState> stopwatch = GlobalKey();
