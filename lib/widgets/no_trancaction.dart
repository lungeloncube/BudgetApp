import 'package:flutter/material.dart';

class NoTransactions extends StatelessWidget {
  final name;

  const NoTransactions({Key key, @required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              // height: MediaQuery.of(context).size.height * 0.5,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '$name Data Not Available!\nClick The Add Icon To Add ',
            ),
          ],
        ),
      ),
    );
  }
}
