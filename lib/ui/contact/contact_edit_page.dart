import 'package:contacts_app/data/contact.dart';
import 'package:contacts_app/ui/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ContactEditPage extends StatelessWidget {
// ignore: prefer_typing_uninitialized_variables
final Contact editedContact;
//final int editedContactIndex;

// ignore: prefer_const_constructors_in_immutables, use_super_parameters
ContactEditPage({
   Key? key,
  required this.editedContact,
  //required this.editedContactIndex,
}):super(key: key);

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Edit'), 
      ),
      // ignore: prefer_const_constructors
      body: ContactForm(editedContact: editedContact,),
    );
  }
}
