import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messangerApp/helper/constants.dart';
import 'package:messangerApp/services/database.dart';
import 'package:messangerApp/views/conversation_screen.dart';
import 'package:messangerApp/widgets/widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

String _myName;

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTED =
      new TextEditingController(); // Search Text Editing Controller
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  QuerySnapshot searchSnapShot;

  initiateSearch() {
    dataBaseMethods.getUserByUsername(searchTED.text).then((val) {
      setState(() {
        searchSnapShot = val;
      });
    });
  }

  Widget searchList() {
    return searchSnapShot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapShot.documents.length,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchSnapShot.documents[index].data["name"],
                userEmail: searchSnapShot.documents[index].data["email"],
              );
            })
        : Container();
  }

  createChatRoomAndStartChatting(
      {String username, QuerySnapshot searchSnapshot}) {
    String chatRoomID = getChatRoomId(username, Constants.myName);
    List<String> users = [Constants.myName, username];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomID": chatRoomID
    };
    DataBaseMethods().createChatRoom(chatRoomID, chatRoomMap);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConversationScreen(chatRoomID)
        )
    );
  }

  // ignore: non_constant_identifier_names
  Widget SearchTile({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: mediumTextStyle(),
              ),
              Text(
                userEmail,
                style: mediumTextStyle(),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndStartChatting(username: userName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              child: Text(
                "Go",
                style: mediumTextStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: searchTED,
                      decoration: InputDecoration(
                          hintText: "Search Username ...",
                          hintStyle: TextStyle(
                            color: Colors.white24,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(colors: [
                            Colors.white24,
                            Colors.black12,
                          ])),
                      child: Image.asset(
                        "assets/images/search_white.png",
                        height: 25,
                        width: 25,
                      ),
                      padding: EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  return a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)
      ? "$b\_$a"
      : "$a\_$b";
}
