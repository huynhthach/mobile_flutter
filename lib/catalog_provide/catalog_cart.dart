import 'package:baitap_android/catalog_provide/provider_catalog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
   Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cart"),
      ),
      body: Consumer<Catalog>(
        builder: (context, value, child) {
          var list=value.ctgiohang;
          return Column(
             children: [
               Expanded(
                   child: ListView.builder(
                     itemCount: list.length,
                       itemBuilder: (context, index) => Container(
                         child: ListTile(
                           leading: Text("${list[index].tenMH}"),
                         ),
                       ),
                   )
               )
             ],
          );
        },
      )
    );
  }
}
