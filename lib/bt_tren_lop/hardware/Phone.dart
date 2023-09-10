import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneApp extends StatefulWidget {
  PhoneApp({Key? key}) : super(key: key);

  @override
  State<PhoneApp> createState() => _PhoneAppState();
}

class _PhoneAppState extends State<PhoneApp> {
  String? phone = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("phone"),
      ),
      body: Column(
        children: [
          TextFormField(
            onChanged: (value) => phone=value,
            validator: (value) => _validator(value),
            decoration: InputDecoration(
              labelText: "Phone",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    launchUrl(Uri(scheme: "tel",path: phone));
                  },
                  child: Text("call"),
              )
            ],
          )
        ],
      ),
    );
  }
  _validator(String? value){
    if(value==null){
      return "ban chua nhap vao phone";
    }else return "hop le";
  }
}

