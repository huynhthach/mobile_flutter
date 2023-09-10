import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import 'catalog_cart_getx.dart';
import 'catalog_controller.dart';
class PageCatalogGetx extends StatelessWidget {
  PageCatalogGetx({Key? key}) : super(key: key);
  CatalogController controller = Get.put(CatalogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping"),
        actions: [
          Obx(() => GestureDetector(
              onTap: () {
                Get.to(pageCart());
              },
              child: badges.Badge(
                showBadge: true,
                badgeContent: Text("${controller.slmTrongGh}"),
                child: Icon(Icons.shopping_cart,size: 50,),
                position: badges.BadgePosition.topEnd(),
              )
          )
          )
        ],
      ),
      body: GetX<CatalogController>(
        init: controller,
        builder: (controller) {
          var list = controller.mathangs;
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => Container(
                color: index %2==0? Colors.blue[100]:Colors.white,
                child: ListTile(
                    leading: Icon(Icons.account_balance),
                    title: Text(list[index].tenMH),
                    subtitle: Text("${list[index].gia}"),
                    trailing:controller.kiemtramathang(index)==true?Icon(Icons.check):
                    new IconButton(
                        onPressed: () {
                          controller.themmathang(index);
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
