import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MattersPage extends StatefulWidget {
  const MattersPage({super.key});

  @override
  _MattersPageState createState() => _MattersPageState();
}

class _MattersPageState extends State<MattersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final matterController = TextEditingController();
  final clientController = TextEditingController();
  final practiceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    clientController.dispose();
    matterController.dispose();
    practiceController.dispose();
    super.dispose();
  }

  Future<void> saveMatter() async {
    // Check if _formKey and its current state are valid
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseFirestore.instance.collection('matters').add({
          'client': clientController.text,
          'matter': matterController.text,
          'practicearea': practiceController.text,
        });
        print("Matter added successfully");
      } catch (e) {
        print("Failed to add matter: $e");
      }
    } else {
      print("Form validation failed");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matters'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Open'),
            Tab(text: 'Pending'),
            Tab(text: 'Closed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildMattersTable(),
          buildMattersTable(),
          buildMattersTable(),
          buildMattersTable(),
        ],
      ),
    );
  }

  Widget buildMattersTable() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.work_outline, size: 100, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No matters found.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Stay organised by keeping every case detail in one place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality to clear filters
                    print("Clear All Filters clicked!");
                  },
                  child: Text('Clear all filters'),
                ),
              ],
            ),
          ),
        ),
        buildBottomActions(),
      ],
    );
  }

  Widget buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(10.0), // Add extra padding for distinction
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light background color for contrast
        borderRadius: BorderRadius.circular(10.0), // Rounded corners for style
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // New Matter Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onPressed: () {
                  // Show a dialog with a form
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // Form key to manage form validation
                      final _formKey = GlobalKey<FormState>();


                      return AlertDialog(
                        title: Text('New Matter'),
                        content: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: clientController,
                                  decoration: InputDecoration(labelText: 'Client Name'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the client name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: practiceController,
                                  decoration: InputDecoration(labelText: 'Practice Area'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the practice area';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: matterController,
                                  decoration: InputDecoration(labelText: 'Matter'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the matter';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: Text('Save'),
                            onPressed: () async {
                              await saveMatter(); // Call the saveMatter function
                              Navigator.of(context).pop(); // Close the dialog after saving
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('New Matter'),
              )
              ,
              // Matters Template Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onPressed: () {
                  // Show an alert dialog when Matters Template is clicked
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Matters Template'),
                        content: Text('Matters Template button clicked!'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Matters Template'),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
