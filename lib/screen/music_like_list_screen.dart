import 'package:flutter/material.dart';
import 'package:playem/screen/player_music_screen.dart';
import 'package:playem/utils/favorite_provider.dart';
import 'package:playem/utils/media.dart';
import 'package:playem/utils/player_provider.dart';
import 'package:provider/provider.dart';

class MusicLikeListScreen extends StatefulWidget {
  const MusicLikeListScreen({super.key});

  @override
  State<MusicLikeListScreen> createState() => _MusicListScreen();
}

class _MusicListScreen extends State<MusicLikeListScreen> {
  //Go To Media
  void goToMedia(List<Media> mediaList, int mediaIndex) {
    final playListProvider = Provider.of<PlayListProvider>(
      context,
      listen: false,
    );
    playListProvider.setPlaylist(mediaList);
    playListProvider.currentSongIndex = mediaIndex;
    final selectedTrack = mediaList[mediaIndex];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerMusicScreen(selectedTrack: selectedTrack),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Favotite provider
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favoriteTracks = favoriteProvider.favoriteTracks;

    return Scaffold(
      body: favoriteTracks.isEmpty
          ? const Center(child: Text('Not Like tracks'))
          : Expanded(
              child: ListView.builder(
                itemCount: favoriteTracks.length,
                itemBuilder: (context, index) {
                  final track = favoriteTracks[index];
                  return ListTile(
                    onTap: () {
                      goToMedia(favoriteTracks, index);
                    },
                    leading: Image.network(
                      track.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.music_note),
                    ),
                    title: Text(track.title),
                    subtitle: Text(track.artist),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite),
                      color: Colors.red,
                      onPressed: () {
                        favoriteProvider.toggleFavorite(track);
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
