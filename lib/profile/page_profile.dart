import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class pagemyprofile extends StatefulWidget {
  const pagemyprofile({Key? key}) : super(key: key);

  @override
  State<pagemyprofile> createState() => _pagemyprofileState();
}

class _pagemyprofileState extends State<pagemyprofile> {
  String? gioitinh = "Boy";
  String? pheptinh = "cong";
  List<String> pheptinhs = ["cong","tru","nhan","chia","tich phan","dao ham"
    ,"biet tuot"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my profile"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Long"),
              accountEmail: Text("long@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("asset/image/img.png"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Inbox"),
              trailing: Text("10"),
            ),
            ListTile(
              leading: Icon(Icons.drafts),
              title: Text("Drafts"),
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text("Archive"),
            ),
            ListTile(
              leading: Icon(Icons.send),
              title: Text("Send"),
            ),
            ListTile(
              leading: Icon(Icons.cyclone),
              title: Text("Trash"),
            ),

          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.asset("asset/image/img.png",fit: BoxFit.fill),
              ),
              SizedBox(height: 15),
              Text("name"),
              Text("long",style: TextStyle(fontSize: 20,color: Colors.blue),),
              SizedBox(height: 15,),
              Text("birthday"),
              Text("8/3/2002",style: TextStyle(fontSize: 20,color: Colors.blue)),
              SizedBox(height: 15,),
              Row(
                children: [
                  Expanded(
                      child: ListTile(
                        leading: Radio(
                          value: "Boy",
                          groupValue: gioitinh,
                          onChanged: (value) {
                            setState(() {
                              gioitinh = value;
                            });
                          },
                        ),
                        title: Text("Boy"),
                      )
                  ),
                  Expanded(
                      child: ListTile(
                        leading: Radio(
                          value: "Girl",
                          groupValue: gioitinh,
                          onChanged: (value) {
                            setState(() {
                              gioitinh = value;
                            });
                          },
                        ),
                        title: Text("Girl"),
                      )
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Text("Live"),
              Text("dao khi",style: TextStyle(fontSize: 20,color: Colors.blue)),
              SizedBox(height: 15,),
              Text("farvourite"),
              Text("ca sau",style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic)),
              SizedBox(height: 15,),
              Text("Phep tinh ban gioi nhat la gi?"),
              DropdownButton<String>(
                isExpanded: true,
                value: pheptinh,
                items: pheptinhs.map(
                        (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    )
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    pheptinh = value;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
