import 'package:flutter/material.dart';
import 'price_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.lightBlue,
            scaffoldBackgroundColor: Colors.white),
        home: LoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: Center(
            child: SpinKitCubeGrid(
              color: Colors.red,
              size: 50.0,
            ),
          ),
          overlayOpacity: 0.8,
          child: PriceScreen(),
        ));
  }
}
