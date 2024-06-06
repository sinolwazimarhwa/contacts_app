//import 'dart:ffi';

import 'dart:io';

class Contact {
  late int id;
  String name;
  String email;
  String phoneNumber;
  bool isFavourite;
  File? imageFile;
  // constructor
  Contact({
    required this.name, 
    required this.email, 
    required this.phoneNumber,
    this.isFavourite = false,
     this.imageFile, 
  });

  Map<String, dynamic > toMap(){
    return{
      'name': name,
      'email': email,
      'phoneNumber':phoneNumber,
      'isFavourite': isFavourite,
      'imageFilePath' : imageFile?.path,
      };
  }
// ignore: empty_constructor_bodies

static Contact fromMap(Map<String, dynamic >map){
  return Contact(
    name: map['name'], 
    email: map['email'], 
    phoneNumber: map['phoneNumber'], 
    isFavourite: map['isFavourite'], 
    imageFile: map['imageFilePath']!=null ? File(map['imageFilePath']) : null);
}
}

//import 'package:flutter/material.dart';