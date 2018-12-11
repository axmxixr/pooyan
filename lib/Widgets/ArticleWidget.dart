import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:pooyan/Model/ArticleModel.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleModel article;

  ArticleWidget({this.article});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          article.imageUrl != null
              ? Image.network(
                  article.imageUrl,
                  fit: BoxFit.fitWidth,
                )
              : Text(""),
          Text(
            article.title,textScaleFactor: 1.2,
          ),
          Column(
            children: article.externalArticles.map((x) {
              return FlatButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => new WebviewScaffold(url: x.url)));
                  },
                  icon: Icon(Icons.link),
                  label: Text(x.title));
            }).toList(),
          )
        ],
      ),
    );
  }
}
