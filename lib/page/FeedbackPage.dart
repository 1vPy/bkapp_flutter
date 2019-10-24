//Created by 1vPy on 2019/10/24.
import 'package:bkapp_flutter/page/BaseState.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FeedbackPageState();
}

class FeedbackPageState extends BaseState<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('问题反馈'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      child: TextField(
                        maxLines: 1,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: '称呼'),
                      ),
                      margin: EdgeInsets.only(bottom: 10, top: 5),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        maxLines: 1,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '联系方式（邮箱）'),
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                    ),
                    Container(
                      child: TextField(
                        maxLines: 10,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '请输入问题',
                            alignLabelWithHint: true),
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: MaterialButton(
                height: 40,
                onPressed: () {},
                child: Text('提交'),
                color: Colors.blue,
                minWidth: MediaQuery.of(context).size.width,
              ),
            )
          ],
        ));
  }
}
