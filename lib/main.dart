import 'dart:io';
import 'package:contacts/android/android.app.dart';
import 'package:contacts/ios/ios.app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // garante que tudo do app está inicializado

  if (Platform.isIOS) {
    runApp(IOSApp());
  }
  else {
    runApp(AndroidApp()); 
  } 
}

// void main() => runApp(IOSApp());