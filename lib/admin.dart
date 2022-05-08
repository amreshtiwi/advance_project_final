import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/countryWithID.dart';
import 'models/country.dart';
List <countryModel> _lastupdate =[];

class admin extends StatelessWidget {
  List <countryWithID> _allupdate =[];
  List <String> justCountryName = [] ;
  List <String> justCountryID = [] ;

  Future<List<countryWithID>> getCountryList() async{
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //api/v1/Country
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token=(prefs.getString('token')??'');
    final response =await http.get(Uri.parse("http://192.168.1.65:8090/api/v1/Country/all"),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer '+token,
        "content-type": "application/json"
      },);
    if (response.statusCode == 200) {
      final list = await json.decode(response.body) as List<dynamic>;
      return list.map((e) => countryWithID.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
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

      final list = await json.decode(response.body) as List<dynamic>;
      return list.map((e) => countryModel.fromJson(e)).toList();
    } else {
      print(response.statusCode);
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([getCountryList(), readJson()]),
      builder: (context,AsyncSnapshot <List<dynamic>> snapshot) {
      if(snapshot.hasData) {
        _allupdate = snapshot.data![0] as List<countryWithID>;
        for(var i = 0 ; i < _allupdate.length ; i++){
          //justCountryName[i] = _allupdate[i].name!;
          justCountryName.insert(i, _allupdate[i].name!);
          justCountryID.insert(i, _allupdate[i].code!);
        }
        _lastupdate = snapshot.data![1] as List<countryModel>;
        return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: search());
                    },
                    icon: Icon(Icons.search))
              ],
              backgroundColor: Color(0xff342524),
            ),
            body: SingleChildScrollView(child: top(
                justCountryName:justCountryName,
              justCountryCode: justCountryID,
            )));
      }else if (snapshot.hasError){
        print(snapshot.error);
        return Text(
          "${snapshot.error}",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        );
      }else{
        print('fitching');//delete this ----------------------------
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      }
    );
  }
}

class top extends StatefulWidget {
  List <String> justCountryName = [] ;
  List <String> justCountryCode = [] ;
  top({Key? key,required this.justCountryName ,
    required this.justCountryCode ,}) : super(key: key);

  @override
  State<top> createState() => _topState();
}

class _topState extends State<top> {
  @override
  String $Admin_name = "Ahmad";

  ////////////////////////////////////////////// admin name
  TextEditingController deaths = new TextEditingController();

  /////////////////////////////////////// death num
  TextEditingController cases = new TextEditingController();

  ///////////////////////////////////////// cases num

  String country = "Afghanistan";
  String code = "AF";

  /////////////////////////////////////////// country name

  String text1 = "New Cases";
  String text2 = "New Deaths";

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted =
      formatter.format(now); ///////////////////////////////



addingNewCases()async{ ///////////////////////////////////////////////////////////////
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token=(prefs.getString('token')??'');
  var jasonData = null;
  var response = await http.post(
      Uri.parse("http://192.168.1.65:8090/api/v1/covid/addCovid"),
      body: json.encode({
        'newCases': int.parse(cases.text),
        'newDeaths':  int.parse(deaths.text),
        'dateReported': formatted ,
        'cumulativeCases': int.parse(cases.text),
        'cumulativeDeaths': int.parse(deaths.text),
        'country':{
          'id': code,
          'name' : country
        }
      }),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer '+token,
      "content-type": "application/json"
    },);
  if (response.statusCode == 200) {
    print('acc succcess');
    if (jasonData != null) {
      prefs.setString("token",jasonData['jwtToken']);
    } else {
      print(response.body);
    }
  }
  else{
    print(response.statusCode);
    print(response.body);
    final snakbar =SnackBar(content: Text("adding new cases"));
    ScaffoldMessenger.of(context).showSnackBar(snakbar);
  }
}

  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(left: 20, right: 20),
      color: Color(0xff72A9AF),
      child: Column(children: [
        Image(
          image: AssetImage('images/logo.png'),
        ),
        Container(
            width: 200,
            margin: EdgeInsets.only(top: 30, bottom: 50),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Hi " + $Admin_name, style: TextStyle(fontSize: 20)),
              Icon(Icons.waving_hand,
                  size: 20, color: Color.fromARGB(255, 204, 137, 47)),
            ])),
        Column(
          children: [
            Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 200,
                    margin: EdgeInsets.only(right: 20),
                    child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "$text1",
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: cases),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 200,
                    margin: EdgeInsets.only(right: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "$text2",
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: deaths,
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              width: 410,
              margin: EdgeInsets.only(top: 40, bottom: 20),
              child: DropdownSearch<String>(
                mode: Mode.BOTTOM_SHEET,
                items: widget.justCountryName,
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Choose country",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: (CountryCode) {
                  setState(() {
                    country = CountryCode.toString();
                    ///// country name
                    for(var i = 0 ; i < widget.justCountryName.length ; i++){
                      if(widget.justCountryName[i] == CountryCode.toString() ){
                        code = widget.justCountryCode[i];
                        break;
                      }
                    }
                  });
                  print(CountryCode);
                },
                selectedItem: country,
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                    labelText: "Search country",
                  ),
                ),
                popupTitle: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Country',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                popupShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 80),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(120, 50),
                    textStyle: TextStyle(fontSize: 20),
                    primary: Color(0xffD98A28),
                  ),
                  onPressed: () {
                    if (deaths.text != "" && cases.text != "") {
                      print(deaths.text); ////////////////////
                      print(country); /////////////////////////
                      print(cases.text);
                      print(formatted); /////////////
                      addingNewCases();
                      cases.clear();
                      deaths.clear();
                    }
                  },
                  child: Text("Save")),
            ),
          ],
        ),
      ]),
    );
  }
}

class search extends SearchDelegate {

  @override
  List s = ["", ""];
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List <countryModel> view = _lastupdate
        .where((element) => element.country.toString().startsWith(query))
        .toList();

    print("hi this is line 346" + view.toString());
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 10),
          padding: EdgeInsets.only(
            left: 5,
          ),
          child: view.length == 0 && query != ""
              ? Text("")
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                      Container(width: 80, child: Text("Country")),
                      Expanded(flex: 1, child: Text("Deaths")),
                      Expanded(flex: 1, child: Text("Cases")),
                      Expanded(flex: 1, child: Text("Total death")),
                      Expanded(flex: 1, child: Text("Total cases")),
                      Expanded(flex: 1, child: Text("Date")),
                    ]),
        ),
        new Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 5, right: 5),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: query == "" ? _lastupdate.length : view.length,
                itemBuilder: ((context, i) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    color: Color.fromARGB(255, 239, 161, 58),
                    height: 60,
                    margin: EdgeInsets.only(bottom: 10),
                    child: query == ""
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 80,
                                    child: Text(
                                      _lastupdate[i].country.toString(),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      _lastupdate[i].newDeaths.toString(),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      _lastupdate[i].newCases.toString(),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                    _lastupdate[i].cumCases.toString(),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      _lastupdate[i].cumDeaths.toString(),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      _lastupdate[i].date.toString(),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                              ])
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Container(
                                    width: 80,
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      view[i].country.toString(),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      view[i].newDeaths.toString(),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      view[i].cumCases.toString(),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      view[i].cumCases.toString(),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      view[i].newDeaths.toString(),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      view[i].date.toString(),
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                              ]),
                  );
                })),
          ),
        )
      ],
    );
  }
}
