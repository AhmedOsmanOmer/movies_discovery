import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/screen_size.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = ScreenSize(context: context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.signal_cellular_connected_no_internet_4_bar_rounded,
            size: screen.getHeight() * 0.3,
            color: Colors.red,
          ),
          const Text(
            'No Internet Connection',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'You are not connected to the internet. Make sure Wi-Fi or cellular network is on.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
