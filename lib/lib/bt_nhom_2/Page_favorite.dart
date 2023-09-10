import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';

import 'data.dart';

class PageFavourite extends StatefulWidget {
  const PageFavourite({Key? key}) : super(key: key);

  @override
  State<PageFavourite> createState() => _PageFavouriteState();
}

class _PageFavouriteState extends State<PageFavourite> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("favorite"),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: MyFirebaseCollection.getFavoriteFlashcardsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final favoriteFlashcards = snapshot.data!;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400,
                child: PageView.builder(
                  key: ValueKey<int>(currentIndex),
                  itemCount: favoriteFlashcards.length,
                  itemBuilder: (context, index) {
                    final flashcards = favoriteFlashcards[index]['flashcards'];
                    final flashcard = flashcards[currentIndex];
                    final front = flashcard['front'];
                    final back = flashcard['back'];
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
                                  front,
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
                                  back,
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
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.restore_from_trash),
                    onPressed: () {
                      showDeleteDialog();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      )
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
                MyFirebaseCollection.deleteDocumentByIndex(currentIndex);
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
}
