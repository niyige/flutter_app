import 'package:flutter/material.dart';

class AllFilter extends StatefulWidget {
  final Function refresh;
  final Function clear;

  AllFilter({this.refresh, this.clear});

  @override
  State<StatefulWidget> createState() {
    return _AllFilterState();
  }
}

class _AllFilterState extends State<AllFilter> {
  List type = List()
    ..add({"txt": '信托计划', "select": false})
    ..add({"txt": '资产管理', "select": false})
    ..add({"txt": '契约基金', "select": false})
    ..add({"txt": '定融计划', "select": false});

  var typeWidget = List();

  List domain = List()
    ..add({"txt": '房地产类', "select": false})
    ..add({"txt": '征信类', "select": false})
    ..add({"txt": '工商企业类', "select": false});
  var domainWidget = List();

  List method = List()
    ..add({"txt": '按季分配', "select": false})
    ..add({"txt": '半年分配', "select": false})
    ..add({"txt": '按年分配', "select": false})
    ..add({"txt": '到期分配', "select": false});
  var methodWidget = List();

  @override
  void initState() {
    super.initState();
  }

  changeType(index, List itemList) {
    setState(() {
      itemList[index]["select"] = !itemList[index]["select"];

      //单选的单独处理
      if (itemList[0]["txt"] == "按季分配") {
        for (int i = 0; i < itemList.length; i++) {
          if (index != i) {
            itemList[i]["select"] = false;
          }
        }
      }
    });
  }

  //产品类型
  List _getTypeWidgetList() {
    typeWidget.clear();
    typeWidget.addAll(getNewItemList(type));
    return typeWidget;
  }

  //投资领域
  List _getDomainWidgetList() {
    domainWidget.clear();
    domainWidget.addAll(getNewItemList(domain));
    return domainWidget;
  }

  List _getPayMethodWidgetList() {
    methodWidget.clear();
    methodWidget.addAll(getNewItemList(method));
    return methodWidget;
  }

  //重新制作最新数据
  List getNewItemList(List itemList) {
    List list = List();

    itemList.asMap().forEach((i, item) => {
          list.add(GestureDetector(
            onTap: () {
              changeType(i, itemList);
            },
            child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                  color: itemList[i]["select"] ? Color(0xFF4780F7) :  Color(0xFFFFFFFF),
                  border: Border.all(color: Color(0xFF333333), width: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                child: Text(itemList[i]["txt"],
                    style: TextStyle(
                        color:
                            itemList[i]["select"] ? Color(0xFFFFFFFF) : Color(0xFF333333))),
              ),
            ),
          ))
        });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 15, top: 30, right: 15),
                  child: Text("产品类型"),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, top: 12, right: 15),
                  child: Wrap(
                    spacing: 9,
                    runSpacing: 8,
                    children: <Widget>[..._getTypeWidgetList()],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, top: 25, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("投资领域"),
                      Container(
                        margin: EdgeInsets.only(
                          top: 12,
                        ),
                        child: Wrap(
                          spacing: 9,
                          runSpacing: 8,
                          children: <Widget>[..._getDomainWidgetList()],
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
                      Text("付息方式"),
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Wrap(
                          spacing: 9,
                          runSpacing: 8,
                          children: <Widget>[..._getPayMethodWidgetList()],
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
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: Color(0xFF333333), width: 0.5))),
                      ),
                      Flexible(
                        child: GestureDetector(
                          child: Container(
                            height: 50,
                            color: Color(0xFFFFFFFF),
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
        ],
      ),
    );
  }
}
