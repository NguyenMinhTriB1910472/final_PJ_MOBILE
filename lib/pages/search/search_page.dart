import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grab_app_clone_2/ultis/colors.dart';
import '../../ultis/colors.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        title: Container(
          decoration:BoxDecoration(color: Colors.white,
          borderRadius:BorderRadius.circular(30)),
          child: TextField(
          controller: _textEditingController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(30),
            hintText: 'Search'
          ),
      ),
        ),

      ),
      body: ListView.builder(itemBuilder: (context,index){
        return Row(children: [
          CircleAvatar(
            //child: ,
          )
        ],);
      }),
    );
  }
}
