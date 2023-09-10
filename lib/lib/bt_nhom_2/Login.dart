import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Page_main.dart';
import '../../widget_connect_firebase/widget_connect_firebase.dart';
import 'Register.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      errorMessage: 'error,do not connect',
      connectingMessage: 'kết nối xong!',
      builder: (context) => PageLogin(),
    );
  }
}
class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  String? ten;
  String? mk;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) => ten=value,
              validator: (value) => _validator(value),
              decoration: InputDecoration(
                labelText: "Tài khoản",
              ),
            ),
            TextFormField(
              onChanged: (value) => mk=value,
              validator: (value) => _validator(value),
              decoration: InputDecoration(
                labelText: "Mật khẩu",
              ),
              obscureText: true,
            ),
            ElevatedButton(
                onPressed: () async{
                  var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: ten!,
                      password: mk!
                  );
                  if(user!=null){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => PageMain(),)
                    );
                  }
                },
                child: Text("login email/password")
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => PageRegister(),)
                  );
                },
                child: Text("đăng ký"),
            )
          ],
        ),
      ),
    );
  }
  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập thông tin";
    } else {
      return null; // Giá trị null khi không có lỗi
    }
  }
}


