import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'package:flutter_app/filter/all_filter.dart';
import 'package:flutter_app/filter/default_filter.dart';
import 'package:flutter_app/filter/income_filter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '筛选Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final TextStyle _biggerFont = new TextStyle(fontSize: 18.0);

  int _selectIndex; //筛选的下标  0-综合， 1-收益/费率  2-默认排序

  GlobalKey _containerKey = GlobalKey();

  /// 位置信息
  Offset _containerPosition = Offset(0, 0);

  //筛选布局的高度
  double selectHeight = 24;

  //筛选框默认选中的下标
  int defaultIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(_getContainerPosition);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 44,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.5))),
              child: Align(
                alignment: Alignment.center,
                child: Text("每日折扣一栏",
                    style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
            ),
            buildSelectWidget(),
            _buildSuggestions()
          ],
        ),
        _selectIndex != null
            ? Positioned(
                top: _containerPosition.dy + 15,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - _containerPosition.dy -15, //15是筛选框距离筛选栏的距离
                child: GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: 6),
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      children: <Widget>[showSelectWidget()],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectIndex = null;
                    });
                  },
                ))
            : Container()
      ]),
    ));
  }

  Widget _buildSuggestions() {
    return Expanded(
        flex: 1,
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: 20,
          itemBuilder: (context, i) {
            if (i.isOdd) return new Divider();
            if (i < 20) {
              _suggestions.addAll(generateWordPairs().take(10)); //十条线 ，十个单词
            }
            return _buildRow(_suggestions[i]);
          },
        ));
  }

  Widget _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  ///获取组件位置信息
  void _getContainerPosition(_) {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerPosition = containerRenderBox.localToGlobal(Offset.zero);

    setState(() {
      _containerPosition = containerPosition;
    });
    print("oyy =" + _containerPosition.dy.toString());
  }

  _onSelectChange(index) {
    setState(() {
      if (_selectIndex == index) {
        _selectIndex = null;
      } else {
        _selectIndex = index;
      }
    });
  }

  ///显示筛选Widget
  Widget showSelectWidget() {
    return GestureDetector(
      child: getSelectWidget(),
      onTap: () {},
    );
  }

  Widget getSelectWidget() {
    if (_selectIndex == 0) {
      return AllFilter(
        clear: selectClear,
        refresh: selectRefresh,
      );
    } else if (_selectIndex == 1) {
      return IncomeFilter(
        clear: selectClear,
        refresh: selectRefresh,
      );
    } else if (_selectIndex == 2) {
      return DefaultFilter(
          select: defaultIndex, refresh: selectRefresh, clear: selectClear);
    }
    return Container();
  }

  selectRefresh(int index) {
    setState(() {
      defaultIndex = index;

      //筛选箭头都重置
      _selectIndex = null;
    });
    //刷新列表
//    _onRefresh();
  }

  ///清空
  selectClear() {
    if (_selectIndex != null) {
      setState(() {
        _selectIndex = null;
      });
    }
  }

  Widget buildSelectWidget() {
    return Builder(
        builder: (context) => Container(
              key: _containerKey,
              height: selectHeight,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(left: 44, right: 44),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text("综合筛选"),
                          margin: EdgeInsets.only(right: 5),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2),
                          child: Image.asset(
                            _selectIndex == 0
                                ? "assets/img/ic_select_up.png"
                                : "assets/img/ic_select_down.png",
                            width: 9,
                            height: 5,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      _onSelectChange(0);
                    },
                  ),
                  GestureDetector(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text("收益/费率"),
                          margin: EdgeInsets.only(right: 5),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2),
                          child: Image.asset(
                            _selectIndex == 1
                                ? "assets/img/ic_select_up.png"
                                : "assets/img/ic_select_down.png",
                            width: 9,
                            height: 5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _onSelectChange(1);
                    },
                  ),
                  GestureDetector(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text("默认排序"),
                          margin: EdgeInsets.only(right: 5),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2),
                          child: Image.asset(
                            _selectIndex == 2
                                ? "assets/img/ic_select_up.png"
                                : "assets/img/ic_select_down.png",
                            width: 9,
                            height: 5,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      _onSelectChange(2);
                    },
                  ),
                ],
              ),
            ));
  }
}
