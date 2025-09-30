import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'media.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Media> _favoriteTracks = [];

  List<Media> get favoriteTracks => _favoriteTracks;

  void toggleFavorite(Media track) {
    if (isFavorite(track)) {
      _favoriteTracks.removeWhere((t) => t.streamUrl == track.streamUrl);
    } else {
      _favoriteTracks.add(track);
    }
    saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Media track) {
    return _favoriteTracks.any((t) => t.streamUrl == track.streamUrl);
  }

  //  Convert Media to Map
  Map<String, dynamic> mediaToMap(Media track) {
    return {
      'title': track.title,
      'artist': track.artist,
      'imageUrl': track.imageUrl,
      'streamUrl': track.streamUrl.toString(),
    };
  }

  // Create Media from Map
  Media mapToMedia(Map<String, dynamic> map) {
    return Media(
      title: map['title'] ?? '',
      artist: map['artist'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      streamUrl: map['streamUrl'] ?? '',
    );
  }

  // Save Favorites track
  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> jsonList = _favoriteTracks.map((track) {
      final map = mediaToMap(track);
      return jsonEncode(map);
    }).toList();

    await prefs.setStringList('favorite_tracks', jsonList);
  }

  // Load Favorites treack
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('favorite_tracks');

    if (jsonList != null) {
      _favoriteTracks = jsonList.map((item) {
        final map = jsonDecode(item);
        return mapToMedia(map);
      }).toList();
      notifyListeners();
    }
  }
}
