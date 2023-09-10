import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../firebase/firebase_test/page_firebase_app.dart';
import '../../widget_connect_firebase/widget_connect_firebase.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

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
            ElevatedButton(
                onPressed: () async{
                  var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: "c",
                      password: "123456",
                  );
                  if(user!=null){
                    showMySnackBar(
                        context,
                        message: "create successful ${user.user?.email}"
                    );
                  }
                },
                child: Text("register email/password")
            ),
            ElevatedButton(
                onPressed: () async{
                  var user = _signInWithGoogle();
                  if(user!=null){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => FirebaseApp(),)
                    );
                  }
                },
                child: Text("login with google")
            ),
            ElevatedButton(
                onPressed: () async{
                  var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: "long2411@gmail.com",
                      password: "123456"
                  );
                  if(user!=null){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => FirebaseApp(),)
                    );
                  }
                },
                child: Text("login email/password")
            )
          ],
        ),
      ),
    );
  }
}
class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${FirebaseAuth.instance.currentUser?.toString()}"),
            ElevatedButton(
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => PageLogin(),),
                          (route) => false,
                  );
                },
                child: Text("out"),
            )
          ],
        ),
      ),
    );
  }
}
Future<UserCredential> _signInWithGoogle() async {
// Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();// Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;// Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
// Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

showMySnackBar(BuildContext context,{required String message}){
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
  );
}


