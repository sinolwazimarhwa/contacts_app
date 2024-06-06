// ignore_for_file: avoid_print

import 'dart:io';

import 'package:contacts_app/data/contact.dart';
//import 'package:contacts_app/data/db/app_database.dart';
import 'package:contacts_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';


class ContactForm extends StatefulWidget {
  final Contact? editedContact;

  //File _contactImageFile;

// ignore: prefer_const_constructors_in_immutables, use_super_parameters
ContactForm({
   Key? key,
      this.editedContact,
}):super(key: key);


  //const ContactForm({super.key});

  @override
  //State<ContactForm> createState() => _ContactFormState();
  // ignore: library_private_types_in_public_api
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey= GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _phoneNumber;
  
  File? _contactImageFile;
  bool get isEditMode => widget.editedContact !=null;
  bool get hasSelectedCustomImage =>_contactImageFile != null;
  
   @override
  void initState() {
    super.initState();
    _contactImageFile =widget.editedContact?.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 10),
          _buildContactPiture(),
          const SizedBox(height: 10),
          TextFormField(
            onSaved:(newValue) => _name = newValue!,
            validator: _validateName,
            initialValue: widget.editedContact?.name,
            decoration: InputDecoration(labelText: 'Name',border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
           const SizedBox(height: 10),
          TextFormField(
             onSaved:(newValue) => _email = newValue!,
              validator: _validateEmail, 
              initialValue: widget.editedContact?.email,
             decoration: InputDecoration(labelText: 'Email',border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
           const SizedBox(height: 10),
          TextFormField(
             onSaved:(newValue) => _phoneNumber = newValue!,
              validator: _validatePhoneNumber,
              initialValue: widget.editedContact?.phoneNumber,
             decoration: InputDecoration(labelText: 'Phone Number',border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
          ElevatedButton(
            onPressed: _saveContactButtonPressed, 
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 12.0),
            ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('SAVE CONTACT'),
              Icon(
                Icons.person,
                size: 18,
              ),
            ],
            ),
           
          ) 
        ],
      )
    );
  }
  Widget _buildContactPiture(){
    final halfScreenDiameter=MediaQuery.of(context).size.width/2;
    return Hero(
      tag: widget.editedContact?.hashCode ?? 0,
      child: GestureDetector(
        onTap: _onContactPictureTapped,
        child: CircleAvatar(
          radius: halfScreenDiameter/2,
          child: _buildCircleAvatarContent(halfScreenDiameter),
        ),
      ),
    );
      

  }

void _onContactPictureTapped() async {
  final ImagePicker picker = ImagePicker();
  final XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
  //final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  setState(() {
      _contactImageFile=imageFile as File?;
  });

}

Widget _buildCircleAvatarContent(double halfScreenDiameter){
  if(isEditMode || hasSelectedCustomImage){
    if (_contactImageFile==null){
        return Text(
          widget.editedContact!.name[0],
          style: TextStyle(fontSize:halfScreenDiameter/2 ),
        );
    } else{
      return ClipOval(
        child: AspectRatio(aspectRatio: 1,
        child: Image.file(_contactImageFile as File,
        fit: BoxFit.cover,),),
      );
    }
  }else{
    return Icon(Icons.person, size: halfScreenDiameter /2,);
  }
}
  String? _validateName(String? newValue) {
    if(newValue == null || newValue.isEmpty){
      return 'Enter a name';
    }
    return null;
  }

    String? _validateEmail(String? newValue) {
    if (newValue == null || newValue.isEmpty) {
      return 'Enter an email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(newValue)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePhoneNumber(String? newValue) {
    if (newValue == null || newValue.isEmpty) {
      return 'Enter a phone number';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(newValue)) {
      return 'Enter a valid phone number';
    }
    return null;
  }
  void _saveContactButtonPressed(){
    if(_formKey.currentState!.validate()){
                _formKey.currentState?.save();
                final newOrEditedContact= Contact(
                  name: _name,  
                  email: _email, 
                  phoneNumber: _phoneNumber,
                  isFavourite: widget.editedContact?.isFavourite ?? false,
                  imageFile: _contactImageFile,
                );if(isEditMode){
                  newOrEditedContact.id= widget.editedContact!.id;
                  ScopedModel.of<ContactsModel>(context).updateContact(
                    newOrEditedContact,
                   )
                  ;
                }else{
                     ScopedModel.of<ContactsModel>(context).addContacts(newOrEditedContact);
                }
               
                Navigator.of(context).pop();
           
            //print('$_name $_email $_phoneNumber')
         }
  }
}