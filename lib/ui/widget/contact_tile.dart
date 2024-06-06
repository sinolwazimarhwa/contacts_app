//import 'dart:ffi';

//import 'package:contacts_app/data/contact.dart';
//import 'dart:js_interop_unsafe';

//import 'dart:js_util';

// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:contacts_app/data/contact.dart';
import 'package:contacts_app/ui/contact/contact_edit_page.dart';
import 'package:contacts_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactTile extends StatelessWidget {
  final int contactIndex;

  const ContactTile({
    super.key,
    required this.contactIndex,
  });

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<ContactsModel>(context);
    final displayedContact = model.contacts[contactIndex];

    return Slidable(
      key: ValueKey(contactIndex),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {
            model.deleteContact(displayedContact);
            // You don't need to manually rebuild the tree, ScopedModel will handle it.
          },
        ),
        children: [
          SlidableAction(
            onPressed: (context) {
              model.deleteContact(displayedContact);
              // Ensure the item is removed from the list immediately.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${displayedContact.name} deleted'),
                ),
              );
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(displayedContact.name),
        subtitle: Text(displayedContact.email),
        leading: _builCircleAvatar(displayedContact),
        trailing: IconButton(
          icon: Icon(
            displayedContact.isFavourite ? Icons.star : Icons.star_border,
            color: displayedContact.isFavourite ? Colors.amber : Colors.grey,
          ),
          onPressed: () {
            model.changeFavouriteStatus(contactIndex);
          },
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContactEditPage(
                editedContact: displayedContact,
              
              ),
            ),
          );
        },
      ),
    );
  }

  Hero _builCircleAvatar(Contact displayedContact) {
    return Hero(
      tag: displayedContact.hashCode,
      child: CircleAvatar(child: _buildCircleAvatarContent(displayedContact),));
  }

Widget _buildCircleAvatarContent(Contact displayedContact) {
  if (displayedContact.imageFile != null) {
    return ClipOval(
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.file(
          displayedContact.imageFile!,
          fit: BoxFit.cover,
        ),
      ),
    );
  } else {
    return Text(
      displayedContact.name[0],
      style: const TextStyle(fontSize: 20), // Optional: Style the text
    );
  }
}

}
