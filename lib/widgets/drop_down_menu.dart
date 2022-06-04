import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownMenu extends StatelessWidget {
  const DropDownMenu({
    Key? key,
    required this.hint,
    required this.menuList,
    this.selectedItem,
    this.onChanged,
  }) : super(key: key);

  final String hint;
  final List<String> menuList;
  final String? selectedItem;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        value: selectedItem,
        hint: Text(
          hint,
          style: TextStyle(
            color: Colors.grey.shade700,
            letterSpacing: 1,
          ),
        ),
        items: menuList.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                color: Colors.grey.shade700,
                letterSpacing: 1,
              ),
            ),
          );
        }).toList(),
        style: TextStyle(
          color: Colors.grey.shade700,
          letterSpacing: 1,
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        onChanged: onChanged,
        buttonHeight: 42,
        buttonWidth: double.maxFinite,
        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        itemHeight: 40,
      ),
    );
  }
}
