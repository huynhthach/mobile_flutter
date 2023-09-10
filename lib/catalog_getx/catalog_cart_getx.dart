import 'package:baitap_android/catalog_getx/catalog_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class pageCart extends StatelessWidget {
  const pageCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("shop"),
      ),
      body: GetX<CatalogController>(
        init: Get.find<CatalogController>(),
        builder: (controller){
          return Column(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: ListView.builder(
                        itemCount: controller.slmTrongGh,
                        itemBuilder: (context, index) => Row(
                          children: [

                          ],
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
