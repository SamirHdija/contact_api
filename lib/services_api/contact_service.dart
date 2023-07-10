import 'package:api_test_2/screens/list_contact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// API for contact list

class ContactService {
  static const String baseUrl = 'https://api-v2.hopcrm.com/api/mobile';

  Future<List<Contact>> fetchContacts() async {
    final response = await http.get(Uri.parse('$baseUrl/contacts'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final contactsJson = data['data'] as List<dynamic>;

      final contacts = contactsJson
          .map((contactJson) => Contact.fromJson(contactJson))
          .toList();

      return contacts;
    } else {
      throw Exception('Failed to fetch contacts');
    }
  }

  Future<Contact> fetchContactDetails(String contactKey) async {
    final response = await http.get(Uri.parse('$baseUrl/contacts/$contactKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final contactData = data['contact'];
      final contact = Contact.fromJson(contactData);

      return contact;
    } else {
      throw Exception('Failed to fetch contact details');
    }
  }
}
