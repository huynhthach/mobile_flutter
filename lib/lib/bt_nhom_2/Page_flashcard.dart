import 'package:flash_card/flash_card.dart';
import 'package:flutter/material.dart';
import 'Page_game.dart';
import 'data.dart';

class PageFlashCard extends StatefulWidget {
  final String fieldName;
  PageFlashCard({Key? key,required this.fieldName}) : super(key: key);

  @override
  State<PageFlashCard> createState() => _PageFlashCardState();
}

class _PageFlashCardState extends State<PageFlashCard> {
  int currentIndex = 0;
  bool isFavorite = false;
  IconData currentIcon = Icons.favorite_outline;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fieldName),
        actions: [ // Kiểm tra trạng thái hộp thoại
          IconButton(
            onPressed: () {
              _showAddFlashcardDialog();
            },
            icon: Icon(Icons.add_box_outlined,color: Colors.black,size: 30,),
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: MyFirebaseCollection.getFlashCardsStream(widget.fieldName),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Đã xảy ra lỗi');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Đang tải...');
          }
          var flashcards = snapshot.data!;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400,
                child: PageView.builder(
                  key: ValueKey<int>(currentIndex),
                  itemCount: flashcards.length,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 50),
                      curve: Curves.easeInOut,
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          FlashCard(
                          frontWidget: Container(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Text(
                                flashcards[currentIndex]['back'],
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          backWidget: Container(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Text(
                                flashcards[currentIndex]['front'],
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          width: 300,
                          height: 400,
                        ),
                          IconButton(
                            icon:Icon(
                          currentIcon),
                            onPressed: () async{
                              final bool isAdded = await MyFirebaseCollection.isDocumentNameDuplicated(widget.fieldName, currentIndex);
                              if (!isAdded) {
                                toggleIcon();
                                print('Thêm flashcard thành công');
                                print("current + ${currentIndex} - index + ${index}");
                              } else {
                              }
                              // Thêm xử lý khi người dùng nhấp vào IconButton
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      if (currentIndex > 0) {
                        setState(() {
                          currentIndex--;
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showUpdateDialog();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.restore_from_trash),
                    onPressed: () {
                      showDeleteDialog();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      if (currentIndex < flashcards.length - 1) {
                        setState(() {
                          currentIndex++;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageFlashCardGame(fieldName: widget.fieldName),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.gamepad),
      ),
    );
  }
  void showUpdateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newFront = '';
        String newBack = '';
        return AlertDialog(
          title: Text('Update Flashcard'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    newFront = value;
                  });
                },
                decoration: InputDecoration(labelText: 'New Front'),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    newBack = value;
                  });
                },
                decoration: InputDecoration(labelText: 'New Back'),
              ),
            ],
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
                MyFirebaseCollection.updateFlashcard(widget.fieldName,currentIndex,newFront, newBack);
                Navigator.of(context).pop();
              },
              child: Text(
                'Update',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  void _showAddFlashcardDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String front = '';
        String back = '';
        return AlertDialog(
          title: Text(
            'Thêm FlashCard',
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
                    front = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Mặt Trước',
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
                TextField(
                  onChanged: (value) {
                    back = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Mặt Sau',
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
                MyFirebaseCollection.addFlashcardToFolder(widget.fieldName, front, back);
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
  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xoá Flashcard'),
          content: Text('Bạn có chắc chắn muốn xoá Flashcard này?'),
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
                MyFirebaseCollection.deleteFlashcard(widget.fieldName,currentIndex);
                if (currentIndex-- == 0) {
                  setState(() {
                    currentIndex = 0;
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  void toggleIcon(){
    setState(() {
      if (currentIcon == Icons.favorite) {
        currentIcon = Icons.favorite_outline;
          MyFirebaseCollection.deleteDocumentByIndex(currentIndex);
      } else if(currentIcon == Icons.favorite_outline){
        currentIcon = Icons.favorite;
          MyFirebaseCollection.addToFavorites(widget.fieldName, currentIndex);
          print('Thêm flashcard thành công');
        }
      }
    );
  }
}
// ListView.builder(
// itemCount: flashcards.length,
// itemBuilder: (BuildContext context, int index) {
// final flashcard = flashcards[index];
// return ListTile(
// title: Text(flashcard['back']),
// subtitle: Text(flashcard['front']),
// );
// },
// );