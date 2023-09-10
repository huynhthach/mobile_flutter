import 'package:baitap_android/bt_tren_lop/sqlite/page_user_detail.dart';
import 'package:baitap_android/bt_tren_lop/sqlite/provider_data.dart';
import 'package:baitap_android/bt_tren_lop/sqlite/sqlite_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PageListUserSQLite extends StatefulWidget {
  const PageListUserSQLite({Key? key}) : super(key: key);

  @override
  State<PageListUserSQLite> createState() => _PageListUserSQLiteState();
}

class _PageListUserSQLiteState extends State<PageListUserSQLite> {
  BuildContext? dialogContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite Demo"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageUserSQLiteDetail(xem: false,))
              ),
              icon: const Icon(Icons.add_circle_outline,color: Colors.lightBlue)
          )
        ],
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, databaseProvider, child) {
          if(databaseProvider.users==null){
            return const Center(
              child: Text("chưa nhập dữ liệu"),
            );
          }else{
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(thickness: 1,),
              itemCount: databaseProvider.users!.length,
              itemBuilder: (context, index) {
                dialogContext = context;
                User user = databaseProvider.users![index];
                return Slidable(
                  child: ListTile(
                    leading: Text("${user.id}",
                      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    title: Text("${user.name}",
                      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("phone : ${user.phone}"),
                        Text("email : ${user.email}"),
                      ],
                    ),
                  ),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageUserSQLiteDetail(xem: true,user: user),
                          ),
                        ),
                        icon: Icons.details,
                        foregroundColor: Colors.green,
                        backgroundColor: Colors.blue[50]!,
                      ),
                      SlidableAction(
                        onPressed: (context) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageUserSQLiteDetail(xem: false,user: user,),
                            )
                        ),
                        icon: Icons.edit,
                        foregroundColor: Colors.lightBlue,
                        backgroundColor: Colors.lightBlue[50]!,
                      ),
                      SlidableAction(
                        onPressed: (context) =>  _xoa(dialogContext, user),
                        icon: Icons.delete_forever,
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.red[50]!,
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
  _xoa(BuildContext? dialogContext,User user) async{
    String? confim = await showConfirmDialog(context, "bạn có muốn xoá ${user.name!}");
    if(confim=="ok"){
      DatabaseProvider provider = context.read<DatabaseProvider>();
      provider.deleteUser(user.id!);
    }
  }

  Future<String?> showConfirmDialog(BuildContext context,String dispMessage) async{
    AlertDialog dialog = AlertDialog(
      title: const Text("xác nhận"),
      content: Text(dispMessage),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context,rootNavigator: true).pop("cancel"),
            child: Text("huỷ")
        ),
        ElevatedButton(
            onPressed: () => Navigator.of(context,rootNavigator: true).pop("ok"),
            child: Text("ok")
        )
      ],
    );
    String? res = await showDialog<String?>(
        barrierDismissible: false,
        context: context,
        builder: (context) => dialog,
    );
    return res;
  }
}