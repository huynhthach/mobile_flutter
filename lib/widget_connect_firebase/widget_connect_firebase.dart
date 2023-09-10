import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class MyFirebaseConnect extends StatefulWidget {
  final String? errorMessage;
  final String? connectingMessage;
  final Widget Function(BuildContext context)? builder;
  const MyFirebaseConnect({Key? key,required this.errorMessage,required this.connectingMessage
  ,required this.builder}) : super(key: key);

  @override
  _MyFirebaseConnectState createState() => _MyFirebaseConnectState();
}

class _MyFirebaseConnectState extends State<MyFirebaseConnect> {
  bool ketnoi=false;
  bool loi=false;
  @override
  Widget build(BuildContext context) {
    if(loi)
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(widget.errorMessage!
          ,style: TextStyle(fontSize: 18,color: Colors.red),
          textDirection: TextDirection.ltr,
          ),
        ),
      );
    else if(ketnoi)
      return Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text(widget.connectingMessage!,
              style: TextStyle(fontSize: 16),
              textDirection: TextDirection.ltr,
              )
            ],
          )
        ),
      );
    else
      return widget.builder!(context);
  }

  @override
  void initState() {
    super.initState();
    _khoitaofirebase();
  }

  _khoitaofirebase() async{
    Firebase.initializeApp()
      .then((value) {
        setState(() {
          ketnoi==true;
        });
    })
      .catchError((error) {
        print(error);
        setState(() {
          loi=true;
        });
    })
      .whenComplete(() => print("complete"));
  }
}
