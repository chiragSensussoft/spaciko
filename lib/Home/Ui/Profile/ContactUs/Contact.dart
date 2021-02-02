import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spaciko/widgets/Pelette.dart';

import 'ContactDetail.dart';

class ContactReader extends StatefulWidget {
  @override
  _ContactReaderState createState() => _ContactReaderState();
}

class _ContactReaderState extends State<ContactReader> {
  List<Contact> _contacts;
  List<Contact> _filteredList;
  bool _filterSearch = true;
  String _query = "";
  var _controller = TextEditingController();
  @override
  void initState() {
    seeContact();
    super.initState();
  }
  _ContactReaderState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _filterSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _filterSearch = false;
          _query = _controller.text;
        });
      }
    });
  }

  void seeContact()async{
    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      refreshContacts();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              CupertinoAlertDialog(
                title: Text('Permissions error'),
                content: Text('Please enable contacts access '
                    'permission in system settings'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
    }
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
      await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  Future<void> refreshContacts() async {
    var contacts = (await ContactsService.getContacts(
        withThumbnails: false, iOSLocalizedLabels: false))
        .toList();
//      var contacts = (await ContactsService.getContactsForPhone("8554964652"))
//          .toList();
    setState(() {
      _contacts = contacts;
    });

    for (final contact in contacts) {
      ContactsService.getAvatar(contact).then((avatar) {
        if (avatar == null) return;
        setState(() => contact.avatar = avatar);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: AppColors.colorPrimaryDark,
        child: Container(
          child: Column(
            children: [
                Container(
                  height: MediaQuery.of(context).size.height *.14,
                  color: AppColors.colorPrimaryDark,
                  child: Container(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'Search contact',
                                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: new BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: new BorderSide(color: Colors.white),
                                ),
                              ),
                              controller: _controller,

                              onChanged: (val){
                                print(_controller.text);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                    color: AppColors.colorLightBlue50
                  ),
                  child: _filterSearch ?Container(
                      child: _contacts != null
                          ? ListView.builder(
                        itemCount: _contacts?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          Contact c = _contacts?.elementAt(index);
                          return ListTile(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (BuildContext context) => ContactDetailsPage(
                              //       c,
                              //       onContactDeviceSave:
                              //       contactOnDeviceHasBeenUpdated,
                              //     )));
                            },
                            leading: (c.avatar != null && c.avatar.length > 0)
                                ? CircleAvatar(backgroundImage: MemoryImage(c.avatar))
                                : CircleAvatar(child: Text(c.initials())),
                            title: Text(c.displayName ?? ""),
                            subtitle: Text(c.phones.elementAt(0).value??""),
                          );
                        },
                      )
                          : Center(
                        child: CircularProgressIndicator(),
                      )
                  ): _performSearch()
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _performSearch() {
    _filteredList = new List<Contact>();
    for (int i = 0; i < _contacts.length; i++) {
      var item = _contacts[i];

      if (item.displayName.contains(_query.toLowerCase())) {
       setState(() {
         _filteredList.add(item);
       });
      }
    }
    return _createFilteredListView();
  }
  //Create the Filtered ListView
  Widget _createFilteredListView() {
    return new Flexible(
      child:  ListView.builder(
        itemCount: _filteredList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          Contact c = _filteredList?.elementAt(index);
          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ContactDetailsPage(
                    c,
                    onContactDeviceSave:
                    contactOnDeviceHasBeenUpdated,
                  )));
            },
            leading: (c.avatar != null && c.avatar.length > 0)
                ? CircleAvatar(backgroundImage: MemoryImage(c.avatar))
                : CircleAvatar(child: Text(c.initials())),
            title: Text(c.displayName ?? ""),
            subtitle: Text(c.phones.elementAt(0).value??""),
          );
        },
      )
    );
  }
  
  void contactOnDeviceHasBeenUpdated(Contact contact) {
    this.setState(() {
      var id = _contacts.indexWhere((c) => c.identifier == contact.identifier);
      _contacts[id] = contact;
    });
  }
}