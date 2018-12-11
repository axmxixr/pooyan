import 'package:flutter/material.dart';
import 'package:pooyan/Model/ArticleModel.dart';
import 'package:pooyan/Model/PackageBoxModel.dart';
import 'package:pooyan/Pages/ExaminingPage.dart';
import 'package:pooyan/Tools/Loading.dart';
import 'package:pooyan/Tools/MyColors.dart';
import 'package:pooyan/Widgets/ArticleWidget.dart';
import 'package:pooyan/Widgets/Help.dart';

class LearningPage extends StatefulWidget {
  final PackageBoxModel box;
  final bool isLearning;

  LearningPage({this.box, this.isLearning});

  @override
  State<StatefulWidget> createState() {
    return new LearningPageState();
  }
}

class LearningPageState extends State<LearningPage> {
  List<ArticleModel> articles = new List();
  int currentArticle = 0;
  List<Widget> pages = new List();
  FlatButton goToExamButton;


  @override
  void initState() {
    super.initState();
//    if (widget.isLearning) {
//      goToExamButton = IconButton(icon: Icon(Icons.extension), onPressed: null);
//    }
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      _getPackages();
    });

  }

  Future _getPackages() async
  {
    showLoadingDialog(context);
    getBoxArticles(context, widget.box.userPackageBoxId).then((articles2) {
      Navigator.pop(context);
      setState(() {
        articles = articles2;
        pages = articles
            .map<Widget>((x) => ArticleWidget(
          article: x,
        ))
            .toList();
        currentArticle =
        widget.box.stateValue == 0 ? 0 : widget.box.stateValue - 1;
        _articleLearned();
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Help(helpPageName: helpPages.learningPage,)));
        },
        child: Text("راهنما"),mini: true,),backgroundColor: MyColors.firstBackground,
      appBar: AppBar(backgroundColor: MyColors.appBarAndNavigationBar,
        title: Text(
          widget.box.title,
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: Padding(padding: EdgeInsets.all(15.0),child: IndexedStack(
        children: pages,
        index: currentArticle,
      )),
      bottomSheet: LinearProgressIndicator(
        value: (currentArticle.ceilToDouble() + 1) / articles.length,
      ),

      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text("قبلی",textScaleFactor: 1.5,),
          onPressed: (currentArticle > 0) ? _decrementIndex : null,
        ),
        FlatButton(
            child: Text("بعدی",textScaleFactor: 1.5,),
            onPressed: (currentArticle < articles.length - 1)
                ? _incrementIndex
                : null),
        goToExamButton
      ],
    );
  }

  _incrementIndex() {
    setState(() {
      currentArticle++;
    });
    _articleLearned();
  }

  _decrementIndex() {
    setState(() {
      currentArticle--;
    });
    _articleLearned();
  }

  _articleLearned() {
    if (widget.isLearning) {
      articles[currentArticle].articleLearned(context, widget.box.id);
      if (currentArticle + 1 == articles.length) {
        goToExamButton = FlatButton(
            child: Text("شروع آزمون",textScaleFactor: 1.5,),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExaminingPage(
                            pModel: widget.box,
                          )));
            });
      }
    }
  }
}
