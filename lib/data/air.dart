import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:env_ph/constants.dart';
import 'package:env_ph/home.dart';
import 'package:env_ph/tiles/data_tile.dart';
import 'package:env_ph/tiles/history_tile.dart';
import 'package:env_ph/routes/pageroutes.dart';

class AirPage extends StatefulWidget {
  @override
  AirPageState createState() => AirPageState();
}

class AirPageState extends State<AirPage> {
  List<Widget> generateDateTiles() {
    return [
      DataTile(0, updateLayout),
      DataTile(1, updateLayout),
      DataTile(2, updateLayout),
      DataTile(3, updateLayout),
    ];
  }

  List<Widget> generateHistoryTiles() {
    return [
      HistoryTile(2.70, DateTime.parse("2019-05-03")),
      HistoryTile(2.73, DateTime.parse("2019-05-04")),
      HistoryTile(2.60, DateTime.parse("2019-05-05")),
      HistoryTile(3.01, DateTime.parse("2019-05-06")),
    ];
  }

  void updateLayout(bool nGeneral, int nDataType) {
    setState(() {
      general = nGeneral;
      dataType = nDataType;
    });
  }

  void toggleLang() {
    setState(() {
      lang_idx++;
      lang_idx %= langs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
            top: 10,
            right: 10,
            child: Hero(
                tag: "toggleLang",
                child: FittedBox(
                    child: RawMaterialButton(
                        onPressed: toggleLang,
                        child: Text(langs[lang_idx],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Avenir',
                                fontSize: 15)),
                        shape: CircleBorder(),
                        fillColor: colorBtn,
                        splashColor: colorBtnSelected,
                        elevation: 2,
                        padding: EdgeInsets.all(10))))),
        Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.keyboard_arrow_left, color: colorBtn),
              iconSize: 50,
              onPressed: () {
                Navigator.of(context).pushReplacement(SlideLeftRoute(widget: HomePage()));
              },
            )),
        Positioned(
            top: 100,
            left: -50,
            child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: colorFloatShadow,
                      offset: Offset(0, 0),
                      blurRadius: 20,
                      spreadRadius: 5),
                ], shape: BoxShape.circle),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        general = true;
                      });
                    },
                    iconSize: 150,
                    icon: Image(
                      image:
                          AssetImage("assets/images/env_air_button_plain.png"),
                    )))),
        Positioned(
            top: 130,
            right: 20,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(general ? "AIR QUALITY" : dataTypes[dataType],
                        style: styleDataTypeText)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.location_on, color: colorBtn, size: 50),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                    Text("Dagpuan, Pangasinan", style: styleLocationText)
                  ],
                )
              ],
            )),
        Container(
          margin: EdgeInsets.fromLTRB(10, 300, 10, 0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 9/10,
                children:
                    general ? generateDateTiles() : generateHistoryTiles(),
              ))
            ],
          ),
        )
      ],
    ));
  }
}