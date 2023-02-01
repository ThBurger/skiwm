import 'package:flutter/material.dart';

@immutable
class Race {
  final String? id;
  final String? racename;
  final int? difficulty;
  final bool? training;
  final String? img;
  final String? raceType;

  const Race({
    this.id,
    this.racename,
    this.difficulty,
    this.training,
    this.img,
    this.raceType,
  });

  @override
  String toString() {
    return 'Race(id: $id, racename: $racename, difficulty: $difficulty, training: $training, img: $img, race_type: $raceType)';
  }

  isEqual(Race? s) {
    return id == s!.id;
  }
}
