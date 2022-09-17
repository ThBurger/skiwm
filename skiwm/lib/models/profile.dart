import 'dart:convert';
import 'package:flutter/material.dart';

@immutable
class Profile {
  final String? id;
  final String? username;
  final String? country;
  final int? credits;

  const Profile({
    this.id,
    this.username,
    this.country,
    this.credits,
  });

  @override
  String toString() {
    return 'Profile(id: $id, username: $username, country: $country, credits: $credits)';
  }

  factory Profile.fromMap(Map<String, dynamic> data) => Profile(
        id: data['id'] as String?,
        username: data['username'] as String?,
        country: data['country'] as String?,
        credits: data['credits'] == null ? 0 : data['credits'] as int,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'country': country,
        'credits': credits,
      };

  factory Profile.fromJson(String data) {
    return Profile.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  isEqual(Profile? s) {
    return id == s!.id;
  }
}
