import 'package:flutter/material.dart';
import 'package:social_network/app/screens/feed/feed_module.dart';

class AppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: FeedModule(),
      debugShowCheckedModeBanner: false,
    );
  }
}