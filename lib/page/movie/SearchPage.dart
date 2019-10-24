import 'package:bkapp_flutter/entity/movie/results.dart';
import 'package:bkapp_flutter/page/BaseState.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Created by 1vPy on 2019/10/16.
class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends BaseState<SearchPage> {
  FocusNode _contentFocusNode = FocusNode();

  List<Results> _searchItems = [];
  String _searchWord;

  Widget buildSuggestionTips() {}

  Widget buildSearchResultList() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            autofocus: true,
            focusNode: _contentFocusNode,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
                hintText: '请输入',
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(),
                suffixIcon: IconButton(
                  alignment: Alignment.topRight,
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: this.onSearchBtnClick,
                )),
            onChanged: (value) {
              _searchWord = value;
            },
          ),
        ),
      ),
    );
  }

  void onSearchBtnClick() {
    _contentFocusNode.unfocus();
    Fluttertoast.showToast(msg: _searchWord);
  }
}
