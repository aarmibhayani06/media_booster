import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class audioScreen extends StatefulWidget {
  var player;

  @override
  State<audioScreen> createState() => _audioScreenState();
}

class _audioScreenState extends State<audioScreen> {
  CarouselController Controller = CarouselController();
  double _sliderValue = 0.0;
  bool Play = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = true;

  void initState() {
    for (int i = 0; i < Songs.length; i++) {
      ControllerList[i].open(Audio(Songs[i]));
    }
    super.initState();
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
  }

  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  List<AssetsAudioPlayer> ControllerList = [
    AssetsAudioPlayer(),
    AssetsAudioPlayer(),
    AssetsAudioPlayer(),
    AssetsAudioPlayer(),
    AssetsAudioPlayer(),
  ];
  List<String> Songs = [
    'assets/AudioSongs/Chaleya.mp3',
    'assets/AudioSongs/Jumkha.mp3'
        'assets/AudioSongs/Rashke.mp3'
        'assets/AudioSongs/Tummile.mp3'
        'assets/AudioSongs/Vhalam.mp3'
  ];

  final List<String> imagePaths = [
    'assets/image1.png',
    'assets/image2.png',
    'assets/image3.png',
    'assets/image4.png',
    'assets/image5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            height: 200,
            child: Image.network('https://c.saavncdn.com/026/Chaleya-From-Jawan-Hindi-2023-20230814014337-500x500.jpg'),
          ),
          CarouselSlider(
            carouselController: Controller,
            items: [
              for (int i = 0; i < Songs.length; i++) ...[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(),
                      Slider(
                        value: _sliderValue,
                        min: 0.0,
                        max: 1.0,
                        onChanged: (double value) {
                          setState(() {
                            _sliderValue = value;
                            final currentPosition = ControllerList[i].currentPosition.valueOrNull ?? Duration.zero;
                            final totalDuration = ControllerList[i].current.value?.audio?.duration ?? Duration.zero;

                            if (totalDuration != null) {
                              final newTime = totalDuration * value;
                              ControllerList[i].seek(newTime);
                            }
                          });
                        },
                      ),
                      Text(
                        '${(ControllerList[i].currentPosition.hasValue ? ControllerList[i].currentPosition.value : Duration.zero).toString().split('.').first ?? '0:00'} / '
                        '${(ControllerList[i].current.hasValue ? ControllerList[i].current.value?.audio?.duration : Duration.zero).toString().split('.').first ?? '0:00'}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.fast_rewind,
                                    color: Colors.white, size: 30),
                                onPressed: () {
                                  setState(() {
                                    final currentPosition = ControllerList[i]
                                            .currentPosition
                                            .valueOrNull ??
                                        Duration.zero;
                                    final newPosition =
                                        currentPosition - Duration(seconds: 10);
                                    if (newPosition.isNegative) {
                                      ControllerList[i]
                                          .seek(Duration(seconds: 0));
                                    } else {
                                      ControllerList[i].seek(newPosition);
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Play ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    Play = !Play;
                                    Play
                                        ? ControllerList[i].pause()
                                        : ControllerList[i].play();
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.fast_forward,
                                    color: Colors.white, size: 30),
                                onPressed: () {
                                  setState(() {
                                    final currentPosition = ControllerList[i]
                                            .currentPosition
                                            .valueOrNull ??
                                        Duration.zero;
                                    final newPosition =
                                        currentPosition + Duration(seconds: 10);

                                    final totalDuration = ControllerList[i]
                                        .current
                                        .value
                                        ?.audio
                                        ?.duration;

                                    if (totalDuration != null) {
                                      if (newPosition > totalDuration) {
                                        // Ensure the new position doesn't go beyond the end of the audio.
                                        ControllerList[i].seek(totalDuration);
                                      } else {
                                        ControllerList[i].seek(newPosition);
                                      }
                                    }
                                  });
                                },
                              )
                            ]),
                      ),
                    ],
                  ),
                )
              ],
            ],
            options: CarouselOptions(
              height: 300,
              // Height of the carousel container
              aspectRatio: 19 / 2,
              // Aspect ratio of individual carousel items
              viewportFraction: 0.8,
              // Fraction of the viewport to show (from 0.0 to 1.0)
              initialPage: 0,
              // Index of the first page to show
              enableInfiniteScroll: false,
              // Allows infinite scrolling in both directions
              reverse: false,
              // Set to true to reverse the carousel's direction
              // autoPlay: true, // Set to true to enable auto play
              // autoPlayInterval: Duration(seconds: 3), // Auto play interval in seconds
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              // Auto play animation duration
              autoPlayCurve: Curves.fastOutSlowIn,
              // Animation curve for auto play
              enlargeCenterPage: true,
              // Set to true to enlarge the center item
              onPageChanged: (index, reason) {
                return Songs;
                // Callback function when the page changes
              },
              scrollDirection:
                  Axis.horizontal, // Scroll direction (horizontal or vertical)
            ),
          ),
        ],
      ),
    );
  }
}
