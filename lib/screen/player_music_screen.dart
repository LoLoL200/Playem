import 'package:flutter/material.dart';
import 'package:playem/utils/favorite_provider.dart';
import 'package:playem/utils/media.dart';
import 'package:playem/utils/service/music_api.dart';
import 'package:playem/utils/player_provider.dart';
import 'package:playem/utils/service/notification_music_service.dart';
import 'package:playem/utils/widget/neu_box.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerMusicScreen extends StatefulWidget {
  final Media selectedTrack;

  const PlayerMusicScreen({Key? key, required this.selectedTrack})
    : super(key: key);

  @override
  State<PlayerMusicScreen> createState() => _PlayerMusicScreen();
}

class _PlayerMusicScreen extends State<PlayerMusicScreen> {
  late Media currentTrack;
  bool isFavorite = false;

  void initState() {
    super.initState();
    loadToggleState();
    currentTrack = widget.selectedTrack;
  }

  Future<void> loadToggleState() async {
    final preferens = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = preferens.getBool('toggleState') ?? false;
    });
  }

  // Favorite tracks
  void favotireTracks() {
    isFavorite = !isFavorite;
  }

  void toggleButton() {
    setState(() {
      isFavorite = !isFavorite;
    });
    saveToggleState(isFavorite);
  }

  Future<void> saveToggleState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('toggleState', value);
  }

  // Convert duration into min:sec
  String formatTime(Duration duration) {
    String twoDigitSeconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTime;
  }

  // Music
  final MusicApi musikApi = MusicApi();

  @override
  Widget build(BuildContext context) {
    // Player screen
    return Scaffold(
      appBar: AppBar(),
      body: Expanded(
        child: Consumer<PlayListProvider>(
          builder: (context, vulue, child) {
            final favoriteProvider = Provider.of<FavoriteProvider>(context);
            final playlist = vulue.playlist;
            final currentMusic = playlist[vulue.currentSongIndex ?? 0];
            return Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(currentMusic.imageUrl),
                      SizedBox(height: 50),

                      // Name tracks
                      Text(
                        '${currentMusic.title}',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 15),

                      // Name artists
                      Text(
                        '${currentMusic.artist}',
                        style: TextStyle(fontSize: 24),
                      ),

                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Start
                            Text(formatTime(vulue.currentDuration)),

                            // Favorite
                            IconButton(
                              icon: Icon(
                                favoriteProvider.isFavorite(currentMusic)
                                    ? Icons.favorite
                                    : Icons.favorite_border,

                                color: Colors.red,
                              ),
                              onPressed: () async {
                                await NotivicationService.show(
                                  title:
                                      "${currentMusic.title} added to favorites",
                                  body:
                                      'You have added ${currentMusic.title} to your favorites!',
                                );
                                favoriteProvider.toggleFavorite(currentMusic);
                              },
                            ),

                            //End
                            Text(formatTime(vulue.totalDuration)),
                          ],
                        ),
                      ),

                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                        child: Slider(
                          min: 0,
                          max: vulue.totalDuration.inSeconds.toDouble(),
                          value: vulue.currentDuration.inSeconds.toDouble(),
                          activeColor: const Color.fromARGB(255, 230, 93, 2),
                          inactiveColor: const Color.fromARGB(148, 110, 31, 7),
                          onChanged: (double double) {},
                          onChangeEnd: (double double) {
                            vulue.seek(Duration(seconds: double.toInt()));
                          },
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Play Previos track
                            GestureDetector(
                              onTap: vulue.playPreviosSong,
                              child: NeuBox(
                                child: Icon(Icons.skip_previous_rounded),
                              ),
                            ),

                            //Pause or Resume track
                            GestureDetector(
                              onTap: vulue.pauseORResume,
                              child: NeuBox(
                                child: Icon(
                                  vulue.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow_rounded,
                                ),
                              ),
                            ),

                            // Play next track
                            GestureDetector(
                              onTap: vulue.playNextSong,
                              child: NeuBox(
                                child: Icon(Icons.skip_next_rounded),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
