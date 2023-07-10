import 'package:api_test_2/screens/list_contact.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailContactPage extends StatefulWidget {
  final Contact contact;

  const DetailContactPage({super.key, required this.contact});

  @override
  _DetailContactPageState createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactPage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool switchValue = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        actions: const [
          Center(
            child: Text(
              'Modifier',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    height: 130,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/contact.png'),
                          radius: 50,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.contact.firstName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.contact.email,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.contact.phone,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.email),
                          onPressed: () async {
                            final emailUri = 'mailto:${widget.contact.email}';
                            if (await canLaunch(emailUri)) {
                              await launch(emailUri);
                            } else {
                              throw 'Could not launch $emailUri';
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.phone),
                          onPressed: () async {
                            final phoneUri = 'tel:${widget.contact.phone}';
                            if (await canLaunch(phoneUri)) {
                              await launch(phoneUri);
                            } else {
                              throw 'Could not launch $phoneUri';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 10,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Nom',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    enabled: false,
                    decoration:
                        InputDecoration(hintText: widget.contact.lastName),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Prenom',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    enabled: false,
                    decoration:
                        InputDecoration(hintText: widget.contact.firstName),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Adresse Email',
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            'Option Mail',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: widget.contact.email,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Switch(
                            value: switchValue,
                            onChanged: (value) async {
                              setState(() {
                                switchValue = value;
                              });

                              // Launch the email
                              if (value) {
                                final emailUri =
                                    'mailto:${widget.contact.email}';
                                if (await canLaunch(emailUri)) {
                                  await launch(emailUri);
                                } else {
                                  throw 'Could not launch $emailUri';
                                }
                              }
                            },
                            inactiveThumbImage:
                                const AssetImage('assets/active_icon.png'),
                            activeThumbImage:
                                const AssetImage('assets/active_icon.png'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Telephone Mobile',
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            'Option SMS',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: widget.contact.phone,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Switch(
                            value: switchValue,
                            onChanged: (value) async {
                              setState(() {
                                switchValue = value;
                              });

                              // Launch the phone call
                              if (value) {
                                final url = 'tel:${widget.contact.phone}';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }
                            },
                            inactiveThumbImage:
                                const AssetImage('assets/active_icon.png'),
                            activeThumbImage:
                                const AssetImage('assets/active_icon.png'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Telephone Fixe',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: widget.contact.phone,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Statut',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Prospect'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Client'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Partenaire'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Taches',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Affaires',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Autres',
            ),
          ],
        ),
      ),
    );
  }
}
