import 'package:contacts_app/ui/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';


// ignore: use_key_in_widget_constructors
class ContactCreatePage extends StatelessWidget {

  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Create'),
      ),
      // ignore: prefer_const_constructors
      body: ContactForm(),
    );
  }
}
