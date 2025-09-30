import 'package:flutter/material.dart';
import 'package:playem/screen/player_music_screen.dart';
import 'package:playem/utils/media.dart';
import 'package:playem/utils/player_provider.dart';
import 'package:playem/utils/service/music_api.dart';
import 'package:provider/provider.dart';

class OnlineMusicScreen extends StatefulWidget {
  const OnlineMusicScreen({super.key});

  @override
  State<OnlineMusicScreen> createState() => _OnlineMusicScreen();
}

class _OnlineMusicScreen extends State<OnlineMusicScreen> {
  // Late Play List Provider
  late final dynamic playListProvider;

  // Music API
  final MusicApi musikApi = MusicApi();

  // Player provider
  final PlayListProvider playProvider = PlayListProvider();

  //Search controller
  final SearchController controller = SearchController();

   List<Media> allMedia = [];
   List<Media> filteredMedia = [];

  // initState
  @override
  void initState() {
    super.initState();
    playListProvider = Provider.of<PlayListProvider>(context, listen: false);
    loadMedia();

   
  }



  

  Future<void> loadMedia() async {
    allMedia = await musikApi.fetchTrendingMedia('myAppName');
    filteredMedia = allMedia;
    setState(() {});
  }

  // Search music
  // void searchMusic(String query) async {
  //   if (query.isNotEmpty) {
  //     filteredMedia = allMedia
  //         .where(
  //           (media) => media.title.toLowerCase().contains(query.toLowerCase()),
  //         )
  //         .toList();
  //   } else {
  //     filteredMedia = allMedia;
  //   }
  //   setState(() {});
  // }

  // Go to Media
  void goToMedia(List<Media> mediaList, int mediaIndex) {
    // Set the entire playlist
    playListProvider.setPlaylist(mediaList);

    // Setting the index
    playListProvider.currentSongIndex = mediaIndex;

    // SELECTED TRACK
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
    return Scaffold(
      body: Column(
        children: [
          SearchAnchor.bar(
            isFullScreen: false,
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              final input = controller.value.text;
              
              final results = filteredMedia
                  .where(
                    (media) =>
                        media.title.toLowerCase().contains(input.toLowerCase()),
                  )
                  .toList();
              if(controller.value.text.isEmpty){
                return [Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Nothing found')
                  )]; 
              }
              else{
                return results.map((media) {
                return ListTile(
                  title: Text(media.title),
                  subtitle: Text(media.artist),
                  leading: Image.network(media.imageUrl, width: 40, height: 40),
                  onTap: () {
                    controller.closeView(media.title);
                    goToMedia(filteredMedia, filteredMedia.indexOf(media));
                  },
                );
              }).toList();
              }
              
            },
          ),

          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<Media>>(
              future: musikApi.fetchTrendingMedia('myAppName'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Loading wheel
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [CircularProgressIndicator()],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final mediaList = snapshot.data!;
                  return ListView.builder(
                    itemCount: mediaList.length,
                    itemBuilder: (context, index) {
                      final media = mediaList[index];
                      return ListTile(
                        title: Text(media.title),
                        subtitle: Text(media.artist),
                        leading: Image.network(media.imageUrl),
                        onTap: () {
                          goToMedia(mediaList, index);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
