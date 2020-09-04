import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieDemo extends StatefulWidget {
  ChewieDemo({this.title = 'Chewie Demo'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _videoPlayerController2 = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/480/asdasdas.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,

      /* Try playing around with some of these other options:
       showControls: false,
       materialProgressColors: ChewieProgressColors(
         playedColor: Colors.red,
         handleColor: Colors.blue,
         backgroundColor: Colors.grey,
         bufferedColor: Colors.lightGreen,
       ),
       placeholder: Container(
         color: Colors.grey,
       ),
       autoInitialize: true,*/
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData.light().copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    color: Colors.blueGrey,
                    onPressed: () {
                      setState(() {
                        _chewieController.dispose();
                        _videoPlayerController2.pause();
                        _videoPlayerController2.seekTo(Duration(seconds: 0));
                        _chewieController = ChewieController(
                          videoPlayerController: _videoPlayerController1,
                          aspectRatio: 3 / 2,
                          autoPlay: true,
                          looping: true,
                        );
                      });
                    },
                    child: Padding(
                      child: Text(
                        "Play Video",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    color: Colors.blueGrey[500],
                    onPressed: () {
                      setState(() {
                        _chewieController.dispose();
                        _videoPlayerController1.pause();
                        _videoPlayerController1.seekTo(Duration(seconds: 0));
                        _chewieController = ChewieController(
                          videoPlayerController: _videoPlayerController2,
                          aspectRatio: 3 / 2,
                          autoPlay: true,
                          looping: true,
                        );
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Error Video",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  color: Colors.blue[500],
                  onPressed: () {
                    _chewieController.enterFullScreen();
                  },
                  child: Icon(
                    Icons.crop_free,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    color: Colors.blue[600],
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.android;
                      });
                    },
                    child: Padding(
                      child: Text(
                        "Android controls",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    color: Colors.blue[700],
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.iOS;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "iOS controls",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
