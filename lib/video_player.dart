import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  @override
  State<VideoApp> createState() => _VideoAppState();
}

class VideoItem {
  final String videoUrl;
  VideoItem(this.videoUrl);
}

class _VideoAppState extends State<VideoApp> {
  final List<String> videos = [
    'assets/Zihaal_e_Miskin__Video__Javed-Mohsin___Vishal_Mishra,_Shreya_Ghoshal___Rohit_Z,_Nimrit_A___Kunaal_V(144p).mp4',
    'assets/Haseena___Kayden_Sharma___MTV_Hustle_03_REPRESENT(144p).mp4',
    'assets/Heeriye__Official_Video__Jasleen_Royal_ft_Arijit_Singh__Dulquer_Salmaan__Aditya_Sharma__Taani_Tanvir(144p).mp4',
    // Add more video URLs as needed
  ];
  List<VideoPlayerController> ControllerList = [
    VideoPlayerController.asset(
        'assets/Zihaal_e_Miskin__Video__Javed-Mohsin___Vishal_Mishra,_Shreya_Ghoshal___Rohit_Z,_Nimrit_A___Kunaal_V(144p).mp4'),
    VideoPlayerController.asset(
        'assets/Haseena___Kayden_Sharma___MTV_Hustle_03_REPRESENT(144p).mp4'),
    VideoPlayerController.asset(
        'assets/Heeriye__Official_Video__Jasleen_Royal_ft_Arijit_Singh__Dulquer_Salmaan__Aditya_Sharma__Taani_Tanvir(144p).mp4'),
  ];
  CarouselController Controller = CarouselController();
  double _sliderValue = 0.0; // To store the current slider value
  void initState() {
    super.initState();
    for (int i = 0; i < videos.length; i++) {
      ControllerList[i] = VideoPlayerController.asset(videos[i])
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            height: double.infinity,
            child: CarouselSlider(
              carouselController: Controller,
              items: [
                for (int i = 0; i < videos.length; i++) ...[
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ControllerList[i].value.isInitialized
                            ? AspectRatio(
                                aspectRatio:
                                    ControllerList[i].value.aspectRatio,
                                child: VideoPlayer(ControllerList[i]),
                              )
                            : CircularProgressIndicator(),
                        Slider(
                          value: _sliderValue,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (double value) {
                            setState(() {
                              _sliderValue = value;
                              final newTime =
                                  ControllerList[i].value.duration * value;
                              ControllerList[i].seekTo(newTime);
                            });
                          },
                        ),
                        Text(
                          '${(ControllerList[i].value.position).toString().split('.').first} / ${(ControllerList[i].value.duration).toString().split('.').first}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.fast_rewind, color: Colors.white, size: 30),
                                onPressed: () {
                                  setState(() {
                                    final currentPosition = ControllerList[i].value.position;
                                    final newPosition = currentPosition - Duration(seconds: 10);
                                    if (newPosition.isNegative) {
                                      ControllerList[i].seekTo(Duration(seconds: 0));
                                    } else {
                                      ControllerList[i].seekTo(newPosition);
                                    }
                                  });
                                },
                              ),

                              IconButton(
                                icon: Icon(
                                  ControllerList[i].value.isPlaying
                                      ? Icons.play_arrow
                                      : Icons.pause,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    ControllerList[i].value.isPlaying
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
                                    final currentPosition =
                                        ControllerList[i].value.position;
                                    final newPosition =
                                        currentPosition + Duration(seconds: 10);
                                    if (newPosition >
                                        ControllerList[i].value.duration) {
                                      // Ensure the new position doesn't go beyond the end of the video.
                                      ControllerList[i].seekTo(
                                          ControllerList[i].value.duration);
                                    } else {
                                      ControllerList[i].seekTo(newPosition);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ],
              options: CarouselOptions(
                height: 300, // Height of the carousel container
                aspectRatio: 19 / 2, // Aspect ratio of individual carousel items
                viewportFraction: 0.8, // Fraction of the viewport to show (from 0.0 to 1.0)
                initialPage: 0, // Index of the first page to show
                enableInfiniteScroll: false, // Allows infinite scrolling in both directions
                reverse: false, // Set to true to reverse the carousel's direction
                // autoPlay: true, // Set to true to enable auto play
                // autoPlayInterval: Duration(seconds: 3), // Auto play interval in seconds
                autoPlayAnimationDuration:
                    Duration(milliseconds: 800), // Auto play animation duration
                autoPlayCurve:
                    Curves.fastOutSlowIn, // Animation curve for auto play
                enlargeCenterPage: true,
                // Set to true to enlarge the center item
                onPageChanged: (index, reason) {
                  return videos;
                  // Callback function when the page changes
                },
                scrollDirection: Axis
                    .horizontal, // Scroll direction (horizontal or vertical)
              ),
            ),
          )),
    );
  }
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
}
