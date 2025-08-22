import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as https;
import 'package:playem/utils/media.dart';

class MusicApi extends ChangeNotifier {
  final String apiSecret =
      'e8b0ba36a8c3e1980264e298fa8713224a0642600aa4e3b5c91772d96fae949c';
  final String apiKey = '07dd250b94ff05607e6d7f1f6f83f653e4c8ea0c';
  final String baseUrl = 'https://api.audius.co';

  //Give host
  Future<String> getHost() async {
    final res = await https.get(Uri.parse(baseUrl));
    final List<dynamic> listHost = json.decode(res.body)['data'];
    return listHost[0] as String;
  }

  // Metadata treaks
  Future<Map<String, dynamic>> fetchTreak(
    String trackID,
    String appName,
  ) async {
    final host = await getHost();
    final res = await https.get(
      Uri.parse('$host/v1/tracks/$trackID?app_name=$appName'),
    );
    return json.decode(res.body)['data'];
  }

  // Url straem
  Future<String> getStreamUrl(String trackId, String appName) async {
    final host = await getHost();
    return '$host/v1/tracks/$trackId/stream?app_name=$appName';
  }

  // Fetches a list of trending tracks from the server.
  Future<List<dynamic>> fetchTrendingTracks(String appName) async {
    final host = await getHost();
    final response = await https.get(
      Uri.parse('$host/v1/tracks/trending?app_name=$appName'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['data'] as List<dynamic>;
    } else {
      throw Exception('Failed to load trending tracks');
    }
  }

  // Fetches trending tracks and maps them to a list of Media objects.
  Future<List<Media>> fetchTrendingMedia(String appName) async {
    final List<dynamic> tracks = await fetchTrendingTracks(appName);
    final host = await getHost();

    List<Media> mediaList = [];

    for (var track in tracks) {
      final String streamUrl =
          '$host/v1/tracks/${track['id']}/stream?app_name=$appName';

      mediaList.add(Media.fromJson(track, streamUrl));
    }

    return mediaList;
  }
}
