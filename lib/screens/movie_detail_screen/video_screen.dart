import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tmdbassignment/consts/consts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosScreen extends StatefulWidget {
  final String title;
  final String videoKey;

  const VideosScreen({Key? key, required this.title, required this.videoKey}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {

  late YoutubePlayerController youtubePlayerController;

  // void checkVideo(){
  //   Duration durationOfVideo = youtubePlayerController.value.duration;
  //
  //   // Implement your calls inside these conditions' bodies :
  //   if(youtubePlayerController.value.position == const Duration(seconds: 0, minutes: 0, hours: 0)) {
  //     print('video Started');
  //   }
  //
  //   if(youtubePlayerController.value.position == youtubePlayerController.) {
  //     print('video Ended');
  //   }
  //
  // }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose(); // Have tried to use super.dispose below the close() also

  }

  @override
  void initState() {
    youtubePlayerController = YoutubePlayerController(
        initialVideoId: widget.videoKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        showLiveFullscreenButton: true,

      )
    );
    youtubePlayerController.toggleFullScreenMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          YoutubePlayer(
            controller: youtubePlayerController,
            showVideoProgressIndicator: true,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
              ),
              const PlaybackSpeedButton(),
              FullScreenButton(),
            ],
            onEnded: (data){
              Get.back();
            },

          ),
          Positioned(
            top: 40,
              right: 20,
              child: SizedBox(
                width: 50,
                height: 30,
                child: 'Done'.text.color(white).fontWeight(FontWeight.w500).makeCentered(),
              ).box.color(blueLight).roundedSM.make().onTap(() {
                // youtubePlayerController.dispose();
                Get.back();
              })
          )
        ],
      ),
    );
  }
}
