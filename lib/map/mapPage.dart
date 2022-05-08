import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/country.dart';

// void main() {
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MediaQuery(
//       data: MediaQueryData(),
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: map(title: 'Flutter Demo Home Page', ),
//       ),
//     );
//   }
// }


class map extends StatefulWidget {
  map({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _State createState() => _State();
}

class _State extends State<map> {
  late Future<List<countryModel>> futurePost;
  late MapZoomPanBehavior _zoomPanBehavior;
  late MapShapeSource dataSource;
  late int selectedIndex = -1;
   List <countryModel> _lastupdate =[];
   List <countryModel> _allupdate =[];
   int flagForOne = 1 ;
  // bool isBottomSheetShown = false;
  int timerCount = 0;
  var scaffoldKey =GlobalKey<ScaffoldState>();


  Future<List<countryModel>> readJson() async{
    // final jsonData = await rootBundle.rootBundle.loadString('assets/WHO-COVID-19-global-data.json');
    // final list = await json.decode(jsonData) as List<dynamic>;
    // return list.map((e) => countryModel.fromJson(e)).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token=(prefs.getString('token')??'');
    final response =await http.get(Uri.parse("http://192.168.1.65:8090/api/v1/covid/byDateReported/2022-04-06"),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+token,
        "content-type": "application/json"
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(json.decode(response.body));
      final list = await json.decode(response.body) as List<dynamic>;
      print(json.decode(response.body));
      return list.map((e) => countryModel.fromJson(e)).toList();
    } else {
      print(response.statusCode);
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

   void lastUpdateMethod() {
    var j = 0;
    _lastupdate.clear();
    for(var i = 0 ; i < _allupdate.length ; i++){
      if(_allupdate[i].date == "2022-04-06"){
        _lastupdate.insert(j, _allupdate[i]) ;
        if(_lastupdate[j].newCases! <= 100){
          _lastupdate[j].color = Colors.green[100];
        }if(_lastupdate[j].newCases! > 100){
          _lastupdate[j].color = Colors.red[100];
        }
        j=j+1;
      }
    }
    print('this is j' + j.toString());
  }


  @override
  void initState() {
    print("again bro ?");
    super.initState();
    futurePost = readJson();
    _zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: MapLatLng(31.7786, 35.2356),
      zoomLevel: 7,
      enableDoubleTapZooming: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<countryModel>>(
      future: futurePost,
      builder: (context,data) {
        if(data.hasData) {
          if(flagForOne == 1) {
            _allupdate = data.data as List<countryModel>;
            lastUpdateMethod();
            flagForOne =0;
            dataSource = MapShapeSource.asset(
              'assets/world_map.json',
              shapeDataField: 'name',
              dataCount: _lastupdate.length,
              primaryValueMapper: (int index) =>
              _lastupdate[index].country as String,
              shapeColorValueMapper: (int index) => _lastupdate[index].color,
            );
          }
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text('COVID-19 Map'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.0)
                ),
              ),
              backgroundColor: Color(0xff342524),
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(0,0, 0, 0),
              child: SfMaps(
                layers: <MapLayer>[
                  MapShapeLayer(
                    source: dataSource,
                    showDataLabels: true,
                    zoomPanBehavior: _zoomPanBehavior,
                      selectedIndex: selectedIndex,
                      onSelectionChanged: (int index){
                        setState(() {
                          selectedIndex = index;
                        });


                        // scaffoldKey.currentState!.showBottomSheet(
                        //         (context) =>
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(

                          backgroundColor: Colors.redAccent.withOpacity(0),//Color.fromARGB(0, 255, 255,255),
                                  duration: const Duration(seconds: 6),
                                  content: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0),
                                        bottomLeft: Radius.circular(15.0),
                                        bottomRight: Radius.circular(15.0),
                                      ),
                                      color: Color(0xff85C9D0),//85C9D0
                                    ),

                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15.0),
                                                topRight: Radius.circular(15.0),
                                              ),
                                              color: Color(0xffD98A28),
                                            ),

                                            width: double.infinity,
                                            height: 35.0,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text('Details',
                                              style: TextStyle(
                                                fontSize:20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,//Color(0xff85C9D0)
                                              ),),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Country : ',
                                                      style: TextStyle(
                                                        fontSize:16.0,
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    Text(_lastupdate[selectedIndex].country.toString(),
                                                      style: TextStyle(
                                                        fontSize:16.0,
                                                      ),),
                                                  ],
                                                ),
                                                SizedBox(width: 5.0,),
                                                Row(
                                                  children: [
                                                    Text('New cases : ',
                                                      style: TextStyle(
                                                        fontSize:16.0,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                    Text(_lastupdate[selectedIndex].newCases.toString(),
                                                      style: TextStyle(
                                                        fontSize:16.0,
                                                      ),),
                                                  ],
                                                ),
                                                SizedBox(width: 5.0,),
                                                Row(
                                                  children: [
                                                    Text('New deaths : ',
                                                      style: TextStyle(
                                                        fontSize:16.0,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                    Text(_lastupdate[selectedIndex].newDeaths.toString(),
                                                      style: TextStyle(
                                                        fontSize:16.0,
                                                      ),),
                                                  ],
                                                ),
                                                SizedBox(width: 5.0,),
                                                Row(
                                                  children: [
                                                    Text('Cumulative cases : ',
                                                      style: TextStyle(
                                                        fontSize:16.0,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                    Text(_lastupdate[selectedIndex].cumCases.toString(),
                                                      style: TextStyle(
                                                        fontSize:16.0,
                                                      ),),
                                                  ],
                                                ),
                                                SizedBox(width: 5.0,),
                                                Row(
                                                  children: [
                                                    Text('Cumulative deathes : ',
                                                      style: TextStyle(
                                                        fontSize:16.0,
                                                          fontWeight: FontWeight.bold
                                                      ),),
                                                    Text(_lastupdate[selectedIndex].cumDeaths.toString(),
                                                      style: TextStyle(
                                                        fontSize:16.0,
                                                      ),),
                                                  ],
                                                ),
                                                SizedBox(width: 5.0,),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                  ),
                                ),
                        );

                    },
                    selectionSettings: MapSelectionSettings(
                      color: Color(0xff72A9AF),
                      strokeColor: Color(0xff342524),
                      strokeWidth: 2,
                    ),
                    loadingBuilder: (BuildContext context){
                      return Container(
                        height: 25.0,
                        width: 25.0,
                        child: const CircularProgressIndicator(
                          strokeWidth: 3.0,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }else if (data.hasError){
          print(data.error);
          return Text(
            "${data.error}",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          );
        }else{
          print('fitching');//delete this ----------------------------
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
