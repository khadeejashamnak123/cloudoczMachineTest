import 'package:flutter/material.dart';

void finish(context) {
  Navigator.pop(context);
}

callNext(var className, var context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => className),
  );
}

callNextReplacement(var className, var context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => className),
  );
}
