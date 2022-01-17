import 'dart:convert';
import 'package:flutter/material.dart';

@immutable
class LeaderboardEntry {
  final String? id;
  final DateTime? updatedAt;
  final String? userId;
  final String? raceId;
  final String? finishedTime;
  final String? username;

  const LeaderboardEntry({
    this.id,
    this.updatedAt,
    this.userId,
    this.raceId,
    this.finishedTime,
    this.username,
  });

  @override
  String toString() {
    return 'LeaderboardEntry(id: $id, updatedAt: $updatedAt, userId: $userId, raceId: $raceId, finishedTime: $finishedTime, username: $username)';
  }

  factory LeaderboardEntry.fromMap(Map<String, dynamic> data) =>
      LeaderboardEntry(
        id: data['id'] as String?,
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
        userId: data['user_id'] as String?,
        raceId: data['race_id'] as String?,
        finishedTime: data['finished_time'] as String,
        username: data['profiles'] == null
            ? ''
            : data['profiles']['username'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'updated_at': updatedAt?.toIso8601String(),
        'user_id': userId,
        'race_id': raceId,
        'finished_time': finishedTime,
      };

  factory LeaderboardEntry.fromJson(String data) {
    return LeaderboardEntry.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  isEqual(LeaderboardEntry? s) {
    return id == s!.id;
  }
}
