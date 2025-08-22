import 'package:flutter/material.dart';
import 'package:playem/screen/home_music_screen.dart';
import 'package:playem/screen/music_like_list_screen.dart';
import 'package:playem/screen/offline_music_screen.dart';
import 'package:playem/screen/online_music_screen.dart';
import 'package:playem/screen/profile_screen.dart';
import 'package:playem/screen/register_screen.dart';
import 'package:playem/screen/setting_screen.dart';


final Map<String, WidgetBuilder> appRoutes = {
  '/home_music': (context) => HomeMusicScreen(),
  '/settings': (context) => SettingsScreen(),
  '/play_like_list': (context) => MusicLikeListScreen(),
  '/offline': (context) => OfflineMusicScreen(),
  '/online': (context) => OnlineMusicScreen(),
  '/register': (context) => RegisterScreen(),
  '/profile': (context) => ProfileScreen(),
  
};

