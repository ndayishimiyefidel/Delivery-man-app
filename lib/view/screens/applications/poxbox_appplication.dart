import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/data/model/response/search_pox_model.dart';
import 'package:sixvalley_delivery_boy/view/screens/applications/poxbox_renewe.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/physical_pob.dart';
import '../../../data/model/response/branch_model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/styles.dart';
import '../../base/custom_button.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/custom_snackbar.dart';
import 'package:http/http.dart' as http;
class PhysicalPoxBoxApplication extends StatefulWidget {
  const PhysicalPoxBoxApplication({Key key}) : super(key: key);

  @override
  State<PhysicalPoxBoxApplication> createState() => _PhysicalPoxBoxApplicationState();
}

class _PhysicalPoxBoxApplicationState extends State<PhysicalPoxBoxApplication> {


  SharedPreferences localStorage;
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _customerNameFocus = FocusNode();
  final FocusNode _customerPhoneFocus = FocusNode();
  final FocusNode _customerPriceFocus = FocusNode();
  final FocusNode _customerVirtualFocus = FocusNode();


  TextEditingController _emailController;
  TextEditingController _customerNameController;
  TextEditingController _customerPhoneController;
  TextEditingController _customerPriceController;
  TextEditingController _customerVirtualController;

  GlobalKey<FormState> _formKeyLogin;
  bool _isLoading=false;
  List<String> customerType = ['Individual', 'Company'];
  List<String> boxType = ['Physical', 'Virtual'];
  List<Branch> _postOffice =  [];
  List<SearchPox> _availableBox =  [];

  String selectedValue;
  String selectedBoxType;
  String selectedPostOffice;
  String selectedOffice;
  String selectedAvailableBox;
  int pobId;
  bool isDropdownOpened = false;
  bool isDropdownOpened1 = false;
  bool isDropdownOpened2 = false;
  bool isDropdownOpened3 = false;
  double dropdownHeight = 0.0;
  double dropdownHeight1 = 0.0;
  double dropdownHeight2 = 0.0;
  double dropdownHeight3 = 0.0;
  String errorMessage = '';

  var loggedInUserId;
  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _customerNameController = TextEditingController();
    _customerPhoneController=TextEditingController();
    _customerPriceController=TextEditingController();
    _customerVirtualController=TextEditingController();
    fetchBranches();
    _getLocalData();
  }
  _getLocalData() async {
    localStorage = await SharedPreferences.getInstance();
    var userJson=localStorage.getString("user");
    var user = json.decode(userJson);
    loggedInUserId=user['id'];
    print(loggedInUserId);

  }
  Future<void> fetchBranches() async {
    final response = await http.get(Uri.parse(AppConstants.baseUri+AppConstants.customerBranchUri));

    if (response.statusCode == 200) {
      final List<dynamic> branchData = jsonDecode(response.body);
      setState(() {
        _postOffice = branchData.map((item) => Branch.fromJson(item)).toList();
      });
    } else {
     print("errror");
    }
  }


  @override
  void dispose() {
    _emailController.dispose();
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _customerPriceController.dispose();
    _customerVirtualController.dispose();
    super.dispose();
  }

  String selectedFilePath;
  String fileName="";
  File selectedFile;

  Future<void> _openFilePicker() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      if (result.files.isNotEmpty) {
        String path = result.files.first.path;
        String name=result.files.first.name;
        if (path != null) {
          setState(() {
            selectedFilePath = path;
            fileName=name;
            selectedFile = File(result.files.single.path);
            print(selectedFile);
          });
        } else {
          // Handle case where path is null
          print('File path is null');
        }
      } else {
        // Handle case where no files were selected
        print('No files were selected');
      }
    } else {
      // Handle case where file picker was canceled
      print('File picker was canceled');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'P.O. Box  Application'.tr, isSwitch: false,isBack:true),
      body: SingleChildScrollView(
        child: Form(
          key: _formKeyLogin,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Text('APPLY NEW P.O. Box '.tr,style: rubikRegular.copyWith(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold)),
                ],),
                SizedBox(height: Dimensions.topSpace),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    focusNode: _emailFocus,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                    },
                    // Rest of your TextFormField properties
                  ),
                ),

                SizedBox(height: Dimensions.paddingSizeLarge),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _customerNameController,
                    focusNode: _customerNameFocus,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Full Name',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter full name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                    },
                    // Rest of your TextFormField properties
                  ),
                ),
                SizedBox(height: Dimensions.paddingSizeLarge),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    controller: _customerPhoneController,
                    focusNode: _customerPhoneFocus,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your Phone',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Phone';
                      }
                      return null;
                    },
                    onSaved: (value) {
                    },
                    // Rest of your TextFormField properties
                  ),
                ),

                SizedBox(height: Dimensions.paddingSizeLarge),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: SizedBox(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      value: selectedValue,
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text(
                            'Select customer type',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        ...customerType.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ],
                      onChanged: (String newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                    ),
                  ),
                )

                ,SizedBox(height: Dimensions.paddingSizeLarge),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: SizedBox(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      value: selectedBoxType,
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text(
                            'Select box type',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        ...boxType.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ],
                      onChanged: (String newValue) {
                        setState(() {
                          selectedBoxType = newValue;
                          getSelectedValue();
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.paddingSizeLarge),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: FutureBuilder<void>(
                    future: fetchBranches(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Error fetching branches');
                      } else {
                        return DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          value: selectedPostOffice ?? null,
                          hint: const Text('Select Branch'),
                          items: _postOffice.map((branch) {
                            return DropdownMenuItem<String>(
                              value: branch.name,
                              child: Text(branch.name),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            final selectedBranch = _postOffice.firstWhere((branch) => branch.name == newValue);
                            setState(() {
                              selectedPostOffice = newValue;
                              selectedOffice = selectedBranch.id;
                              getSelectedValue();
                            });
                          },
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: Dimensions.paddingSizeLarge),
                selectedBoxType=="Physical" ?
                pobId==null ?Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: FutureBuilder<void>(
                    future: fetchAvailablePox(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Error fetching PO Box');
                      } else {
                        return DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          value: selectedAvailableBox?? null,
                          hint: const Text('Select P.O Box'),
                          items: _availableBox.map((box) {
                            return DropdownMenuItem<String>(
                              value: box.pob,
                              child: Text(box.pob),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            print(selectedPostOffice);
                            print(selectedOffice);
                            setState(() {
                              selectedAvailableBox = newValue;
                              pobId=int.parse(newValue);

                            });
                          },
                        );
                      }
                    },
                  ),
                ):const SizedBox() :Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    controller: _customerVirtualController,
                    focusNode: _customerVirtualFocus,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone Virtual P.O Box',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                    },
                    // Rest of your TextFormField properties
                  ),
                ),


                SizedBox(height: Dimensions.paddingSizeLarge),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    controller: _customerPriceController,
                    focusNode: _customerPriceFocus,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Total price',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Priceless';
                      }
                      return null;
                    },
                    onSaved: (value) {
                    },
                    // Rest of your TextFormField properties
                  ),
                ),
                SizedBox(height: Dimensions.paddingSizeLarge),

            Column(
              children: [
                ElevatedButton(
                  onPressed: _openFilePicker,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      const Icon(
                        Icons.attach_file,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        selectedValue==""||selectedValue=="Individual"?'Attachment Natinal ID': '(RDB/RCA/RGB certificate)',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                selectedFilePath != null
                    ? Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.file_present),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          fileName,
                          style: const TextStyle(fontSize: 16.0),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
                    :Text(
                 fileName.isEmpty ? 'No file selected':fileName,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
                SizedBox(height: Dimensions.paddingSizeLarge,),
                SizedBox(height: Dimensions.paddingSizeLarge),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width/3.5),
                  child: CustomButton(
                    btnTxt: 'Submit'.tr,
                    onTap: () async {
                      String email = _emailController.text.trim();
                      String _customerName = _customerNameController.text.trim();
                      if (email.isEmpty) {
                        showCustomSnackBar('Enter Your Email Please'.tr);
                      }else if (_customerName.isEmpty) {
                        showCustomSnackBar('Enter your name'.tr);
                      }else {
                        ///pox box application
                        _poxBoxApplication();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                _isLoading ? Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                )):const Center(child: SizedBox(width: 0,),),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30,top: 20),
                  child: Row(
                    children: [
                      const Text("Already have P.O Box ?",style: TextStyle(fontSize: 14),),
                      const SizedBox(width: 10,),
                      GestureDetector(child: Text("Renew",style: TextStyle(fontSize: 13,color: Theme.of(context).primaryColor),),onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const PoxRenew();
                        }));

                      },),
                      const SizedBox(height: 20,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void getSelectedValue() {
    if(selectedValue=="Company" && selectedBoxType=="Physical" && selectedPostOffice=="KIGALI"){
      setState(() {
        _customerPriceController.text = "30000";
      });
    }
    else if(selectedValue=="Company" && selectedBoxType=="Physical" && selectedPostOffice!="KIGALI"){
      _customerPriceController.text = "18000";
    }
    else if(selectedValue=="Individual" && selectedBoxType=="Physical" && selectedPostOffice=="KIGALI"){
      _customerPriceController.text = "15000";
    }
    else if(selectedValue=="Individual" && selectedBoxType=="Physical" && selectedPostOffice!="KIGALI"){
      _customerPriceController.text = "12000";
    }
    else if(selectedBoxType=="Virtual"){
      _customerPriceController.text = "5000";

    }
  }
  Future<void> fetchAvailablePox() async {

    final response = await http.get(Uri.parse(AppConstants.baseUri+AppConstants.customerGetAvBranchUri+selectedOffice));

    if (response.statusCode == 200) {
      final List<dynamic> poxData = jsonDecode(response.body);
      setState(() {
        _availableBox = poxData.map((item) => SearchPox.fromJson(item)).toList();
      });
    } else {
      print("errror");
    }
  }

  Future<void> _poxBoxApplication() async {
    setState(() {
      _isLoading=true;
    });
    if (selectedFile == null) {
      showCustomSnackBar('Please select file'.tr);
      setState(() {
        _isLoading=false;
      });
      return;
    }
    ///handle request
    int amount=int.tryParse(_customerPriceController.text);
    int branch_id=int.tryParse(selectedOffice);

    // print(customer_id);
    if(selectedBoxType=="Physical"){
      int pob=int.tryParse(selectedAvailableBox);
      try {
        final request = http.MultipartRequest('POST', Uri.parse(AppConstants.baseUri+AppConstants.customerPoxBoxApplicationUri));
        request.fields['name'] = _customerNameController.text;
        request.fields['email'] = _emailController.text;
        request.fields['phone'] = _customerPhoneController.text;
        request.fields['amount'] = '$amount';
        request.fields['pob_type'] = selectedBoxType;
        request.fields['branch_id'] = '$branch_id';
        request.fields['pob'] = '$pob';
        request.fields['id'] = '$pobId';
        request.fields['pob_category'] = selectedValue;
        request.fields['customer_id'] = '$loggedInUserId';
        request.files.add(await http.MultipartFile.fromPath('attachment', selectedFile.path));

        final response = await request.send();

        if (response.statusCode == 201) {
          Fluttertoast.showToast(
            msg: "Your Application submitted success!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const PhysicalPob();
          }));
          //showCustomSnackBar('Your Application submitted success'.tr);
          setState(() {
            _isLoading=false;
          });
        }
        else if(response.statusCode == 422){
          showCustomSnackBar('Your application already Exists'.tr);
          setState(() {
            _isLoading=false;
          });
        }
        else {
          showCustomSnackBar('Failed to submit your application '.tr);
          setState(() {
            _isLoading=false;
          });
        }
      } catch (e) {
        print(e);
        showCustomSnackBar('An error occurred while applying physical pox.'.tr);
        setState(() {
          _isLoading=false;
        });
      }
    }
    else{

      ///virtual application
      int virtualPox=int.parse(_customerVirtualController.text);
      try {
        final request = http.MultipartRequest('POST', Uri.parse(AppConstants.baseUri+AppConstants.customerVirtualApplicationUri));
        request.fields['name'] = _customerNameController.text;
        request.fields['email'] = _emailController.text;
        request.fields['phone'] = _customerPhoneController.text;
        request.fields['pob_type'] = selectedBoxType;
        request.fields['branch_id'] = '$branch_id';
        request.fields['pob'] = '$virtualPox';
        request.fields['pob_category'] = selectedValue;
        request.fields['customer_id'] = '$loggedInUserId';
        request.files.add(await http.MultipartFile.fromPath('attachment', selectedFile.path));
        final response = await request.send();
        if (response.statusCode == 201) {
          Fluttertoast.showToast(
            msg: "Your Application submitted success!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const PhysicalPob();
          }));
          //showCustomSnackBar('Your Application submitted success'.tr,);
          setState(() {
            _isLoading=false;
          });
        }
        else if(response.statusCode == 422){
          showCustomSnackBar('Your application already Exists'.tr);
          setState(() {
            _isLoading=false;
          });
        }
        else {
          showCustomSnackBar('Failed to submit your application '.tr);
          setState(() {
            _isLoading=false;
          });
        }
      } catch (e) {
        print(e);
        showCustomSnackBar('An error occurred while uploading the file.'.tr);
        setState(() {
          _isLoading=false;
        });

      }
    }
  }
}
