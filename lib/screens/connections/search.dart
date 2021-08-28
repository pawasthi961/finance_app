import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/services/database_service.dart';
import 'package:finance_app/services/phone_service.dart';
import 'package:finance_app/streams/searching_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class SearchScreen extends StatefulWidget {
  final Function toggleLoading;
  SearchScreen({this.toggleLoading});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textEditingController;
  bool _toggleValue = false;
  String name = "";
  FocusNode _focus = FocusNode();
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];

  bool _showCancelButton = false;
  // String _phoneNumberIterator(Iterable phoneNumbers) {
  //   List numberList = [];
  //   for (var phoneNumber in phoneNumbers) {
  //     numberList.add(phoneNumber.value);
  //   }
  //   return numberList.join(" , ").toString();
  // }

  void _listener() {
    if (_textEditingController.text.length != 0) {
      setState(() {
        _showCancelButton = true;
      });
    } else {
      setState(() {
        name = "";
        _showCancelButton = false;
      });
    }
  }

  void _initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }

  void _filterContacts(String value) {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (value.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = value.toLowerCase();
        String contactName = contact.displayName.toLowerCase();
        return contactName.contains(searchTerm);
      });
      setState(() {
        filteredContacts = _contacts;
      });
    }
  }

  void _getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    if (mounted == true) {
      setState(() {
        contacts = _contacts;
      });
    }
  }

  void _getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      _getAllContacts();
      // searchController.addListener(() {
      //   filterContacts();
      // });
    }
  }

  List<String> _returnUserFromPhoneNumber(List phoneNumbers) {
    List<String> flattenPhoneNumbers = [];
    phoneNumbers.forEach((dynamicPhoneNumber) {
      // print(dynamicPhoneNumber.value.toString());
      final phoneNumber = dynamicPhoneNumber.value.toString();
      if (phoneNumber.contains("+")) {
        if (phoneNumber.contains("+91")) {
          String tempPhoneNumber = phoneNumber.replaceAll("+91", "");
          flattenPhoneNumbers
              .add("+91" + tempPhoneNumber.replaceAll(RegExp(r'^(\+)|\D'), ""));
        } else {
          for (String code in PhoneService().phoneNumberCodes) {
            if (phoneNumber.contains(code.trim())) {
              String tempPhoneNumber = phoneNumber.replaceAll(code.trim(), "");
              flattenPhoneNumbers.add(code.trim() +
                  tempPhoneNumber.replaceAll(RegExp(r'^(\+)|\D'), ""));
              break;
            }
          }
        }
      } else {
        String tempPhoneNumber =
            phoneNumber.replaceFirst(RegExp(r'^0+(?!$)'), "");
        flattenPhoneNumbers
            .add(tempPhoneNumber.replaceAll(RegExp(r'^(\+)|\D'), ""));
      }
    });
    return flattenPhoneNumbers;
  }

  @override
  void initState() {
    _getPermissions();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_listener);
    // _focus.addListener(() { _onFocusChange});
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = _textEditingController.text.isNotEmpty;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 44.0,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            alignment: Alignment.center,
            child: TextField(
              controller: _textEditingController,
              onChanged: ((val) {
                _toggleValue ? _filterContacts(val) : _initiateSearch(val);
              }),
              decoration: InputDecoration(
                filled: true,
                // fillColor: Colors.grey.shade900,

                hintText: _toggleValue ? "Search from Contacts" : "Search",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                prefixIcon: Icon(Icons.search_rounded),
                suffixIcon: _showCancelButton
                    ? GestureDetector(
                        onTap: (() {
                          _textEditingController.clear();
                        }),
                        child: Icon(
                          Icons.cancel,
                          size: 18.0,
                        ),
                      )
                    : (_toggleValue
                        ? Icon(
                            Icons.contacts,
                            size: 18.0,
                          )
                        : null),
              ),
            ),
          ),
          ListTile(
            title: Text("Make connections from your contacts"),
            trailing: CupertinoSwitch(
              activeColor: Color(0xffda0037),
              value: _toggleValue,
              onChanged: ((value) {
                setState(() {
                  _toggleValue = value;
                });
              }),
            ),
          ),
          _toggleValue
              ? Expanded(
                  child: ListView.builder(
                    itemCount:
                        isSearching ? filteredContacts.length : contacts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Contact contact = isSearching
                          ? filteredContacts[index]
                          : contacts[index];

                      return GestureDetector(
                          onTap: (() async {
                            widget.toggleLoading();
                            final flattenPhoneNumbers =
                                _returnUserFromPhoneNumber(
                                    contact.phones.toList());
                            print(flattenPhoneNumbers);

                            await DatabaseService()
                                .getAllUsers()
                                .then((QuerySnapshot querySnapshot) {
                              for (var phoneNumber in flattenPhoneNumbers) {
                                for (DocumentSnapshot doc
                                    in querySnapshot.docs) {
                                  if (doc["phoneSearchIndex"]
                                      .contains(phoneNumber)) {
                                    print("found");
                                    print(phoneNumber.toString());
                                    widget.toggleLoading();
                                    return 0;
                                  }
                                }
                              }
                              widget.toggleLoading();
                              print("user not found");
                            }).catchError((e) {
                              print(e);
                            });
                          }),
                          child: ListTile(
                            leading: (contact.avatar != null &&
                                    contact.avatar.length > 0)
                                ? CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(contact.avatar),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Color(0xffda0037),
                                    child: Text(
                                      contact.initials(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                            title: Text(contact.displayName),
                            // subtitle:
                            // Text(_phoneNumberIterator(contact.phones)),
                          ));
                    },
                  ),
                )
              : ((name != "" && name != null)
                  ? SearchingStream(
                      searchName: name,
                    )
                  : Container(
                      width: 0.0,
                      height: 0.0,
                    )),
        ],
      ),
    );
  }
}
