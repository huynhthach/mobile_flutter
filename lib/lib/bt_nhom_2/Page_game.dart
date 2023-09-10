import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'data.dart';

bool flipcard = false ;
class PageFlashCardGame extends StatefulWidget {
  final String fieldName;
  PageFlashCardGame({Key? key, required this.fieldName}) : super(key: key);

  @override
  State<PageFlashCardGame> createState() => _PageFlashCardState();
}


class _PageFlashCardState extends State<PageFlashCardGame> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game"),

      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: MyFirebaseCollection.getFlashCardsStream(widget.fieldName),
        builder:
            (BuildContext context, snapshot) {
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
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlipCard(
                          flipOnTouch: flipcard,
                          front: Container(
                            color: Colors.lightBlue,
                            height: 500,
                            width: 250,
                            child: Center(
                              child: Text(
                                flashcards[currentIndex]['front'],
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),

                          back: Container(
                            color: Colors.lightBlue,
                            height: 500,
                            width: 250,
                            child: Center(
                              child: Text(
                                flashcards[currentIndex]['back'],
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                          flipcard = false;
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            String userInput ="";
                            return AlertDialog(
                                title: Text("nhập mặt sau của thẻ"),
                                content: TextFormField(
                                  onChanged: (text){
                                    userInput = text;
                                  },
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("sumbit"),
                                    onPressed: (){
                                      if (userInput == flashcards[currentIndex]['back'] as String) {
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('đánh án chính xác'),
                                              content: Text('chúc mừng'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        setState(() {
                                          flipcard = true;
                                        }

                                        );
                                      }
                                      else {
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Invalid Input'),
                                              content: Text('Please try again.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                  )

                                ]
                            );
                          }
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.lightbulb_circle),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('bỏ qua'),
                            content: Text('bạn đã skip nội dung để xem đáp án'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      setState(() {
                        flipcard = true;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      if (currentIndex < flashcards.length - 1) {
                        if(flipcard == true){
                          setState(() {
                            currentIndex++;
                            flipcard = false;
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}