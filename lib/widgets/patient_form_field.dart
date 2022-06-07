import 'package:flutter/material.dart';

class PatientFormField extends StatelessWidget {
  const PatientFormField({
    Key? key,
    this.text,
    this.editingController,
    this.hintText,
    this.suffixIcon,
    this.activeBorderColor = Colors.red,
    this.readOnly = false,
    this.errorMessage,
  }) : super(key: key);
  final String? text;
  final TextEditingController? editingController;
  final String? hintText;
  final Widget? suffixIcon;
  final Color activeBorderColor;
  final bool readOnly;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (text != null)
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              text ?? '',
              style: TextStyle(
                letterSpacing: 1,
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
          ),
        if (text != null) const SizedBox(height: 5),
        TextFormField(
          readOnly: readOnly,
          controller: editingController,
          style: TextStyle(color: Colors.grey.shade600, letterSpacing: 1),
          decoration: InputDecoration(
            errorText: errorMessage,
            errorMaxLines: 1,
            contentPadding: const EdgeInsets.all(15),
            isDense: true,
            hintText: hintText,
            suffixIcon: suffixIcon,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.5),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.5),
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.4),
              fontSize: 15,
              letterSpacing: 1,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: activeBorderColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
