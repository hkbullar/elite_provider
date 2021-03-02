
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/EliteAppBar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget
{
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var _oldPassController = TextEditingController();
  var _newPassController = TextEditingController();
  var _conPassController = TextEditingController();

  final FocusNode _oldPassFocus = FocusNode();
  final FocusNode _newPassFocus = FocusNode();
  final FocusNode _conPassFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EliteAppBar("Change Password"),
      backgroundColor: AppColours.black,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [

            TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              validator: (value) => value.isEmpty ? 'Password cannot be blank': null,
              textInputAction: TextInputAction.next,
              controller: _oldPassController,
              style: TextStyle(color: Colors.white),
              focusNode: _oldPassFocus,
              onFieldSubmitted: (term)
              {
                _fieldFocusChange(context, _oldPassFocus, _newPassFocus);
              },
              decoration: CommonWidgets.loginFormDecoration("Old Password",Icons.lock_outline),
            ),
            SizedBox(height: 20),
            TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              validator: (value) => value.isEmpty ? 'Password cannot be blank': null,
              textInputAction: TextInputAction.next,
              controller: _newPassController,
              style: TextStyle(color: Colors.white),
              focusNode: _newPassFocus,
              onFieldSubmitted: (term)
              {
                _fieldFocusChange(context, _newPassFocus, _conPassFocus);
              },
              decoration: CommonWidgets.loginFormDecoration("New Password",Icons.lock_outline),
            ),
            SizedBox(height: 20),
            TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              validator: (value) => value.isEmpty ? 'Password cannot be blank': null,
              textInputAction: TextInputAction.next,
              controller: _conPassController,
              style: TextStyle(color: Colors.white),
              focusNode: _conPassFocus,
              decoration: CommonWidgets.loginFormDecoration("Confirm New Password",Icons.lock_outline),
            ),
            SizedBox(height: 20),
            CommonWidgets.goldenFullWidthButton("Change Password",onClick: (){})
          ],
        ),
      )
    );
  }
  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}