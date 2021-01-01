import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:intl/intl.dart';

class ContactDetailsPage extends StatelessWidget {
  ContactDetailsPage(this._contact, {this.onContactDeviceSave});

  final Contact _contact;
  final Function(Contact) onContactDeviceSave;

  _openExistingContactOnDevice(BuildContext context) async {
    try {
      var contact = await ContactsService.openExistingContact(_contact,
          iOSLocalizedLabels: false);
      if (onContactDeviceSave != null) {
        onContactDeviceSave(contact);
      }
      Navigator.of(context).pop();
    } on FormOperationException catch (e) {
      switch (e.errorCode) {
        case FormOperationErrorCode.FORM_OPERATION_CANCELED:
        case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
        case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
        default:
          print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
          color: AppColors.colorPrimaryDark,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                color: AppColors.colorPrimaryDark,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      child: Text(_contact.displayName ?? "",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'poppins_medium'),),
                      alignment: Alignment.center,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete,color: Colors.white,),
                          onPressed: () => ContactsService.deleteContact(_contact),
                        ),
                        IconButton(
                          icon: Icon(Icons.update,color: Colors.white,),
                          // onPressed: () => Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => UpdateContactsPage(
                          //       contact: _contact,
                          //     ),
                          //   ),
                          // ),
                        ),
                        IconButton(
                            icon: Icon(Icons.edit,color: Colors.white,),
                            onPressed: () => _openExistingContactOnDevice(context)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorLightBlue50,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                  ),
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text("Name"),
                        trailing: Text(_contact.givenName ?? ""),
                      ),
                      ListTile(
                        title: Text("Middle name"),
                        trailing: Text(_contact.middleName ?? ""),
                      ),
                      ListTile(
                        title: Text("Family name"),
                        trailing: Text(_contact.familyName ?? ""),
                      ),
                      ListTile(
                        title: Text("Prefix"),
                        trailing: Text(_contact.prefix ?? ""),
                      ),
                      ListTile(
                        title: Text("Suffix"),
                        trailing: Text(_contact.suffix ?? ""),
                      ),
                      ListTile(
                        title: Text("Birthday"),
                        trailing: Text(_contact.birthday != null
                            ? DateFormat('dd-MM-yyyy').format(_contact.birthday)
                            : ""),
                      ),
                      ListTile(
                        title: Text("Company"),
                        trailing: Text(_contact.company ?? ""),
                      ),
                      ListTile(
                        title: Text("Job"),
                        trailing: Text(_contact.jobTitle ?? ""),
                      ),
                      ListTile(
                        title: Text("Account Type"),
                        trailing: Text((_contact.androidAccountType != null)
                            ? _contact.androidAccountType.toString()
                            : ""),
                      ),
                      // AddressesTile(_contact.postalAddresses),
                      ItemsTile("Phones", _contact.phones),
                      ItemsTile("Emails", _contact.emails)
                    ],
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}
class ItemsTile extends StatelessWidget {
  ItemsTile(this._title, this._items);

  final Iterable<Item> _items;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(title: Text(_title)),
        Column(
          children: _items
              .map(
                (i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: ListTile(
                title: Text(i.label ?? ""),
                trailing: Text(i.value ?? ""),
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}

/*
SafeArea(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Name"),
              trailing: Text(_contact.givenName ?? ""),
            ),
            ListTile(
              title: Text("Middle name"),
              trailing: Text(_contact.middleName ?? ""),
            ),
            ListTile(
              title: Text("Family name"),
              trailing: Text(_contact.familyName ?? ""),
            ),
            ListTile(
              title: Text("Prefix"),
              trailing: Text(_contact.prefix ?? ""),
            ),
            ListTile(
              title: Text("Suffix"),
              trailing: Text(_contact.suffix ?? ""),
            ),
            ListTile(
              title: Text("Birthday"),
              trailing: Text(_contact.birthday != null
                  ? DateFormat('dd-MM-yyyy').format(_contact.birthday)
                  : ""),
            ),
            ListTile(
              title: Text("Company"),
              trailing: Text(_contact.company ?? ""),
            ),
            ListTile(
              title: Text("Job"),
              trailing: Text(_contact.jobTitle ?? ""),
            ),
            ListTile(
              title: Text("Account Type"),
              trailing: Text((_contact.androidAccountType != null)
                  ? _contact.androidAccountType.toString()
                  : ""),
            ),
            // AddressesTile(_contact.postalAddresses),
            // ItemsTile("Phones", _contact.phones),
            // ItemsTile("Emails", _contact.emails)
          ],
        ),
      ),
 */
