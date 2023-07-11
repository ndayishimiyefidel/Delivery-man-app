import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PermissionDialog extends StatelessWidget {
  final bool isDenied;
  final Function onPressed;
  const PermissionDialog({Key key,  @required this.isDenied, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('alert'.tr),
      content: Text(isDenied ? 'you_denied'.tr : 'you_denied_forever'.tr),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [ElevatedButton(
        onPressed: onPressed,
        child: Text(isDenied ? 'ok'.tr : 'settings'.tr),
      )],
    );
  }
}
