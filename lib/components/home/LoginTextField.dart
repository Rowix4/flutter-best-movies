import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final bool isEmail;
  final Function validator;

  LoginTextField({
    this.controller,
    this.isPassword = false,
    this.isEmail = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      obscureText: isPassword ? true : false,
      decoration: InputDecoration(
        hintText: isPassword ? "Mot de passe" : "Email",
        hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white30,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        prefixIcon: isPassword ? const Icon(
         Icons.security,
         color: Colors.white,
        ) : const Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
      ),
      validator: validator,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
    );
  }
}