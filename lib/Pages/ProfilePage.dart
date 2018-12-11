import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pooyan/Model/ProfileModel.dart';
import 'package:pooyan/Pages/AvatarPage.dart';
import 'package:pooyan/Tools/MyColors.dart';
import 'package:pooyan/Widgets/Help.dart';
import 'package:pooyan/Widgets/ProfileButtonsWidget.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  ProfileModel profileModel; //= new ProfileModel();

  @override
  void initState() {
    super.initState();
    getProfileData(context).then((profile) {
      setState(() {
        profileModel = profile;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget image = Text("");
    if (profileModel?.avatar?.image != null)
      image = Image.network(profileModel?.avatar?.image);

    //return ProfileButtons();
    return new  Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Help(helpPageName: helpPages.profilePage,)));
          },
          child: Text("راهنما"),
          mini: true,
        ),
        backgroundColor: MyColors.firstBackground,body: Column(children: <Widget>[
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: CircleAvatar(
                    child: image,
                    maxRadius: 80.0,
                  )),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                onPressed: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AvatarPage()))
                      .then((x) {
                    getProfileData(context).then((profile) {
                      setState(() {
                        profileModel = profile;
                      });
                    });
                  });
                },
                child: Text("تعویض نماد"),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("نام: " + (profileModel?.firstName ?? "..."), maxLines: 2),
              Text("نام خانوادگی: " + (profileModel?.lastName ?? "..."),
                  maxLines: 2),
              Text("شماره تلفن: " + (profileModel?.mobile ?? "..."),
                  maxLines: 2),
              //Text("ایمیل: " + profileModel?.email ?? "...", maxLines: 2)
            ],
          )
        ],
      ),
      Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Divider(
            color: Colors.black,
          )),
      Flexible(child: ProfileButtons(context))
    ]));
  }
}
