import 'package:contacts_app/data/contact.dart';
import 'package:contacts_app/data/db/contact_dao.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactsModel extends Model{
  final ContactDao _contactDao= ContactDao();
  //_contacts= private, contacts=public
late List<Contact> _contacts = [];
  bool _isLoading =true;
  bool get isLoading => _isLoading;
  // get property only, make sure we cant overwrite contacts from different classes
  List  <Contact> get contacts => _contacts;
  Future loadContacts() async{
    _isLoading=true;
    notifyListeners();
    _contacts=await _contactDao.getAllInSortedOrder();
    _isLoading =false;
    notifyListeners();
  }

  Future addContacts(Contact contact) async{
   await _contactDao.insert(contact);
   await loadContacts(); 
    notifyListeners();
  }

  Future updateContact(Contact contact) async{
    await _contactDao.update(contact);
    await loadContacts();
    notifyListeners();
  }

  Future deleteContact (Contact contact) async{
    await _contactDao.delete(contact);
    await loadContacts();
    notifyListeners();
  }

  void changeFavouriteStatus (int index){
      _contacts[index].isFavourite =! _contacts[index].isFavourite;
    notifyListeners();
  }

}