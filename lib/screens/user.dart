import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:instagram/screens/reel_page.dart';
import 'package:instagram/widgets/category_info.dart';
import 'package:instagram/widgets/custom_text.dart';
import 'package:instagram/widgets/user_info.dart';
import 'package:http/http.dart' as http;

class User extends StatefulWidget {
   User({super.key,required this.info});
  final Map info;

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> with SingleTickerProviderStateMixin {
  Future<void> getFollowers()async{
    final userName=widget.info['username'];
    Response response= await http.get(
        Uri.parse("https://social-api4.p.rapidapi.com/v1/followers?username_or_id_or_url=$userName"),
        headers: {
          'x-rapidapi-key': '28603075b5mshd7b295685b6e771p10a1d7jsnb994b91bcfe5',
          'x-rapidapi-host': 'social-api4.p.rapidapi.com'
        }
    );

    final json=jsonDecode(response.body) as Map ;
    final result=json['data']['items'] as List;
    setState(() {
      followers=result;
    });

  }
  Future<void> getPosts()async{
    final userName=widget.info['username'];
    Response response= await http.get(
        Uri.parse("https://social-api4.p.rapidapi.com/v1/posts?username_or_id_or_url=$userName"),
        headers: {
          'x-rapidapi-key': '28603075b5mshd7b295685b6e771p10a1d7jsnb994b91bcfe5',
          'x-rapidapi-host': 'social-api4.p.rapidapi.com'
        }
    );

    final json=jsonDecode(response.body) as Map ;
    final result=json['data']['items'] as List;
    setState(() {
      posts=result;
    });

  }
  Future<void> getReels()async{
    final userName=widget.info['username'];
    Response response= await http.get(
        Uri.parse("https://social-api4.p.rapidapi.com/v1/reels?username_or_id_or_url=$userName"),
        headers: {
          'x-rapidapi-key': '28603075b5mshd7b295685b6e771p10a1d7jsnb994b91bcfe5',
          'x-rapidapi-host': 'social-api4.p.rapidapi.com'
        }
    );

    final json=jsonDecode(response.body) as Map ;
    print("json is : $json");
    final result=json['data']['items'] as List;
    print("result is : $result");
    setState(() {
      reels=result;
    });

  }
  late TabController tabController;
  List img=[
    "https://picsum.photos/200/300",
    "https://picsum.photos/200/300",
    "https://picsum.photos/200/300"
  ];
  List followers=[];
  List posts=[];
  List reels=[];
  @override
  void initState() {
    tabController =  TabController(length: 3, vsync: this);
    super.initState();
    getFollowers();
    getPosts();
    getReels();
  }
  @override
  Widget build(BuildContext context) {
    final info=widget.info;
    final category=info['category'];
    final userName=info['username'];
    final profilePic=info['profile_pic_url_hd'];
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 15,
        title: CustomText(text: userName,fontWeight:FontWeight.bold,),
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 4,),
          Icon(Icons.more_horiz),
          SizedBox(width: 4,)
        ],
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 5,),
                UserInfo(
                  userImg:profilePic,
                  followersNmuber: followers.length.toString(),
                ),
                CategoryInfo(
                  category: category,
                  img: [
                    "https://picsum.photos/200/300",
                    "https://picsum.photos/200/300",
                    "https://picsum.photos/200/300"
                  ],
                ),

              ],
            ),
          ),
          SizedBox(height: 5,),
          TabBar(
            labelPadding: EdgeInsets.all(5),
            padding: EdgeInsets.all(3),
            indicator: BoxDecoration(
              shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(15),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              indicatorWeight: 1.0,
              tabs: [
            Icon(Icons.grid_view_outlined),
            Icon(Icons.video_library),
            Icon(Icons.person)
          ]
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
                children: [
                  GridView.builder(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount
                      (
                        crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 1.1/2,
                    ),
                    itemBuilder:(context, index) {
                      final post=posts[index];
                      return  Image.network(post['thumbnail_url'],fit: BoxFit.cover,) ;
                    } ,
                    itemCount: posts.length,
                  ),
                  GridView.builder(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount
                      (
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 1.1/2,
                    ),
                    itemBuilder:(context, index) {
                      final reel=reels[index];
                      return  InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder:(context) => ReelPage(videoLink: reel['video_url'],info: info,),
                              ));
                        },
                          child: Image.network(reel['thumbnail_url'],fit: BoxFit.cover,)
                      );
                    } ,
                    itemCount: reels.length,
                  ),
                  Icon(Icons.person)
                ]
            ),
          )
        ],
      ),

    );
  }
}
