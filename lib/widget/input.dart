import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputText extends StatelessWidget {
  @required void Function(String) validator; 
  FocusNode focusNode; 
  int maxLines; 
  TextInputType keyboardType;
  TextInputAction textInputAction;
  void Function(String) onFieldSubmitted; 
  @required void Function(String) onSaved;
  bool obscureText, isPassword;
  @required String label;
  void Function() hintTap;
  TextEditingController controller;
  bool enabled, bordered;
  
  InputText({
    Key key, 
    @required this.validator,
    this.focusNode, 
    this.maxLines = 1, 
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted, 
    @required this.onSaved,
    this.obscureText = false,
    @required this.label,
    this.isPassword = false,
    this.hintTap,
    this.controller,
    this.enabled = true,
    this.bordered = false
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      obscureText: obscureText,
      enabled: enabled,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.0, 16.0, 20.0, 16.0),
        labelText: label,
        suffixIcon: isPassword ? InkWell(
          onTap: hintTap,
          child: Icon(!obscureText ? FontAwesomeIcons.eye:FontAwesomeIcons.eyeSlash),
        ):null,
        border: !bordered ? null : OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.pinkAccent))
      ),
    );
  }
}