import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task/Util.dart';
import 'package:task/app_routes.dart';
import 'package:task/label_edit_text_field.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key, this.map}) : super(key: key);

  final dynamic map;

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with TickerProviderStateMixin {
  final FocusNode _emailTextFieldFocus = FocusNode();
  final FocusNode _currentPasswordFocus = FocusNode();

  final TextEditingController _emailFieldController = TextEditingController(text: "dani@yopmail.com");
  final TextEditingController _passwordFieldController = TextEditingController(text: "Qwerty@123");

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              LabeledEditText(
                textInputType: TextInputType.emailAddress,
                currentFocus: _emailTextFieldFocus,
                nextFocus: _currentPasswordFocus,
                controller: _emailFieldController,
                labelText: "Email",
                validator: Util.emailValidate,
              ),
              const SizedBox(height: 10),
              LabeledEditText(
                labelText: "Password",
                textInputType: TextInputType.visiblePassword,
                currentFocus: _currentPasswordFocus,
                controller: _passwordFieldController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  return Util.validateValue(value!, "Password");
                },
                obscure: true,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                child: const Text("Sign in"),
                onPressed: () {
                  Util.hideKeyBoard(context);
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.productsView, (route) => false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
