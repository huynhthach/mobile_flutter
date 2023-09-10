import 'package:baitap_android/profile/page_profile.dart';
import 'package:flutter/material.dart';

import 'bt_tren_lop/authentication/page_login.dart';
import 'bt_tren_lop/hardware/Phone.dart';
import 'bt_tren_lop/json/page_list_photo.dart';
import 'bt_tren_lop/sqlite/page_sqlite_app.dart';
import 'catalog_provide/catalog_app.dart';
import 'layout/page_gridview.dart';
import 'layout/page_list_view.dart';
import 'layout/slide.dart';

class pagehome extends StatelessWidget {
  const pagehome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME PAGE"),
      ),
      body:Center(
          child:Column(
            children: [
              buildButton(context,title: "my profile",
                  destinaton: pagemyprofile()),
              buildButton(context,title: "list view",
                  destinaton: PageListViewN5()),
              buildButton(context,title: "list xe",
                  destinaton: PageGridViewXe()),
              buildButton(context,title: "SLIDE",
                  destinaton: PageSlide()),
              buildButton(context,title: "PROVIDER",
                  destinaton: AppCatalog()),
              buildButton(context,title: "Login",
                  destinaton: LoginApp()),
              buildButton(context,title: "Phone App",
                  destinaton: PhoneApp()),
              buildButton(context,title: "SQLite",
                  destinaton: SQLiteApp()),
              buildButton(context,title: "Page Photo",
                  destinaton: PageListPhoto()),
            ],
          )
      ),
    );
  }

  Widget buildButton(BuildContext context,{required String title,
    required Widget destinaton}) {
    return Container(
      width: 180,
      child: ElevatedButton(
          child: Text(title),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                destinaton,)
            );
          }
      ),
    );
  }
}
