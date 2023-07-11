import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/view/screens/mails/save_route.dart';
import '../../../utill/app_constants.dart';
import '../../base/custom_home_app_bar.dart';
import 'package:http/http.dart' as http;

import '../../base/no_data_screen.dart';
import '../order_history/widget/form_widget.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key key}) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  SharedPreferences localStorage;
  bool isCustomerLogin = false;
  List<dynamic> _driverRoutes = [];
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  List<Route> _routeList = [];

  @override
  void initState() {
    super.initState();

    _getLocalData();
  }

  var userId;
  var _userEmail;
  var userData;
  var _userName;
  bool _isLoading = false;

  _getLocalData() async {
    localStorage = await SharedPreferences.getInstance();
    //make sure customer is logged in
    var userJson = localStorage.getString("user");
    var user = json.decode(userJson);
    setState(() {
      userId = user['id'];
      _userName = user['name'];
      _userEmail = user['email'];
    });
    loadDriverRoute();
  }

  loadDriverRoute() async {
    setState(() {
      _isLoading = true;
    });

    var res = await http.get(Uri.parse(
        AppConstants.baseUri + AppConstants.getDriverRouteUri + '$userId'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      final Map<String, dynamic> responseData = json.decode(res.body);

      setState(() {
        final List<dynamic> data = responseData['data'];
        _routeList = data.map((item) => Route.fromJson(item)).toList();
      });

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white, size: 30),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SaveRoute();
          }));
        },
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 10,
      ),
      appBar: const CustomRiderAppBar(title: 'CARNE DE ROUTE ', isBack: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: [
                !_isLoading ?
               _routeList.isNotEmpty ? Container(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: PaginatedDataTable(
                      header: const Text(
                        "CARNE DE ROUTE HISTORY",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 3,
                            color: Colors.black45),
                      ),
                      rowsPerPage: _rowsPerPage,
                      availableRowsPerPage: const <int>[5, 10, 20],
                      onRowsPerPageChanged: (int value) {
                        if (value != null) {
                          setState(() => _rowsPerPage = value);
                        }
                      },
                      columns: kTableColumns,
                      source: DessertDataSource(_routeList, context), // Pass the BuildContext
                    ),
                  ),
                ) :const NoDataScreen():const Center(child: CircularProgressIndicator(),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const kTableColumns = <DataColumn>[
  DataColumn(
    label: Text(
      'DateTime Out',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  DataColumn(
    label: Text(
      'DateTime In',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    tooltip: 'the returning date time',
    numeric: true,
  ),
  DataColumn(
    label: Text(
      'Car Name',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    numeric: true,
  ),
  DataColumn(
    label: Text(
      'Plate Number',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  DataColumn(
    label: Text(
      'Car Type',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  DataColumn(
    label: Text(
      'Destination',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  DataColumn(
    label: Text(
      'Km Out',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    numeric: true,
  ),
  DataColumn(
    label: Text(
      'Km In',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    numeric: true,
  ),
  DataColumn(
    label: Text(
      'Difference',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    numeric: true,
    tooltip: 'the difference between kilometrage out and Kilometrage .',
  ),
  DataColumn(
    label: Text(
      'Action',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    numeric: true,
  ),
];

class Route {
  final int id;
  final String car_name;
  final String plate_number;
  final String car_type;
  final int km_in;
  final String destination;
  final int km_out;
  final String datetimeIn;
  final String dateTimeOut;
  final String date;

  Route(
      this.car_name,
      this.plate_number,
      this.car_type,
      this.km_in,
      this.destination,
      this.km_out,
      this.datetimeIn,
      this.dateTimeOut,
      this.id,
      this.date,
      );

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      json['car_name'],
      json['plate_number'],
      json['car_type'],
      json['km_in'] as int,
      json['destination'],
      int.tryParse(json['km_out'].toString()) ?? 0,
      json['datetimeIn'],
      json['dateTimeOut'],
      json['id'] as int,
      json['date'],
    );
  }
}

class DessertDataSource extends DataTableSource {
  DessertDataSource(this._routes, this.context); // Accept the BuildContext in the constructor

  final List<Route> _routes;
  final BuildContext context; // Add a variable to hold the BuildContext

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _routes.length) return null;
    final Route dessert = _routes[index];
    var diff=dessert.km_out - dessert.km_in;
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(
          Text('${dessert.date} ${dessert.dateTimeOut}'),
        ),
        DataCell(

          dessert.datetimeIn == null ? Text('${dessert.date} ${dessert.datetimeIn}') : const Text("No return"),
        ),
        DataCell(
          Text(dessert.car_name),
        ),
        DataCell(
          Text('${dessert.plate_number}'),
        ),
        DataCell(
          Text(dessert.car_type.toString()),
        ),
        DataCell(
          Text(dessert.destination.toString()),
        ),
        DataCell(
          Text('${dessert.km_out}'),
        ),
        DataCell(
          Text('${dessert.km_in}'),
        ),
        DataCell(
          Text('$diff'),
        ),
        DataCell(
         ElevatedButton(
            onPressed: () {
              showDialog(
                context: context, // Use the stored BuildContext
                builder: (BuildContext dialogContext) {
                  return MyFormModal(id: dessert.id);
                },
              );
            },
            child: const Text("add time in"),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => _routes.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}