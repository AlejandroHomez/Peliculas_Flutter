import 'package:flutter/material.dart';

import 'package:peliculas_app/models/video_movie_response.dart';
import 'package:peliculas_app/tokens/tokens.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreen createState() => _VideoScreen();
}

class _VideoScreen extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    final Video video = ModalRoute.of(context)!.settings.arguments as Video;

    _controller = YoutubePlayerController(
      initialVideoId: video.key!,
      flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
          useHybridComposition: true
          // controlsVisibleAtStart: true

          ),
    );

    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: YoutubePlayer(
                progressColors: ProgressBarColors(
                  backgroundColor: MyColors.colorIcon,
                  playedColor: Colors.red,
                ),
                progressIndicatorColor: Colors.red,
                controller: _controller,
                actionsPadding: const EdgeInsets.only(left: 16.0),
                bottomActions: [
                  CurrentPosition(),
                  const SizedBox(width: 10.0),
                  ProgressBar(isExpanded: true),
                  const SizedBox(width: 10.0),
                  RemainingDuration(),
                  FullScreenButton(),
                ],
              ),
            ),
            orientation != Orientation.landscape
                ? Positioned(
                    top: 50,
                    left: 0,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.reply_sharp, color: Colors.white70)))
                : Container()
          ],
        ));
  }
}
