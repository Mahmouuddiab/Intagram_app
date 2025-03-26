import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:instagram/screens/user.dart';
import 'package:instagram/widgets/custom_text.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {

   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller=TextEditingController();
  Map info={};
  bool isLoading=false;
   Future<void> getInfo(String userName)async{
     setState(() {
       isLoading=true;
     });
    Response response= await http.get(
        Uri.parse("https://social-api4.p.rapidapi.com/v1/info?username_or_id_or_url=$userName"),
        headers: {
          'x-rapidapi-key': '28603075b5mshd7b295685b6e771p10a1d7jsnb994b91bcfe5',
          'x-rapidapi-host': 'social-api4.p.rapidapi.com'
        }
    );

    final json=jsonDecode(response.body) as Map ;
    final result=json['data'] as Map;

    setState(() {
      info=result;
      isLoading=false;
    });

    if(response.statusCode==200){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("success")));
      navigateToUserPage(info);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error")));
    }
  }
  void navigateToUserPage(Map info){
     final route=MaterialPageRoute(builder: (context) => User(info: info),);
     Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Icon(Ionicons.logo_instagram,size: 80,color: Colors.pinkAccent,)),
            SizedBox(height: 40,),
            CustomText(text: "Enter UserName : ",fontSize: 17,fontWeight: FontWeight.bold,),
            SizedBox(height: 40,),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: controller,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: "UserName",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey,width: 2)
                ),
                focusedBorder: OutlineInputBorder(borderSide:
                BorderSide(color: Colors.grey))
              ),
            ),
            SizedBox(height: 40,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                    getInfo(controller.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white
                  ),
                  child: isLoading? CircularProgressIndicator() :CustomText(text:"Enter",color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16,)
              ),
            )
          ],
        ),
      ),
    );
  }
}
