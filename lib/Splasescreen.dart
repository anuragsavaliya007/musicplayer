import 'package:flutter/material.dart';
import 'package:musicplayer/Allsonglist.dart';
import 'package:musicplayer/Model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Splasescreen extends StatefulWidget {
  const Splasescreen({Key? key}) : super(key: key);

  @override
  State<Splasescreen> createState() => _SplasescreenState();
}

class _SplasescreenState extends State<Splasescreen> {

   OnAudioQuery _audioQuery = OnAudioQuery();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllmusic();
  }

  loadAllmusic() async {

    var status = await Permission.storage.status;
    if (status.isDenied) {
      await [Permission.storage].request();
    }

    Model.song = await _audioQuery.querySongs();
    print(Model.song);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Allsonglist();
    },));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Myimage/Onboarding.png"),
                  fit: BoxFit.fill)),
        child: Center(child: CircularProgressIndicator(color: Colors.white,)),
      ),

    );
  }
}
