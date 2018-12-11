import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pooyan/Model/PackageModel.dart';
import 'package:pooyan/Pages/SelectedPackage.dart';
import 'package:pooyan/Tools/MyColors.dart';
import 'package:pooyan/Widgets/Help.dart';

class PackagePage extends StatefulWidget {
  final List<PackageModel> packageList;

  PackagePage({this.packageList});

  @override
  State<StatefulWidget> createState() {
    return new PackagePageState();
  }
}

class PackagePageState extends State<PackagePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      duration: new Duration(milliseconds: 1000),
      vsync: this,
    );
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeIn)
          ..addListener(() => this.setState(() {}))
          ..addStatusListener((AnimationStatus status) {});
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Help(helpPageName: helpPages.packagesPage,)));
          },
          child: Text("راهنما"),mini: true,),backgroundColor: MyColors.firstBackground,
        appBar: new AppBar(backgroundColor: MyColors.appBarAndNavigationBar,
          title: Center(child: new Text("نرم افزار مطلب")),
        ),
        body: GridView.builder(
            itemCount: widget.packageList.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectedPackage(
                                  package: widget.packageList[index],
                                )));
                  },
                  child: Transform.scale(
                      scale: animation.value,
                      child: new Card(
                        color: MyColors.packages,
                        elevation: animation.value * 15.0,
                        margin: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 3.0, color: MyColors.packages),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        child: GridTileBar(
                          subtitle: Center(
                            child: Text(
                              widget.packageList[index].title,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          title: Image.network(
                            widget.packageList[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )));
            }));
  }
}
