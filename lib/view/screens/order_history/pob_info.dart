import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/payment_modal.dart';
import '../../../data/model/response/box_model.dart';
import '../../../utill/app_constants.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/no_data_screen.dart';
class PobInfo extends StatefulWidget {
  final int pob;
  int year;
  int amount;
  int id;
  int bid;
  final String name;
  final String serviceType;
  PobInfo({Key key,this.serviceType, this.name,this.bid, this.id,this.pob,this.amount,this.year}) : super(key: key);

  @override

  State<PobInfo> createState() => _PobInfoState();
}

class _PobInfoState extends State<PobInfo> {
  SharedPreferences localStorage;
  bool isCustomerLogin=false;
  bool _loading = false;
  List<dynamic> _listPob = [];
  List<Payments> _payInfo = [];
  bool _sortAscending = true;
  int _sortColumnIndex = 0;
  int amount=0;
  int year=0;
  @override
  void initState() {
    _getLocalData();
    print(widget.pob);
    super.initState();
    loadPoxInfo();
    _fetchPayment();

  }
  Future<void> _fetchPayment() async {
    final response = await http.get(Uri.parse(AppConstants.baseUri + AppConstants.customerPaymentsUri+'${widget.id}'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print("json data");
      print(jsonData);

      if (jsonData['success'] == true && jsonData['data'] != null) {
        setState(() {
          _payInfo = List<Payments>.from(jsonData['data'].map((payment) => Payments.fromJson(payment)));
        });
      }
    } else {
      // Handle error cases
    }
  }



  void _sort<T>(Comparable<T> Function(Payments box) getField, int columnIndex,
      bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      _payInfo.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    });
  }

  Widget _buildSortArrow(bool ascending) {
    if (ascending) {
      return const Icon(Icons.arrow_upward);
    } else {
      return const Icon(Icons.arrow_downward);
    }
  }
  final DateTime now = DateTime.now();

  int rentYear=0;
  double penalities=0.0;
  int totalRent=0;
  double total=0;
  int chargeYear=0;
  double initialPenalities=0.0;
  _getLocalData() async {
    localStorage = await SharedPreferences.getInstance();
    isCustomerLogin=localStorage.getBool("isCustomerLogin");
    print(isCustomerLogin);
    setState(() {
      year=widget.year;///database year
      amount=widget.amount;
      rentYear=now.year-year;
      totalRent=amount*rentYear;
      if(now.month==1 && now.day<=31){
        if(year==now.year)
          {
            penalities=0.0;
            chargeYear=0;
            initialPenalities=0.0;
          }
        else{
          chargeYear=now.year-year-1;
          penalities=(amount*0.25)*(chargeYear);
          initialPenalities=(amount*0.25);
        }
      }
      else{
        chargeYear=now.year-year;
        penalities=(amount*0.25)*(chargeYear);
        initialPenalities=amount*0.25;
      }
      total=totalRent+(amount*0.25*chargeYear);

    });
  }

  loadPoxInfo() async {
    setState(() {
      _loading = true;
    });
    localStorage= await SharedPreferences.getInstance();
    var userJson=localStorage.getString("user");
    var user = json.decode(userJson);
    var loggedInUserId=user['id'];
    final res = await http.get(Uri.parse(AppConstants.baseUri+AppConstants.customerHisPoxBoxUri+'${widget.pob}'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      // print(jsonData);
      if (jsonData['data'].isNotEmpty) {
        setState(() {
          _listPob = jsonData['data'];

        });
      }
      setState(() {
        _loading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white, size: 30),
          onPressed: () {
            showDialog(
              context: context, // Use the stored BuildContext
              builder: (BuildContext dialogContext) {
                return PaymentModal(id: widget.id,amount: total,numberYear:rentYear,pob: widget.pob,bid: widget.bid,name: widget.name,serviceType: widget.serviceType,lastPaidYear: widget.year,);
              },
            );
          },
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 10,
        ),
        appBar: CustomRiderAppBar(title:'P.O BOX INFORMATION'.tr,isBack:true),

        body:SingleChildScrollView(
          child: Column(children: [
            _loading ?const Center(child: CircularProgressIndicator()) :_listPob.isNotEmpty
                ? SizedBox(
              height: MediaQuery.of(context).size.height*0.27,
                  child: ListView.builder(
              itemCount: _listPob.length,
              itemBuilder: ((context, index) {
                  final branchesList = _listPob[index];
                  final branch = branchesList['branch'];
                  return Card(
                    // color: Colors.white24,
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10.0,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("P.O. Box ${_listPob[index]['pob']}  ${branch['name']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Theme.of(context).primaryColor),),
                            const SizedBox(height: 5,),
                            Text("P.O.Box Type: ${_listPob[index]['pob_type']}"),
                            const SizedBox(height: 5,),
                            Text("Owner Name: "+_listPob[index]['name'],style: const TextStyle(),),
                            const SizedBox(height: 5,),
                            Text("phone Number: ${_listPob[index]['phone']}"),
                            const SizedBox(height: 5,),
                            Text("Size: ${_listPob[index]['size']}"),
                            const SizedBox(height: 5,),
                            Text("Date: ${_listPob[index]['date']}"),
                            const SizedBox(height: 5,),
                            Text("Payment Amount: $total RWF"),
                            const SizedBox(height: 5,),
                            total==0?const Text("PAID",style: TextStyle(color: Colors.green),):const Text("UNPAID",style: TextStyle(color: Colors.red),),
                            const SizedBox(height: 5,),
                          ],
                        )
                    ),
                  );

              }),
            ),
                ) : const Center(child: NoDataScreen()),
            const Text(
              "P.O BOX PAYMENT AMOUNT ",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: Colors.black45),

            ),
            const SizedBox(height: 20,),
            Card(
    // color: Colors.white24,
    elevation: 10,
    margin: const EdgeInsets.symmetric(
    horizontal: 15.0,
    vertical: 10.0,
    ),
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
    child:
    Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
          Text("UNPAID TYPE",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black),),
          Text("YEAR",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black),),
          Text("CHARGES",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black),),
          Text("AMOUNT",style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black),),
      ],
    ),
      const SizedBox(height: 20,),

      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("PENALITES",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black),),
            Text("$rentYear",style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black),),
            Text("$initialPenalities",style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black),),
            Text("$penalities",style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black),),
          ],
      ),
      const SizedBox(height: 10,),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("P.O BOX RENT",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black),),
            Text("$rentYear",style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black),),
            Text("$amount",style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black),),
            Text("$totalRent",style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black),),
          ],
      ),

    ],
    )
    ),
    ),
            const SizedBox(height: 30,),

            const Text(
              "P.O BOX PAYMENT HISTORY ",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: Colors.black45),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 10.0,
                    horizontalMargin: 10.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    columns:  [
                      DataColumn(
                        label: Row(
                          children:  [
                            const Text(
                              'NO',
                              style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black45),
                            ),
                            if (_sortColumnIndex == 0)
                              _buildSortArrow(_sortAscending),
                          ],
                        ),
                        onSort: (columnIndex, ascending) {
                          _sort((Payments box) => box.id, columnIndex, ascending);
                        },
                      ),
                      DataColumn(
                        label: Row(
                          children:  [
                            const Text(
                              'AMOUNT',
                              style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black45),
                            ),
                            if (_sortColumnIndex == 1)
                              _buildSortArrow(_sortAscending),
                          ],
                        ),
                        onSort: (columnIndex, ascending) {
                          _sort((Payments box) => box.amount, columnIndex, ascending);
                        },
                      ),
                      DataColumn(
                        label: Row(
                          children:  [
                            const Text(
                              'YEAR',
                              style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black45),
                            ),
                            if (_sortColumnIndex == 2)
                              _buildSortArrow(_sortAscending),
                          ],
                        ),
                        onSort: (columnIndex, ascending) {
                          _sort((Payments box) => box.year, columnIndex, ascending);
                        },
                      ),
                      DataColumn(
                        label: Row(
                          children:  [
                            const Text(
                              'DATE',
                              style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black45),
                            ),
                            if (_sortColumnIndex == 3)
                              _buildSortArrow(_sortAscending),
                          ],
                        ),
                        onSort: (columnIndex, ascending) {
                          _sort((Payments box) => box.date, columnIndex, ascending);
                        },
                      ),

                    ],
                    rows: _payInfo.map((box) {
                      String dateString = box.date;
                      DateTime dateTime = DateTime.parse(dateString);
                      String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
                      return DataRow(
                        cells: [
                          DataCell(
                            Text("${box.id}"),
                          ),
                          DataCell(
                            Text("${box.amount}"),
                          ),
                          DataCell(
                            Text("${box.year}"),
                          ),
                          DataCell(
                            Text(formattedDate),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],),
        )
    );
  }
}