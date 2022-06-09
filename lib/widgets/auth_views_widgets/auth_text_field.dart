import 'package:covid_result_app/utils/colors.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    this.isPassword = false,
    this.hintText,
    this.error,
    this.borderColor,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isPassword;
  final String? hintText;
  final String? error;
  final Color? borderColor;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword && isHiddenPassword ? true : false,
      autocorrect: widget.isPassword && isHiddenPassword ? true : false,
      style: TextStyle(
        color: Colors.grey.shade700,
        letterSpacing: 1,
      ),
      keyboardType:
          widget.isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        isDense: true,
        fillColor: Colors.white,
        filled: true,
        hintText: widget.hintText,
        errorText: widget.error,
        hintStyle: TextStyle(
          letterSpacing: 1,
          color: Colors.grey[300],
          fontSize: 14,
        ),
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.grey.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: widget.borderColor ?? mainColor.withOpacity(0.3),
          ),
        ),
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () => setState(() => isHiddenPassword = !isHiddenPassword),
                child: Icon(
                  isHiddenPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: isHiddenPassword ? Colors.grey : mainColor,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
