import 'package:flutter/material.dart';
import 'package:playem/screen/music_like_list_screen.dart';
import 'package:playem/screen/offline_music_screen.dart';
import 'package:playem/screen/online_music_screen.dart';
import 'package:playem/screen/profile_screen.dart';
import 'package:playem/utils/service/auth_service.dart';
import 'package:playem/utils/themes/theme_provider.dart';
import 'package:provider/provider.dart';

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
              decoration: BoxDecoration(color: Colors.red),

              // Menu
              child:
              Center(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  Text(
                'Menu ',
                style: Provider.of<ThemeProvider>(context).appBarStyle,
              ),
                ],
               )
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
                      Text('Profle', style: Provider.of<ThemeProvider>(context).style),
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
                      Text('Settings',style: Provider.of<ThemeProvider>(context).style),
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
       // iconTheme: IconThemeData(),
        title: Text('Playmuz',style: Provider.of<ThemeProvider>(context).appBarStyle  ,),
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
                    child: Text('Online music' ,style: Provider.of<ThemeProvider>(context).style,),
                  ),
                  SizedBox(width: 24),
                  TextButton(
                    onPressed: () => setState(() => _index = 1),
                    child: Text('My music (offline)' ,style: Provider.of<ThemeProvider>(context).style),
                  ),
                  SizedBox(width: 24),
                  TextButton(
                    onPressed: () => setState(() => _index = 2),
                    child: Text('Like music list' ,style: Provider.of<ThemeProvider>(context).style),
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
