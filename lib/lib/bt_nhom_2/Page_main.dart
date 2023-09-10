import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'Page_Introduce.dart';
import 'Page_favorite.dart';
import 'Page_flashcard.dart';
import 'Search_Page.dart';
import 'data.dart';
import 'widget_connect_firebase.dart';

class PageMain extends StatelessWidget {
  const PageMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        errorMessage: "error,do not connect",
        connectingMessage: "kết nối xong!",
        builder: (context) => PageAddTaiLieu(),
    );
  }
}
class PageAddTaiLieu extends StatefulWidget {
  const PageAddTaiLieu({Key? key}) : super(key: key);

  @override
  State<PageAddTaiLieu> createState() => _PageAddTaiLieuState();
}

class _PageAddTaiLieuState extends State<PageAddTaiLieu> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards'),
        backgroundColor: Colors.purple, // Màu tím
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5.0), // Bo góc trái dưới
            bottomRight: Radius.circular(5.0), // Bo góc phải dưới
          ),
        ),
        actions: [ // Kiểm tra trạng thái hộp thoại
            IconButton(
              onPressed: () {
                _showAddFolderDialog();
              },
              icon: Icon(Icons.add_box_outlined,color: Colors.black,size: 30,),
            ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? ''),
              accountEmail: Text(user?.email ?? ''),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("asset/image/img.png"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text("Search"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite_outline_sharp),
              title: Text("Favorite"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageFavourite(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.interpreter_mode),
              title: Text("Giới thiệu"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageIntroduce(),
                  ),
                );
              },
            ),
            SizedBox(height: 30,),
            ListTile(
              leading: Icon(Icons.favorite_outline_sharp),
              title: Text("Login"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<List<String>>(
        stream: MyFirebaseCollection.getCollectionNames(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text("display error", style: TextStyle(color: Colors.red)),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var collectionNames = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(thickness: 0),
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.only(top: 8.0), // Khoảng cách từ top
              itemCount: collectionNames.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Xử lý khi nhấn vào mỗi phần tử
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageFlashCard(fieldName: collectionNames[index]),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Colors.blueGrey, // Màu của mỗi phần tử
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                           // Khoảng cách giữa icon và nội dung
                          Text("${collectionNames[index]}"),
                          SizedBox(width: 8),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          MyFirebaseCollection.deleteDocumentByIndexMain(index);
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
  void _showAddFolderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String foldername = '';
        return AlertDialog(
          title: Text(
            'Thêm Thư Mục',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    foldername = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Tên folder',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Hủy',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Gọi phương thức thêm flashcard với giá trị front và back
                if (foldername.isNotEmpty) {
                  MyFirebaseCollection.createFolder(foldername);
                }
                Navigator.of(context).pop();
              },
              child: Text(
                'Thêm',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

