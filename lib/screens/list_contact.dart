import 'package:api_test_2/screens/contact_details_page.dart';
import 'package:api_test_2/services_api/contact_service.dart';
import 'package:flutter/material.dart';

class Contact {
  final String key;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  Contact({
    required this.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      key: json['cle'],
      firstName: json['prenom'] ?? '',
      lastName: json['nom'] ?? '',
      email: json['e_mail'] ?? '',
      phone: json['telephone_fixe'] ?? '',
    );
  }
}

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final ContactService _contactService = ContactService();
  late List<Contact> _contacts;
  late List<Contact> _filteredContacts;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contacts = [];
    _filteredContacts = [];
    _fetchContacts();
  }

  void _fetchContacts() async {
    try {
      final contacts = await _contactService.fetchContacts();

      setState(() {
        _contacts = contacts;
        _filteredContacts = contacts;
      });
    } catch (e) {
      print('Failed to fetch contacts: $e');
      // Display an error message to the user using a snackbar, dialog, or toast widget
    }
  }

  void _fetchContactDetails(String contactKey) async {
    try {
      final contact = await _contactService.fetchContactDetails(contactKey);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailContactPage(contact: contact),
        ),
      );
    } catch (e) {
      print('Failed to fetch contact details: $e');
      // Display an error message to the user using a snackbar, dialog, or toast widget
    }
  }

  void _filterContacts(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        _filteredContacts = _contacts;
      } else {
        _filteredContacts = _contacts
            .where((contact) =>
                contact.firstName
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                contact.lastName
                    .toLowerCase()
                    .contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Bar Demo'),
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Search'),
                content: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Enter search query',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _filterContacts(_searchController.text);
                    },
                    child: const Text('Search'),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 16.0),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _filteredContacts.length,
              itemBuilder: (BuildContext context, int index) {
                final contact = _filteredContacts[index];
                final previousContact =
                    index > 0 ? _filteredContacts[index - 1] : null;
                final currentInitial = contact.firstName.isNotEmpty
                    ? contact.firstName[0].toUpperCase()
                    : '';

                Widget listItem;

                if (previousContact == null ||
                    currentInitial !=
                        previousContact.firstName[0].toUpperCase()) {
                  listItem = Column(
                    children: [
                      Container(
                        height: 50,
                        color: Colors.grey[100],
                        child: ListTile(
                          title: Text(
                            currentInitial,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/contacts.png'), // Replace with the actual image path
                            ),
                            title: Text(
                              '${contact.firstName} ${contact.lastName}',
                            ),
                            subtitle: Text(""),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            onTap: () {
                              _fetchContactDetails(contact.key);
                            },
                          ),
                          Positioned(
                            top: 8.0,
                            right: 40.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: const Text(
                                'Client',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  listItem = Stack(
                    children: [
                      ListTile(
                        title: Text(
                          '${contact.firstName} ${contact.lastName}',
                        ),
                        subtitle: Text(contact.email),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                        onTap: () {
                          _fetchContactDetails(contact.key);
                        },
                      ),
                      Positioned(
                        top: 8.0,
                        right: 40.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Text(
                            'New',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return listItem;
              },
            ),
          ),
          Positioned(
            top: 0,
            bottom: 610,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        'Contacts',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        width: 40.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 10.0,
            width: 24.0,
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              child: ListView.builder(
                itemCount: getInitialLetters().length,
                itemBuilder: (BuildContext context, int index) {
                  final initial = getInitialLetters()[index];
                  return ListTile(
                    title: Text(initial),
                    dense: true,
                    onTap: () {
                      final contactIndex = _filteredContacts.indexWhere(
                        (contact) =>
                            contact.firstName.isNotEmpty &&
                            contact.firstName[0].toUpperCase() == initial,
                      );
                      if (contactIndex != -1) {
                        _scrollController.jumpTo(
                          _scrollController.position.minScrollExtent +
                              (contactIndex * 56.0),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> getInitialLetters() {
    final initials = _filteredContacts
        .map((contact) => contact.firstName.isNotEmpty
            ? contact.firstName[0].toUpperCase()
            : '#')
        .toList();

    initials.sort(); // Sort the initials alphabetically

    return initials.toSet().toList();
  }
}
