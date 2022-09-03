import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/Model.dart';
import 'package:musicplayer/Songplaypage.dart';

class Allsonglist extends StatefulWidget {
  const Allsonglist({Key? key}) : super(key: key);

  @override
  State<Allsonglist> createState() => _AllsonglistState();
}

class _AllsonglistState extends State<Allsonglist> {
  AudioPlayer player = AudioPlayer();
  List<bool> statuslist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    statuslist = List.filled(Model.song.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Allsonglist")),
      body: ListView.builder(
        itemCount: Model.song.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Songplaypage(index);
              },));
            },
            trailing: statuslist[index]
                ? IconButton(onPressed: () async {

              setState(() {
                statuslist = List.filled(Model.song.length, false);
              });

              await player.stop();

            }, icon: Icon(Icons.pause))
                : IconButton(
                    onPressed: () async {
                      await player.stop();

                      setState(() {
                        statuslist = List.filled(Model.song.length, false);
                        statuslist[index] = true;
                      });
                      await player
                          .play(DeviceFileSource(Model.song[index].data));
                    },
                    icon: Icon(Icons.play_arrow)),
            title: Text("${Model.song[index].displayNameWOExt}"),
            subtitle: Text("${Model.song[index].duration}"),
          );
        },
      ),
    );
  }
}
