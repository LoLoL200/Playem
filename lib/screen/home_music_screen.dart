import 'package:flutter/material.dart';
import 'package:playem/screen/music_like_list_screen.dart';
import 'package:playem/screen/offline_music_screen.dart';
import 'package:playem/screen/online_music_screen.dart';
import 'package:playem/screen/profile_screen.dart';
import 'package:playem/utils/service/auth_service.dart';

class HomeMusicScreen extends StatefulWidget {
  const HomeMusicScreen({super.key});
  @override
  State<HomeMusicScreen> createState() => _HomeMusicScreen();
}

class _HomeMusicScreen extends State<HomeMusicScreen> {
  int _index = 0;
  final ProfileScreen profile = ProfileScreen();

  // List Widget
  final List<Widget> _screen = [
    OnlineMusicScreen(),
    OfflineMusicScreen(),
    MusicLikeListScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  // SingOut  account
  Future<void> _singOut() async {
    await AuthService.singOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      // Drewer menu
      drawer: Drawer(
        backgroundColor: Colors.deepOrange,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(),

              // Menu
              child:
               Column(
                children: [
                  
                  Text(
                'Menu ',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
                ],
               )
               
            ),

            // Profile
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/profile');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: const Color.fromARGB(255, 37, 0, 250),
                      ),
                      SizedBox(width: 10),
                      Text('Profle', style: TextStyle()),
                    ],
                  ),
                ),

                // Settings
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: Colors.blueGrey),
                      SizedBox(width: 10),
                      Text('Settings', style: TextStyle()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      // Home screen
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/musik_0.jpg',
          fit: BoxFit.cover,
        ),
        iconTheme: IconThemeData(),
        title: Text('Playmuz'),
        backgroundColor: const Color.fromARGB(255, 199, 74, 2),
      ),
      body: Center(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => setState(() => _index = 0),
                    child: Text('Online music'),
                  ),
                  SizedBox(width: 24),
                  TextButton(
                    onPressed: () => setState(() => _index = 1),
                    child: Text('My music (offline)'),
                  ),
                  SizedBox(width: 24),
                  TextButton(
                    onPressed: () => setState(() => _index = 2),
                    child: Text('Like music list'),
                  ),
                ],
              ),
            ),
            Expanded(child: _screen[_index]),
          ],
        ),
      ),
    );
  }
}
