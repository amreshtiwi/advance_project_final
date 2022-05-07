import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

List database = [
  /////////////////////////////////////////////
  {
    'Country': "palestine",
    'new_death': 20,
    'new_cases': 10,
    'Cumulative_cases': 30,
    'Cumulative_deaths': 20,
    'Date': "2021-09-12"
  },
  {
    'Country': "palestine",
    'new_death': 20,
    'new_cases': 10,
    'Cumulative_cases': 30,
    'Cumulative_deaths': 20,
    'Date': "2021-09-12"
  },
  {
    'Country': "palestine",
    'new_death': 20,
    'new_cases': 10,
    'Cumulative_cases': 30,
    'Cumulative_deaths': 20,
    'Date': "2021-09-12"
  },
  {
    'Country': "palestine",
    'new_death': 20,
    'new_cases': 10,
    'Cumulative_cases': 30,
    'Cumulative_deaths': 20,
    'Date': "2021-09-12"
  },
  {
    'Country': "Egypt",
    'new_death': 20,
    'new_cases': 10,
    'Cumulative_cases': 30,
    'Cumulative_deaths': 20,
    'Date': "2021-09-12"
  },
  {
    'Country': "USA",
    'new_death': 20,
    'new_cases': 10,
    'Cumulative_cases': 30,
    'Cumulative_deaths': 20,
    'Date': "2021-09-12"
  },
  {
    'Country': "palestine",
    'new_death': 20,
    'new_cases': 10,
    'Cumulative_cases': 30,
    'Cumulative_deaths': 20,
    'Date': "2021-09-12"
  },
  {
    'Country': "Algeria",
    'new_death': 20,
    'new_cases': 10,
    'Cumulative_cases': 30,
    'Cumulative_deaths': 20,
    'Date': "2021-09-12"
  },
  {
    'Country': "China",
    'new_death': 20,
    'new_cases': 10,
    'Cumulative_cases': 30,
    'Cumulative_deaths': 20,
    'Date': "2021-09-12"
  },
  {
    'Country': "palestine",
    'new_death': 20,
    'new_cases': 10,
    'Cumulative_cases': 30,
    'Cumulative_deaths': 20,
    'Date': "2021-09-12"
  }
];

class admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: search());
                },
                icon: Icon(Icons.search))
          ],
          backgroundColor: Color.fromARGB(255, 35, 35, 35),
        ),
        body: SingleChildScrollView(child: top()));
  }
}

class top extends StatefulWidget {
  top({Key? key}) : super(key: key);

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

  String country = "Brazil";

  /////////////////////////////////////////// country name

  String text1 = "New Cases";
  String text2 = "New Deaths";

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted =
      formatter.format(now); ///////////////////////////////

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      color: Color.fromARGB(255, 255, 255, 255),
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
                items: [
                  /////////////////////////////////////////////
                  "Brazil",
                  "Italia",
                  "Tunisia",
                  'Canada',
                  'Zraoua',
                  'France',
                  'Belgique'
                ],
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Choose country",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: (CountryCode) {
                  setState(() {
                    country = CountryCode!;
                    ///// country name
                  });
                },
                selectedItem: "Brazil",
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
                    primary: Color.fromARGB(255, 35, 35, 35),
                  ),
                  onPressed: () {
                    if (deaths.text != "" && cases.text != "") {
                      print(deaths.text); ////////////////////
                      print(country); /////////////////////////
                      print(cases.text);
                      print(formatted); /////////////

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
    List view = database
        .where((element) => element['Country'].startsWith(query))
        .toList();

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
                itemCount: query == "" ? database.length : view.length,
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
                                      database[i]['Country'],
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      database[i]['new_death'].toString(),
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      database[i]['new_cases'].toString(),
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      database[i]['Cumulative_cases']
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      database[i]['Cumulative_deaths']
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      database[i]['Date'],
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    )),
                              ])
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Container(
                                    width: 80,
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      view[i]['Country'],
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      view[i]['new_death'].toString(),
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      view[i]['new_cases'].toString(),
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      view[i]['Cumulative_cases'].toString(),
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      view[i]['Cumulative_deaths'].toString(),
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      view[i]['Date'],
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white),
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
