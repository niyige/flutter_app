import 'package:flutter/material.dart';

class DefaultFilter extends StatefulWidget {
  final Function refresh;
  final Function clear;

  final int select; //选中

  DefaultFilter({this.refresh, this.select, this.clear});

  @override
  State<StatefulWidget> createState() {
    return _DefaultFilterState();
  }
}

class _DefaultFilterState extends State<DefaultFilter> {
  List defaultList = List()
    ..add({"txt": '默认排序', "type": "default"})
    ..add({"txt": '高收益优先', "type": "hightIncome"})
    ..add({"txt": '低收益优先', "type": "lowIncome"})
    ..add({"txt": '投资期限  短->长', "type": "time"});

  List defaultWidget = List();

  @override
  void initState() {
    super.initState();
    defaultWidget.clear();

    defaultList.asMap().forEach((index, item) => {
      defaultWidget.add(GestureDetector(
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border(
                  bottom:
                  BorderSide(color: Color(0xFF888888), width: 0.5))),
          child: Center(
            child: Text(
              item["txt"],
              style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  backgroundColor: Colors.transparent,
                  color:
                  widget.select == index ? Color(0xFF4780F7) : Color(0xFF333333)),
            ),
          ),
        ),
        onTap: () {
          widget.refresh(index);
        },
      ))
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[...defaultWidget],
          ),
        ),
    );
  }
}
