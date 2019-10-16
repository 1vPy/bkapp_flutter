import 'package:bkapp_flutter/entity/movie/results.dart';
import 'package:flutter/material.dart';

//Created by 1vPy on 2019/10/16.
class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {

  List<Results> _searchItems = [];


  Widget buildSuggestionTips() {}

  Widget buildSearchResultList() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
              hintText: '请输入', hintStyle: TextStyle(color: Colors.black45)),
        ),
      ),
    );
  }
}
