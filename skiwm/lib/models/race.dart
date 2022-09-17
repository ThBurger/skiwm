import 'dart:convert';
import 'package:flutter/material.dart';

@immutable
class Race {
  final String? id;
  final DateTime? updatedAt;
  final String? racename;
  final int? difficulty;
  final bool? training;
  final DateTime? fromDate;
  final DateTime? tillDate;
  final String? img;
  final int? credits;
  final int? winners;

  const Race({
    this.id,
    this.updatedAt,
    this.racename,
    this.difficulty,
    this.training,
    this.fromDate,
    this.tillDate,
    this.img,
    this.credits,
    this.winners,
  });

  @override
  String toString() {
    return 'Race(id: $id, updatedAt: $updatedAt, racename: $racename, difficulty: $difficulty, training: $training, fromDate: $fromDate, tillDate: $tillDate, img: $img, credits: $credits, winners: $winners)';
  }

  factory Race.fromMap(Map<String, dynamic> data) => Race(
        id: data['id'] as String?,
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
        racename: data['racename'] as String?,
        difficulty: data['difficulty'] as int?,
        training: data['training'] as bool?,
        fromDate: data['from_date'] == null
            ? null
            : DateTime.parse(data['from_date'] as String),
        tillDate: data['till_date'] == null
            ? null
            : DateTime.parse(data['till_date'] as String),
        img: data['img'] == null
            ? 'assets/images/Training_Easy.png'
            : data['img'] as String,
        credits: data['credits'] == null ? 0 : data['credits'] as int,
        winners: data['winners'] == null ? 50 : data['winners'] as int,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'updated_at': updatedAt?.toIso8601String(),
        'racename': racename,
        'difficulty': difficulty,
        'training': training,
        'from_date': fromDate?.toIso8601String(),
        'till_date': tillDate?.toIso8601String(),
        'winners': winners,
      };

  factory Race.fromJson(String data) {
    return Race.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  isEqual(Race? s) {
    return id == s!.id;
  }
}
