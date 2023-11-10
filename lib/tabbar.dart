import 'package:flutter/material.dart';
import 'package:media_booster/video_player.dart';

import 'audio.dart';

class tabbarscreen extends StatefulWidget {
  const tabbarscreen({super.key});

  @override
  State<tabbarscreen> createState() => _tabbarscreenState();
}

class _tabbarscreenState extends State<tabbarscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(''),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Video Player'),
                Tab(text: 'Audio Player'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Tab 1 content
              Center(
                child: VideoApp(),
              ),
              // Tab 2 content
              Center(
                child: audioScreen(),
              ),
            ],
          ),
          bottomNavigationBar: DefaultTabController(
            length: 2, // Number of tabs
            child: TabBar(
              tabs: [
                Tab(text: 'Video Player',),
                Tab(text: 'Audio Player'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
