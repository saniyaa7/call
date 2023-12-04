import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Call app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white, // Setting white background
      ),
      home: const MyHomePage(title: 'Call app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Enter phone number',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      final phoneNumber = _phoneNumberController.text.trim();
                      if (phoneNumber.isEmpty || phoneNumber.length < 10) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Please enter a valid phone number')),
                        );
                      } else {
                        if (!await launch('tel:$phoneNumber')) {
                          throw 'Could not launch';
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Set button background color here
                    ),
                    child: const Text(
                      'CALL',
                      style:
                          TextStyle(color: Colors.white), // Set text color here
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      final phoneNumber = _phoneNumberController.text.trim();
                      if (phoneNumber.isEmpty || phoneNumber.length < 10) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Please enter a valid phone number')),
                        );
                      } else {
                        if (!await launch('sms:$phoneNumber')) {
                          throw 'Could not launch';
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Set button background color here
                    ),
                    child: const Text(
                      'SMS',
                      style:
                          TextStyle(color: Colors.white), // Set text color here
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
