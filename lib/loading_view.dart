import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: Center(
        child: Image(
          height: MediaQuery.of(context).size.height * 0.2017,
          width: MediaQuery.of(context).size.width * 0.4167,
          image: const AssetImage('assets/gifgravetat.gif'),
        ),
      ),
    );
  }
}
