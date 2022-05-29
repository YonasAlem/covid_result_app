import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    Key? key,
    required this.controller,
    this.isPassword = false,
    this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isPassword;
  final String? hintText;

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
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        isDense: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          letterSpacing: 1,
          color: Colors.grey[300],
          fontSize: 14,
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
            color: Colors.blue.withOpacity(0.3),
          ),
        ),
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () => setState(() => isHiddenPassword = !isHiddenPassword),
                child: Icon(
                  isHiddenPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: isHiddenPassword ? Colors.grey : Colors.blue,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
