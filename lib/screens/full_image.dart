import 'package:flutter/material.dart';

class FullImageScreen extends StatelessWidget {
  final String image;
  const FullImageScreen({Key? key,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: Image.network(image, fit: BoxFit.contain,),
        ),
      ),
    );
  }
}
