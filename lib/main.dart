// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quotes_app/model/Quote.dart';
import 'package:quotes_app/utils/database.dart';
import 'package:quotes_app/widgets/quote_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Quotes(),
    );
  }
}

class Quotes extends StatefulWidget {
  const Quotes({super.key});

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  SqlDb sqlDb = SqlDb();
  List<Quote> AllQuotes = [];
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  deleteQuote(item) async {
    int response =
        await sqlDb.deleteData("DELETE FROM quotes where id=${item.id}");
    if (response > 0) {
      setState(() {
        AllQuotes.remove(item);
      });
    }
  }

  Future getData() async {
    var noteMapList = await sqlDb.readData("select * from quotes");
    int count =
        noteMapList.length; // Count the number of map entries in db table
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      setState(() {
        AllQuotes.add(Quote.fromMapObject(noteMapList[i]));
      });
    }
  }

  addQuote() async {
    int response = await sqlDb.insertData(
        '''insert into quotes(title,author)values("${titleController.text}","${authorController.text}")''');
    if (response > 0) {
      setState(() {
        AllQuotes.add(Quote(
            id: response,
            author: authorController.text,
            title: titleController.text));
        titleController.text = "";
        authorController.text = "";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.all(22),
                  color: Colors.white,
                  height: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: titleController,
                          maxLength: 70,
                          textAlign: TextAlign.start,
                          textInputAction: TextInputAction.next,
                          decoration:
                              InputDecoration(labelText: "add new quote"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: authorController,
                          maxLength: 25,
                          textAlign: TextAlign.start,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(labelText: "add author"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    addQuote();
                                    Navigator.pop(context);
                                  },
                                  child: Text("ADD")),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel")),
                            ],
                          ),
                        )
                      ]),
                );
              },
              isScrollControlled: true);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 50, 57, 121),
        title: Text(
          "Best Quotes",
          style: TextStyle(fontSize: 27),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: AllQuotes.map((item) => QuoteCard(
                deleteQuote: deleteQuote,
                QuoteItem: item,
              )).toList(),
        ),
      ),
    );
  }
}
