import 'package:flutter/material.dart';

Widget card(String image, String title, BuildContext context) {
  return Card(
    color: Colors.yellow[50],
    elevation: 8.0,
    margin: const EdgeInsets.all(1.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Container(
        width: 150, // Set a fixed width for the cards
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                image,
                height: 100,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 38.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        )),
  );
}
