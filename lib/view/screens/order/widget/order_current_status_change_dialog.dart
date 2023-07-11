import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_date_picker.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_text_field.dart';

class OrderStatusUpdateDialog extends StatefulWidget {
  final String icon;
  final String title;
  final Function onYesPressed;
  final bool isReschedule;
  final bool isResume;
  const OrderStatusUpdateDialog({Key key, @required this.icon, this.title,@required this.onYesPressed, this.isReschedule = false, this.isResume = false}) : super(key: key);

  @override
  State<OrderStatusUpdateDialog> createState() => _OrderStatusUpdateDialogState();
}

class _OrderStatusUpdateDialogState extends State<OrderStatusUpdateDialog> {

  final TextEditingController _reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if(widget.isResume){
      Get.find().setReason('resume', reload: false);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      child: GetBuilder(
        builder: (orderController) {
          return Padding(
            padding:  EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(mainAxisSize: MainAxisSize.min, children: [

              Padding(padding:  EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Container(
                  padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Theme.of(context).primaryColor, width: 2)
                  ),
                    child: Image.asset(widget.icon, width: Get.context.width<= 400? 20 : 50, height:Get.context.width<= 400? 20 : 50)),
              ),

              widget.title != null ? Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: Text(widget.title, textAlign: TextAlign.center,
                  style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColor),
                ),
              ) : const SizedBox(),



              if(widget.isReschedule)Padding(
                padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault,horizontal: Dimensions.paddingSizeDefault),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.25))
                  ),
                  child: CustomDatePicker(
                    text: orderController.startDate != null ?
                    orderController.dateFormat.format(orderController.startDate).toString() : 'select_date'.tr,
                    image: Images.calenderIcon,
                    requiredField: true,
                    selectDate: () => orderController.selectDate(context),
                  ),
                ),
              ),



              widget.isResume ? const SizedBox():
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
                child: Container(padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: .5, color: Theme.of(context).hintColor.withOpacity(.7)),
                  ),
                  child: DropdownButton<String>(

                    hint: orderController.reasonValue == ''? Text('select_reason'.tr, style: rubikRegular,) : Text(orderController.reasonValue.tr,
                      style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
                    items: orderController.reasonList.map((String value) {
                      return DropdownMenuItem<String>(
                        alignment: Alignment.center,
                          value: value,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(value.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                              Divider(thickness: .25,color: Theme.of(context).hintColor),
                            ],
                          ));}).toList(),
                    onChanged: (val) {

                      orderController.setReason(val);
                      },
                    isExpanded: true,
                    underline: const SizedBox(),
                  ),
                ),
              ),

              orderController.reasonValue == 'other'?
              Padding(
                padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault,
                ),
                child: CustomTextField(isShowBorder: true,
                  controller: _reasonController,),
              ): const SizedBox.shrink(),


               SizedBox(height: Dimensions.paddingSizeLarge),

              CustomButton(
                btnTxt: 'submit'.tr,
                onTap: () {
                  if(orderController.reasonValue == ''){
                    showCustomSnackBar('reason_is_required'.tr);
                  }else{
                    widget.onYesPressed();
                  }
                },
              )

            ]),
          );
        }
      ),
    );
  }
}