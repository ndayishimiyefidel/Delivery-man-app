import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatefulWidget {
  @override
  _CustomDropdownFormFieldState createState() => _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3'];
  String selectedValue;

  bool isDropdownOpened = false;
  double dropdownHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        setState(() {
          isDropdownOpened = !isDropdownOpened;
          dropdownHeight = isDropdownOpened ? 150.0 : 0.0;
        });
      },
      decoration: const InputDecoration(
        labelText: 'Select an option',
        border: OutlineInputBorder(),
      ),
      readOnly: true,
      controller: TextEditingController(text: selectedValue),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      onFieldSubmitted: (_) {
        setState(() {
          isDropdownOpened = false;
          dropdownHeight = 0.0;
        });
      },
      onEditingComplete: () {
        setState(() {
          isDropdownOpened = false;
          dropdownHeight = 0.0;
        });
      },
      showCursor: false,
      enableInteractiveSelection: false,

    );
  }
}