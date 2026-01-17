import "package:flutter/material.dart";
import "package:new_app/practice/Note_pad_practice/Home_note.dart";
import "package:new_app/practice/Note_pad_practice/Edit_text_page.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:new_app/firebase_options.dart';

void main()async{
    //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    return runApp(MaterialApp(
      routes:{
        "/":(context)=>Home(),
        "/edit":(context)=>Write()
      }
));}