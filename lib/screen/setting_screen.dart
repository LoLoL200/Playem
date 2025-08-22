import 'package:flutter/material.dart';
import 'package:playem/utils/themes/theme_provider.dart';
import 'package:provider/provider.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: Column(
          children: [
            // Button change of topic
            Container(
              margin: EdgeInsets.only(top: 100),
              width: 210,
              height: 60,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                children: [
                  Text(
                    'Change of topic',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Switch(
                    value: Provider.of<ThemeProvider>(
                      context,

                    ).isDarkMode,
                    onChanged: (value) {
                      Provider.of<ThemeProvider>(
                        context,
                        listen: false,
                      ).toggleTheme();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // //Button for redact profile
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.deepOrange,
            //   ),
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/redact_screen');
            //   },
            //   child: Text(
            //     'Redact profile',
            //     style: TextStyle(color: Colors.black87),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
