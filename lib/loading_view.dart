import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          height: 150,
          width: 150,
          image: AssetImage ('assets/gifgravetat.gif'),),
        // CircularProgressIndicator(
        //   color: Colors.orangeAccent,
        // ),
      ),
    );
  }
}
