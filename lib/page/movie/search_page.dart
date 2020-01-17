import 'package:bkapp_flutter/entity/movie/results.dart';
import 'package:bkapp_flutter/page/base_state.dart';
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
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: TextField(
              autofocus: true,
              focusNode: _contentFocusNode,
              textInputAction: TextInputAction.search,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                hintText: '请输入搜索',
                hintStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
              ),
              onChanged: (value) {
                _searchWord = value;
              },
              onSubmitted: (value) {
                onSearchBtnClick();
              },
            ),
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
