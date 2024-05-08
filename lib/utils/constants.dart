import 'package:flutter/material.dart';

const currencySymbol ='৳';

showMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}