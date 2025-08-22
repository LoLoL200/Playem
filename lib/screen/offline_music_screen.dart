import 'package:flutter/material.dart';

class OfflineMusicScreen extends StatelessWidget {
  const OfflineMusicScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(),
      body: Center(

        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Text(
            'Soon.........', 
            style: TextStyle(
              fontSize: 64
            )
            )
            ],
          ),
        ),
      ),
    );
    
  }
}