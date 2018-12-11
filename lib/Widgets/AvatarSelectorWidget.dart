import 'package:flutter/cupertino.dart';
import 'package:pooyan/Model/AvatarModel.dart';

class AvatarSelectorWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AvatarSelectorWidgetState();
}

class AvatarSelectorWidgetState extends State<AvatarSelectorWidget> {
  String avatarUrl;

  @override
  void initState() {
    super.initState();
    getAvatars(context).then((avatarList) {
      setState(() {
        avatarData = avatarList;
      });
    });
  }

  List<AvatarModel> avatarData = new List();

  @override
  Widget build(BuildContext context) {
    return new GridView.builder(
        itemCount: avatarData.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image.network(
                      avatarData[index].image,
                      scale: 1.5,
                    ))
              ],
            ),
            onTap: () {
              setAvatarImage(context, avatarData[index]).then((c) {
                Navigator.pop(context);
              });
            },
          );
        });
  }
}
