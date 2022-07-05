import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          height: MediaQuery.of(context).size.height* 0.2017,
          width: MediaQuery.of(context).size.width* 0.4167,
          image: AssetImage ('assets/gifgravetat.gif'),),
        // CircularProgressIndicator(
        //   color: Colors.orangeAccent,
        // ),
      ),
    );
  }
}
