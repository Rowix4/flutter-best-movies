import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CredentialsErrorPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Erreur'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0)),
            Text('Email ou mot de passe incorrect'),
          ],
        ),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}