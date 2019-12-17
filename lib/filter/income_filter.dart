import 'package:flutter/material.dart';

class IncomeFilter extends StatefulWidget {
  final Function refresh;
  final Function clear;

  IncomeFilter({this.refresh, this.clear});

  @override
  State<StatefulWidget> createState() {
    return _IncomeFilterState();
  }
}

class _IncomeFilterState extends State<IncomeFilter> {
  List year = List()
    ..add({"txt": '8%以内(含)', "select": false})
    ..add({"txt": '8～9%(含)', "select": false})
    ..add({"txt": '9%以上', "select": false});
  var yearWidget = List();

  List rate = List()
    ..add({"txt": '1%以内(含)', "select": false})
    ..add({"txt": '1～3%', "select": false})
    ..add({"txt": '3%以上', "select": false});
  var rateWidget = List();

  ///年化收益
  List _getYearWidgetList() {
    yearWidget.clear();
    yearWidget.addAll(getNewItemList(year));
    return yearWidget;
  }

  ///前端费率
  List _getRateWidgetList() {
    rateWidget.clear();
    rateWidget.addAll(getNewItemList(rate));
    return rateWidget;
  }

  List getNewItemList(List itemList) {
    List list = List();

    itemList.asMap().forEach((i, item) =>{

      list.add(GestureDetector(
        onTap: () =>  changeType(i, itemList),
        child: Container(
          width: 109,
          height: 30,
          decoration: BoxDecoration(
              color: itemList[i]["select"] ? Color(0xFF4780F7) : Color(0xFFFFFFFF),
              border: Border.all(color: Color(0xFF333333), width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Center(
            child: Text(itemList[i]["txt"],
                style: TextStyle(
                    color: itemList[i]["select"] ? Color(0xFFFFFFFF) : Color(0xFF333333))),
          ),
        ),
      ))
    });
    return list;
  }

  changeType(index, List itemList) {
//    Log("之前：" + itemList[index]["select"].toString());
    setState(() {
      itemList[index]["select"] = !itemList[index]["select"];

      for (int i = 0; i < itemList.length; i++) {
        if (index != i) {
          itemList[i]["select"] = false;
        }
      }

//      Log("之后：" + itemList[index]["select"].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 15, top: 25, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("年化收益"),
                  Container(
                    margin: EdgeInsets.only(
                      top: 12,
                    ),
                    child: Wrap(
                      spacing: 9,
                      runSpacing: 8,
                      children: <Widget>[..._getYearWidgetList()],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 25, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("前端费率"),
                  Container(
                    margin: EdgeInsets.only(
                      top: 12,
                    ),
                    child: Wrap(
                      spacing: 9,
                      runSpacing: 8,
                      children: <Widget>[..._getRateWidgetList()],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color(0xFF333333), width: 0.5))),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: GestureDetector(
                      child: Container(
                        height: 50,
                        color: Color(0xFFFFFFFF),
                        width: double.infinity,
                        child: Center(
                          child: Text("清空"),
                        ),
                      ),
                      onTap: () {
                        widget.clear();
                      },
                    ),
                    flex: 1,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border(
                            right:
                                BorderSide(color: Color(0xFF333333), width: 0.5))),
                  ),
                  Flexible(
                    child: GestureDetector(
                      child: Container(
                        height: 50,
                        color: Color(0xFFFFFFFF),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "确定",
                            style: TextStyle(color: Color(0xFF4780F7)),
                          ),
                        ),
                      ),
                      onTap: () {
                            widget.refresh(null);
                      },
                    ),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
