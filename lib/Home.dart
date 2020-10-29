import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String url =
      "https://api.thingspeak.com/channels/1136784/feeds.json?api_key=WI5EGXTWXKAKHOR5";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['feeds'];
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('ThingSpeak Data'),
          leading: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: getJsonData,
          ),
        ),
        body: new ListView.builder(
          itemCount: data == null ? 0 : 1,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              child: new Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.amber[600],
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Text("Temperature : " +
                              data[data.length - 1]['field1'])),
                      height: 60.0,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.amber[600],
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                            "Humidity : " + data[data.length - 1]['field2']
                            //  ==
                            //         null
                            //     ? "null"
                            //     : data[data.length - 1]['field2']
                            ),
                      ),
                      height: 60.0,
                    ),
                    RaisedButton(
                      onPressed: getJsonData,
                      color: Colors.blue,
                      child: Text("Get Data"),
                    )
                  ])),
            );
          },
        ));
  }
}
