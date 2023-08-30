import 'package:flutter/material.dart';

void ShowCustomDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5),
            Text(
              message.toString(),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    ),
  );
}
