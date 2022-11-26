// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quotes_app/model/Quote.dart';

class QuoteCard extends StatelessWidget {
  final Function deleteQuote;
  final Quote QuoteItem;
  const QuoteCard(
      {super.key, required this.deleteQuote, required this.QuoteItem});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Color.fromARGB(255, 57, 66, 151),
      margin: EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              QuoteItem.title,
              style: TextStyle(color: Colors.white, fontSize: 27),
              textDirection: TextDirection.rtl,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    deleteQuote(QuoteItem);
                  },
                  icon: Icon(Icons.delete),
                  iconSize: 27,
                  color: Color.fromARGB(255, 255, 217, 217),
                ),
                Text(
                  QuoteItem.author,
                  style: TextStyle(color: Colors.white, fontSize: 19),
                  textDirection: TextDirection.rtl,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
