import 'package:flutter/material.dart';
import 'package:pooyan/Model/AnswersModel.dart';
import 'package:pooyan/Model/QuestionsModel.dart';

class QuestionsWidget extends StatefulWidget {
  final QuestionsModel question;

  QuestionsWidget({this.question});

  @override
  State<StatefulWidget> createState() {
    return new QuestionsWidgetState();
  }
}

class QuestionsWidgetState extends State<QuestionsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                widget.question.questionText,
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.5,
              )),
          Divider(
            color: Colors.black,
            height: 20.0,
          ),
          Column(
            children: widget.question.answersModel.map((x) {
              return SizedBox(
                child: FlatButton(
                  onPressed: () {
                    _questionAnswer(context, x);
                  },
                  child: SizedBox(
                    child: Text(
                      x.textWithLabel(),
                      textScaleFactor: 1.2,
                      textAlign: TextAlign.right,
                    ),
                    width: double.infinity,
                  ),
                  color: _getColor(x),
                ),
                width: double.infinity,
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  _questionAnswer(BuildContext c, AnswersModel a) {
    String message;
    if (widget.question.userAnswerId == null) {
      answerQuestion(c, a.id);
      setState(() {
        widget.question.userAnswerId = a.id;
      });
      if (a.isCorrect) {
        message = "پاسخ شما صحیح است";
      } else {
        message = "پاسخ شما غلط است";
      }
    } else {
      message = "شما قبلا به این سوال پاسخ داده اید";
    }
    Scaffold.of(c).showSnackBar(new SnackBar(
      content: new Text(message),
    ));
  }

  Color _getColor(AnswersModel answer) {
    if (widget.question.userAnswerId == null) {
      return null;
    }
    AnswersModel userAnswer = widget.question.answersModel
        .firstWhere((a) => a.id == widget.question.userAnswerId);

    if (userAnswer.id == answer.id && !userAnswer.isCorrect) return Colors.red;
    if (answer.isCorrect) return Colors.green;
    return null;
  }
}
