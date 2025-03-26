import 'package:flutter/material.dart';
import 'package:instagram/widgets/custom_text.dart';
import 'package:video_player/video_player.dart';

class ReelPage extends StatefulWidget {
  String videoLink;
  final Map info;

   ReelPage({super.key,required this.videoLink,required this.info});

  @override
  State<ReelPage> createState() => _ReelPageState();
}

class _ReelPageState extends State<ReelPage> {
  late VideoPlayerController _controller;
  @override
  void initState(){
    _controller=VideoPlayerController.networkUrl(
      Uri.parse(widget.videoLink),
    )..initialize().then((v){
      setState(() {
        _controller.play();
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  void toggleVideo(){
    setState(() {
      if(_controller.value.isPlaying){
        _controller.pause();
      }
      else{
        _controller.play();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final info=widget.info;
    final userName=info['username'];
    final profilePic=info['profile_pic_url_hd'];
    return Scaffold(
      appBar: AppBar(),
      body: _controller.value.isInitialized?
          InkWell(
            onTap: toggleVideo,
              child: Expanded(
                  child: Stack(
                    children: [
                      VideoPlayer(_controller),
                      Positioned(
                        bottom: 25,
                          left: 15,
                          child: Row(
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage(profilePic),),
                              SizedBox(width: 15,),
                              CustomText(text: userName,fontWeight: FontWeight.bold,)
                            ],
                          )
                      ),
                      Positioned(
                          top: 270,
                          right: 15,
                          child: Column(
                            children: [
                              Icon(Icons.favorite_border,color: Colors.grey,size: 45,),
                              SizedBox(height: 10,),
                              CustomText(text: "300k",fontWeight: FontWeight.bold,)
                            ],
                          )
                      ),
                      Positioned(
                          top: 370,
                          right: 15,
                          child: Column(
                            children: [
                              Icon(Icons.comment,color: Colors.white,size: 40,),
                              SizedBox(height: 10,),
                              CustomText(text: "3k",fontWeight: FontWeight.bold,)
                            ],
                          )
                      ),
                      Positioned(
                          top: 460,
                          right: 15,
                          child: Column(
                            children:  [Icon(Icons.more_horiz,color: Colors.white,size: 40,),

                            ],
                          )
                      )
                    ],
                  )
              )
          ):
          const Center(child: CircularProgressIndicator())
    );
  }
}
