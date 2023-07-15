import 'package:flutter/material.dart';

Widget textFormField(
  TextEditingController controller,
  String hintText,
  FormFieldValidator<String> validator,
  bool obscureText,
  IconData icon,
  TextInputType keyType,
) {
  return TextFormField(
    obscureText: obscureText,
    controller: controller,
    keyboardType: keyType,
    style: const TextStyle(
      fontSize: 16.0,
      // height: 1.8,
      color: Colors.black,
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      labelText: hintText,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
    ),
    validator: validator,
  );
}
