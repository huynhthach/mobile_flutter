import 'package:baitap_android/bt_tren_lop/getx/controller.dart';
import 'package:baitap_android/catalog_provide/provider_catalog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import 'catalog_cart.dart';

class AppCatalog extends StatelessWidget {
  const AppCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Catalog(),
      lazy: true,
      child: MaterialApp(
        home: pagecatalog(),
      ),
    );
  }
}
class pagecatalog extends StatelessWidget {
  pagecatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cua hang trai cay"),
        actions: [
          Consumer<Catalog>(
              builder: (context,value,child)=>
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>Cart()),
                  );
                },
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: badges.Badge(
                      showBadge: true,
                      badgeContent: Text("${value.slMHTrongGH}"),
                      child: Icon(Icons.shopping_cart,size: 50,),
                      position: badges.BadgePosition.topEnd(),
                    ),
                  ),
              ),
          )
        ],
      ),
      body: Consumer<Catalog>(
        builder: (context, value, child) {
          var list = value.mathang;
          return ListView.builder(
              itemCount:list.length,
              itemBuilder: (context, index) =>Container(
                color: index %2==0? Colors.blue[100]:Colors.white,
                child: ListTile(
                  leading: Icon(Icons.account_balance),
                  title: Text(list[index].tenMH),
                  subtitle: Text("${list[index].gia}"),
                  trailing:value.kiemtramathang(index)==true?Icon(Icons.check):
                  new IconButton(
                      onPressed: () {
                        value.themmathang(index);
                        value.themmathang2(list[index]);
                      },
                      icon: Icon(Icons.add))
                ),
              )
          );
        },
      ),
    );
  }
}

