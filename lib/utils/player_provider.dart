import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:playem/utils/media.dart';
import 'package:playem/utils/service/music_api.dart';

class PlayListProvider extends ChangeNotifier {
  List<Media> _playlist = [];
  final MusicApi musikApi = MusicApi();
  int? _currentSongIndex;

  // Audio Player
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  bool _isPlaying = false;

  // Play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].streamUrl;
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  // Pause the song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // Resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // Pause or resume
  void pauseORResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // Seek to a specific position in
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Play next songs
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        _currentSongIndex = 0;
      }
    }
  }

  // Play previons song
  void playPreviosSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  // Listen to duration
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  void setPlaylist(List<Media> playlist) {
    _playlist = playlist;
    listenToDuration();
    notifyListeners();
  }

  // GETTERS
  List<Media> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  AudioPlayer get audioPlayer => _audioPlayer;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // SETTERS

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
