import 'package:flutter/material.dart';

void main() {
  runApp(ContactListApp());
}

class ContactListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      theme: ThemeData(
       appBarTheme: AppBarTheme(

         centerTitle: true,

         backgroundColor: Colors.blueGrey,
         titleTextStyle: TextStyle(
           fontWeight: FontWeight.bold,

         ),

       ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
            backgroundColor: Colors.blueGrey,
              fixedSize: Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(vertical: 12)
          )
        )
      ),
      home: ContactListScreen(),
    );
  }
}

class Contact {
  String name;
  String number;

  Contact(this.name, this.number);
}

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final List<Contact> _contacts = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  void _addContact() {
    if (_nameController.text.isNotEmpty && _numberController.text.isNotEmpty) {
      setState(() {
        _contacts.add(Contact(_nameController.text, _numberController.text));
      });
      _nameController.clear();
      _numberController.clear();
    }
  }

  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Contact'),
          content: Text('Are you sure you want to delete this contact?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteContact(index);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _numberController,
                  decoration: InputDecoration(labelText: 'Number'),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: _addContact,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => _showDeleteDialog(index),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.account_circle, size: 40.0),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _contacts[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(_contacts[index].number),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.phone),
                        onPressed: () {
                          // Handle phone icon press, if needed
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
