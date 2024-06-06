// ignore_for_file: prefer_const_constructors

/*import 'dart:js';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
*/
//import 'package:contacts_app/data/contact.dart';
import 'package:contacts_app/ui/contact/contact_create_page.dart';
import 'package:contacts_app/ui/model/contacts_model.dart';
import 'package:contacts_app/ui/widget/contact_tile.dart';
//import 'package:faker/faker.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


// ignore: use_key_in_widget_constructors
class ContactsListPage extends StatefulWidget {
  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}
class _ContactsListPageState extends State<ContactsListPage> {
//build runs when the state changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts')),
        body: ScopedModelDescendant<ContactsModel>(
          //runs when notifyListeners() is called from the model
          builder:(context, child, model) {
            if(model.isLoading){
              return Center(child: CircularProgressIndicator(),);
            }else{
              return  ListView.builder(
            itemCount: model.contacts.length,
            itemBuilder: (context,index) {
              return ContactTile( 
                contactIndex:index,
              );
           },
        );
            }     
     }),
      floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.person_add),
      onPressed: () {
       Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ContactCreatePage())
       );
      },
     ),
    ); 
    
  }
}

