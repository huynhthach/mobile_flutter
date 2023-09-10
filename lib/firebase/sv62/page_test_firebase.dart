import 'package:flutter/material.dart';

import '../../widget_connect_firebase/widget_connect_firebase.dart';

class TestFirebaseApp extends StatelessWidget {
  const TestFirebaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      errorMessage: "loi ket noi",
      connectingMessage: "dang ket noi...",
      builder: (context) =>PageTestFirebase(),
    );
  }
}
class PageTestFirebase extends StatelessWidget {
  const PageTestFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my firebase app"),
      ),
    );
  }
}

