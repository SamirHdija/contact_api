import 'dart:convert';

import 'package:api_test_2/screens/list_contact.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//*************data**************** */
  String? prenomUser = '';
  String? nomClient = '';

  int? contact = 0;
  int? action = 0;
  int? organisation = 0;
  int? affaire = 0;
  int? piece = 0;
  int? produit = 0;
  int? document = 0;
  int? note = 0;
  Future<void> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse('https://api-v2.hopcrm.com/api/mobile/sessions/infos'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final clientData = data['client'];
        final userData = data['user'];
        setState(() {
          prenomUser = userData['prenom'];
          nomClient = clientData['nom'];
        });
      } else {
        print('Failed to fetch data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    //**************************************************** */
    try {
      final response = await http.get(
          Uri.parse('https://api-v2.hopcrm.com/api/mobile/infos/volumetrie'));
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);

        // Print the decoded data to verify its structure
        print(decodedData);

        setState(() {
          // Verify the field names and update them if necessary
          action = decodedData['action'];
          contact = decodedData['contact'];
          organisation = decodedData['organisation'];
          affaire = decodedData['affaire'];
          piece = decodedData['piece'];
          produit = decodedData['produit'];
          note = decodedData['note'];
          document = decodedData['document'];
        });
      } else {
        print('Failed to fetch data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  //***********************frame***************
  BoxDecoration getBoxDecoration() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5)),
    );
  }

  //**********************frame content********************
  Expanded getExpanded(String imageName, String mainText, String subText) {
    return Expanded(
      child: TextButton(
        child: Container(
          margin: const EdgeInsets.only(
              left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
          decoration: getBoxDecoration(),
          child: Center(
              child: Stack(
            children: [
              Positioned.fill(
                bottom: 0,
                right: 0,
                top: 0,
                left: 0,
                child: Center(
                  child: Image.asset(
                    'assets/$imageName.png',
                    height: 80.0,
                  ),
                ),
              ),
              Positioned(
                bottom: 10.0,
                left: 15,
                right: 0,
                child: Text(
                  mainText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Positioned(
                top: 10.0,
                right: 10,
                child: Text(
                  subText,
                  style: const TextStyle(
                    fontSize: 10.0,
                  ),
                ),
              ),
            ],
          )),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContactListPage()),
          );
        },
      ),
    );
  }

  // ******************body and AppBar********************

  @override
  Widget build(BuildContext context) {
    /*   Map receivedDataFromLoading =
        ModalRoute.of(context)!.settings.arguments as Map; */

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/contacts.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$prenomUser",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$nomClient",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.notifications),
                const SizedBox(width: 10.0),
                const Icon(Icons.menu),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        getExpanded('contacts', '  Contacts  ', '$contact'),
                        getExpanded('task', 'Taches  ', '$action'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        getExpanded('dashboard', 'Dashboard', '$document'),
                        getExpanded(
                            'entreprise', 'Entreprises', '$organisation'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        getExpanded('notes', 'Notes  ', '$note'),
                        getExpanded('affaires', 'Affaires  ', '$affaire'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        getExpanded('pieces', 'Piéces', '$piece'),
                        getExpanded('prouduits', 'Produits', '$produit'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
