import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({super.key, required this.child});
 

 @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(16),
        boxShadow:[ BoxShadow(
          blurRadius: 6,
          blurStyle: BlurStyle.solid,
         // offset: Offset(1,1),
          color: Colors.deepOrange
        )]
      ),
      child: child,
    );
  }
}