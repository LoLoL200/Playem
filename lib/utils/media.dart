import 'package:flutter/material.dart';

class Media extends ChangeNotifier {
  final String imageUrl;
  final String title;
  final String artist;
  final dynamic streamUrl;

  Media({
    required this.imageUrl,
    required this.title,
    required this.artist,
    required this.streamUrl,
  });

  factory Media.fromJson(Map<String, dynamic> json, String streamUrl) {
    return Media(
      title: json['title'] ?? '',
      artist: json['user']['name'] ?? '',
      imageUrl: json['artwork']['1000x1000'] ?? '', // или '150x150'
      streamUrl: streamUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'artist': artist,
      'streamUrl': streamUrl,
    };
  }
}
