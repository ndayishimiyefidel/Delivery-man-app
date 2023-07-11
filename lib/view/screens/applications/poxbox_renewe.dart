import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/localization_controller.dart';
import '../../../data/model/response/box_model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/styles.dart';
import '../../base/custom_button.dart';
import '../../base/custom_home_app_bar.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';
import '../order_history/physical_pob.dart';
class PoxRenew extends StatefulWidget {
  const PoxRenew({Key key}) : super(key: key);

  @override
  State<PoxRenew> createState() => _PoxRenewState();
}

class _PoxRenewState extends State<PoxRenew> {
  SharedPreferences localStorage;
  var loggedInUserId;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _customerNameFocus = FocusNode();
  final FocusNode _customerPhoneFocus = FocusNode();
  final FocusNode _customerPriceFocus = FocusNode();
  final FocusNode _customerPobCategoryFocus = FocusNode();
  final FocusNode _customerPoxBoxFocus = FocusNode();


  TextEditingController _emailController;
  TextEditingController _customerNameController;
  TextEditingController _customerPhoneController;
  TextEditingController _customerPriceController;
  TextEditingController _customerPobCategoryController;
  TextEditingController _customerPoxBoxController;
  TextEditingController _customerPobTypeController;
  TextEditingController _customerBranchNameController;



  GlobalKey<FormState> _formKeyLogin;
  bool _isLoading=false;

  @override
  void initState() {
    super.initState();
    _getLocalData();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _customerNameController = TextEditingController();
    _customerPhoneController=TextEditingController();
    _customerPriceController=TextEditingController();
    _customerPobCategoryController=TextEditingController();
    _customerPoxBoxController=TextEditingController();
    _customerBranchNameController=TextEditingController();
    _customerPobTypeController=TextEditingController();
  }
  int bid=0;
  int boxId=0;
  fetchPoxBoxBbId(String pobId) async {
    int parsedPobId = int.tryParse(pobId);
    int parsedUserId = int.tryParse(loggedInUserId.toString());

    if (parsedPobId != null && parsedUserId != null) {
      String url = '$parsedPobId?loggedInUserId=$parsedUserId';
      try {
        final response = await http.get(Uri.parse(AppConstants.baseUri + AppConstants.customerPobUri + url));
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          if (jsonData is List && jsonData.isNotEmpty) {
            final firstItem = jsonData[0];

            // Verify that the 'name' and 'email' keys exist in the first item
            if (firstItem.containsKey('name') && firstItem.containsKey('email')) {
              final customerName = firstItem['name'];
              final customerEmail = firstItem['email'];
              final customerPhone = firstItem['phone'];
              final amount = firstItem['amount'];
              final boxType = firstItem['serviceType'];
              final boxCategory = firstItem['pob_category'];
              var branch = firstItem['branch'];
              final branchName = branch['name'];
              final branch_id = firstItem['branch_id'];
              final box=firstItem['id'];

              setState(() {
                _customerNameController.text = customerName;
                _emailController.text = customerEmail;
                _customerPhoneController.text = customerPhone;
                _customerPriceController.text = amount.toString();
                _customerPobCategoryController.text = boxCategory;
                // _customerPoxBoxController.text = boxType;
                _customerBranchNameController.text = branchName;
                _customerPobTypeController.text = boxType;
                bid = branch_id;
                boxId=box;
              });
            }

          }else{
            _customerNameController.text = '';
            _emailController.text = '';
            _customerPhoneController.text = '';
            _customerPriceController.text = '';
            _customerPobCategoryController.text = '';
            _customerBranchNameController.text = '';
            _customerPobTypeController.text = '';
           // showCustomSnackBar('No data found');
          }
        } else {
          _customerNameController.text = '';
          _emailController.text = '';
          _customerPhoneController.text = '';
          _customerPriceController.text = '';
          _customerPobCategoryController.text = '';
          _customerBranchNameController.text = '';
          _customerPobTypeController.text = '';
    showCustomSnackBar('No data found"');
        }
      } catch (e) {
    showCustomSnackBar('check internet connection');
      }
    }
  }


  _getLocalData() async {
    localStorage = await SharedPreferences.getInstance();
    var userJson=localStorage.getString("user");
    var user = json.decode(userJson);
    loggedInUserId=user['id'];
    print("koggin user");
    print(loggedInUserId);

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
  Future<void> submitForm() async {
    if (_formKeyLogin.currentState.validate()) {
      _formKeyLogin.currentState.save();

      setState(() {
        _isLoading = true;
      });

      try {
        // Prepare the form data to be sent
        int amount=int.tryParse(_customerPriceController.text);
        int pob=int.tryParse(_customerPoxBoxController.text);
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(AppConstants.baseUri+AppConstants.customerRenewApplicationUri),
        );
        request.fields['email'] = _emailController.text;
        request.fields['name'] = _customerNameController.text;
        request.fields['phone'] = _customerPhoneController.text;
        request.fields['amount'] = '$amount';
        request.fields['pob_category'] = _customerPobCategoryController.text;
        request.fields['pob'] = '$pob';
        request.fields['pob_type'] = _customerPobTypeController.text;
        request.fields['customer_id'] = '$loggedInUserId';
        request.fields['branch_id'] = '$bid';
        request.fields['id'] = '$boxId';

        if (selectedFile != null) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'attachment',
              selectedFile.path,
            ),
          );
        }

        // Send the request to the Laravel API
        final response = await request.send();

        if (response.statusCode == 201) {
          // Form data saved successfully
          // You can handle the response here, e.g., show a success message
          // or navigate to another screen
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
        else
        {
          // Form data failed to save
          // You can handle the error here, e.g., show an error message
          showCustomSnackBar('Failed to submit your application '.tr);
          setState(() {
            _isLoading=false;
          });
        }
      } catch (e) {
        // Error occurred while saving form data
        // You can handle the error here, e.g., show an error message
        print(e);
        showCustomSnackBar('An error occurred while applying physical pox.'.tr);
        setState(() {
          _isLoading=false;
        });
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _customerPriceController.dispose();
    _customerPobCategoryController.dispose();
    _customerPoxBoxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'P.O. Box  RENEW'.tr, isSwitch: false,isBack:true),
      body: SingleChildScrollView(
        child: Form(
          key: _formKeyLogin,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            child: Column(
              children: [
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
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: _customerPoxBoxController,
                    focusNode: _customerPoxBoxFocus,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'search Your P.O.Box..',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter pob';
                      }
                      return null;
                    },
                    onSaved: (value) {
                    },
                  onChanged: (newValue){
                    fetchPoxBoxBbId(newValue);
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
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    readOnly: true,
                    controller: _customerBranchNameController,
                    focusNode: _customerPobCategoryFocus,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Branch Name',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Pox Box';
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
                    readOnly: true,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    controller: _customerNameController,
                    focusNode: _customerNameFocus,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your full name',
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
                    readOnly: true,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    focusNode: _emailFocus,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email Address',
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
                        return 'Please enter phone';
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
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: _customerPobCategoryController,
                    focusNode: _customerPobCategoryFocus,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'P.O Box Category',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Pox Box';
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
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: _customerPobTypeController,
                    focusNode: _customerPobCategoryFocus,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'P.O Box Type',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Pox Box';
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
                    readOnly: true,
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
                        return 'Please enter price';
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
                        children:  const [
                          Icon(
                            Icons.attach_file,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Attachment Natinal ID',
                            style: TextStyle(
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
                              selectedFilePath,
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

                        submitForm();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                _isLoading ? Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                )):const Center(child: SizedBox(width: 0,),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
