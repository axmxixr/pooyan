import 'package:flutter/material.dart';
import 'package:pooyan/Model/PackageBoxModel.dart';
import 'package:pooyan/Model/QuestionsModel.dart';
import 'package:pooyan/Tools/Loading.dart';
import 'package:pooyan/Tools/MyColors.dart';
import 'package:pooyan/Widgets/Help.dart';
import 'package:pooyan/Widgets/QuestionsWidget.dart';

class ExaminingPage extends StatefulWidget {
  final PackageBoxModel pModel;

  ExaminingPage({this.pModel});

  @override
  State<StatefulWidget> createState() {
    return new ExaminingPageState();
  }
}

class ExaminingPageState extends State<ExaminingPage> {
  List<QuestionsModel> questionsList = new List();
  List<Widget> questionss = new List();
  int currentQuestion = 0;
  FlatButton finishExam;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      _getQuestions();
    });
  }

  Future _getQuestions() async {
    showLoadingDialog(context);
    getQuestions(context, widget.pModel.userPackageBoxId).then((q) {
      setState(() {
        questionsList = q;
        currentQuestion =
            widget.pModel.stateValue == 0 ? 0 : widget.pModel.stateValue - 1;
      });
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    questionss = questionsList
        .map<Widget>((x) => QuestionsWidget(
              question: x,
            ))
        .toList();

    if (questionsList != null &&
        questionsList.length > 0 &&
        !questionsList.any((x) => x.userAnswerId == null)) {
      finishExam = FlatButton(
          child: Text("پایان",textScaleFactor: 1.5,),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return new Container(
                    color: MyColors.firstBackground,
                    child: SimpleDialog(
                      title: Center(
                          child: Text(
                        widget.pModel.title,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.1,
                      )),
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.all(10.0),
                            foregroundDecoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Center(
                                child: Column(children: <Widget>[
                              Text("شما از تعداد " +
                                  questionss.length.toString() +
                                  " سوال " +
                                  _getScore().toString() +
                                  " را درست جواب دادید\n" "امتیاز شما : " +
                                  (_getScore() * 5).toString()),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("بستن"),
                                elevation: 10.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                              )
                            ])))
                      ],
                    ));
              },
            ).then((x) {
              Navigator.pop(context);
            });
          });
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Help(
                        helpPageName: helpPages.examiningPage,
                      )));
        },
        child: Text("راهنما"),
        mini: true,
      ),
      backgroundColor: MyColors.firstBackground,
      appBar: AppBar(
        backgroundColor: MyColors.appBarAndNavigationBar,
        title: Text(
          widget.pModel.title,
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.live_help),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (c) => SimpleDialog(
                          title: Center(child: Text("راهنما")),
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.all(5.0),
                                foregroundDecoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: SingleChildScrollView(
                                    child: Text(
                                  questionsList[currentQuestion].hint,
                                  textScaleFactor: 1.1,
                                )))
                          ],
                        ));
              })
        ],
      ),
      body: IndexedStack(
        children: questionss,
        index: currentQuestion,
      ),
      bottomSheet: LinearProgressIndicator(
        value: (currentQuestion.ceilToDouble() + 1) / questionsList.length,
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text("قبلی",textScaleFactor: 1.5,),
          onPressed: (currentQuestion > 0) ? _decrementIndex : null,
        ),
        FlatButton(
            child: Text("بعدی",textScaleFactor: 1.5,),
            onPressed: (currentQuestion < questionsList.length - 1)
                ? _incrementIndex
                : null),
        finishExam
      ],
    );
  }

  _incrementIndex() {
    setState(() {
      currentQuestion++;
    });
    _articleLearned();
  }

  _decrementIndex() {
    setState(() {
      currentQuestion--;
    });
    _articleLearned();
  }

  _articleLearned() {
    questionViewed(
        context, questionsList[currentQuestion].id, widget.pModel.id);
  }

  _getScore() {
    return 1;
  }
}
