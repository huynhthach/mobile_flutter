import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login.dart';


class PageRegister extends StatefulWidget {
  const PageRegister({Key? key}) : super(key: key);

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  String? ten;
  String? mk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) => ten = value,
              validator: (value) => _validator(value),
              decoration: InputDecoration(
                labelText: "Tài khoản",
              ),
            ),
            TextFormField(
              onChanged: (value) => mk = value,
              validator: (value) => _validator(value),
              decoration: InputDecoration(
                labelText: "Mật khẩu",
              ),
            ),
            ElevatedButton(
                onPressed: () async{
                  var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: ten!,
                    password: mk!,
                  );
                  if(user!=null){
                    showMySnackBar(
                        context,
                        message: "create successful ${user.user?.email}"
                    );
                    Navigator.push(
                        context,MaterialPageRoute(builder: (context) => Login(),)
                    );
                  }
                },
                child: Text("register email/password")
            ),
          ],
        ),
      ),
    );
  }

  _validator(String? value) {
    if (value == null) {
      return "ban chua nhap vao phone";
    } else
      return "hop le";
  }

  showMySnackBar(BuildContext context,{required String message}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }
}