import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class ArticleWidget extends StatefulWidget {
  final String longText;
  const ArticleWidget({Key? key,required this.longText}) : super(key: key);

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {

  @override
  Widget build(BuildContext context) {
    String longText="'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.'";
    return ExpandableText(
      longText ="",
      expandText: 'show more',
      collapseText: 'show less',
      maxLines: 1,
      linkColor: Colors.blue,
    );
  }
}

