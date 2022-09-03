import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/Model.dart';


class Songplaypage extends StatefulWidget {

  int index;

  Songplaypage(this.index);



  @override
  State<Songplaypage> createState() => _SongplaypageState();
}

class _SongplaypageState extends State<Songplaypage> {
  AudioPlayer audioplayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    setaudio();
    super.initState();
    audioplayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    },);

    audioplayer.onDurationChanged.listen((newduration) {

      setState(() {
        duration = newduration;
      });

    },);

    audioplayer.onPositionChanged.listen((newposition) {

      setState(() {
        position = newposition;
      });

    });



  }

  Future setaudio(){
    audioplayer.setReleaseMode(ReleaseMode.loop);
    return Future.value();
  }
  @override
  void dispose() {
    audioplayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                  'https://media.istockphoto.com/vectors/love-music-neon-sign-vector-id1090431366?k=20&m=1090431366&s=612x612&w=0&h=b904gY5gkqF3iL5REIcJXK--GQmOZyNfyUGtlvssMpc=',
                  width: double.infinity,
                  height: 350.0,
                  fit: BoxFit.cover),
            ),
            SizedBox(
              height: 32,
            ),
            Text("..The Flutter Song",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 4,
            ),
            Text("Music", style: TextStyle(fontSize: 20)),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {

                final position = Duration(seconds: value.toInt());
                await audioplayer.seek(position);

                await audioplayer.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration - position)),
                ],
              ),
            ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                onPressed: () async {
                  if(isPlaying){
                    await audioplayer.pause();
                  }else{

                    await audioplayer.pause();
                    await audioplayer.play(DeviceFileSource(Model.song[widget.index].data));
                  }
                },
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
