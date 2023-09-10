import 'package:baitap_android/bt_tren_lop/sqlite/page_home_sqlite.dart';
import 'package:baitap_android/bt_tren_lop/sqlite/provider_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SQLiteApp extends StatefulWidget {
  const SQLiteApp({Key? key}) : super(key: key);

  @override
  State<SQLiteApp> createState() => _SQLiteAppState();
}

class _SQLiteAppState extends State<SQLiteApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context){
          var databaseProvider = DatabaseProvider();
          databaseProvider.readUser();
          return databaseProvider;
        },
      child: MaterialApp(
        title: "SQLite Demo App",
        home: PageListUserSQLite(),
      ),
    );
  }
}
