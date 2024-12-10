import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TasksPage()));
}

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Outstanding'),
            Tab(text: 'Completed'),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildTaskContent(),
          buildTaskContent(), // Same UI for now
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        tooltip: 'New Task',
      ),
    );
  }

  Widget buildTaskContent() {
    bool hasTasks = false; // Set this to true when tasks exist

    return hasTasks
        ? ListView(
      children: [
        DataTable(
          columns: const [
            DataColumn(label: Text('Action')),
            DataColumn(label: Text('Due date')),
            DataColumn(label: Text('Name and description')),
            DataColumn(label: Text('Matter')),
            DataColumn(label: Text('Assigned by')),
            DataColumn(label: Text('Assigned to')),
          ],
          rows: const [
            DataRow(cells: [
              DataCell(Text('Draft Contract')),
              DataCell(Text('11/25/2024')),
              DataCell(Text('Prepare a draft contract for a business merger.')),
              DataCell(Text('Business Merger')),
              DataCell(Text('John Doe')),
              DataCell(Text('Jane Smith')),
            ]),
            DataRow(cells: [
              DataCell(Text('Court Filing')),
              DataCell(Text('11/28/2024')),
              DataCell(Text('Submit documents for a civil lawsuit.')),
              DataCell(Text('Civil Case #456')),
              DataCell(Text('Lisa Brown')),
              DataCell(Text('Tom Green')),
            ]),
            DataRow(cells: [
              DataCell(Text('Client Meeting')),
              DataCell(Text('11/23/2024')),
              DataCell(Text('Discuss upcoming trial details with client.')),
              DataCell(Text('Criminal Defense')),
              DataCell(Text('Emily Clark')),
              DataCell(Text('Michael Johnson')),
            ]),
            DataRow(cells: [
              DataCell(Text('Review Evidence')),
              DataCell(Text('11/24/2024')),
              DataCell(Text('Analyze discovery materials for the court case.')),
              DataCell(Text('Property Dispute')),
              DataCell(Text('Anna White')),
              DataCell(Text('Sarah Taylor')),
            ]),
            DataRow(cells: [
              DataCell(Text('Prepare Will')),
              DataCell(Text('11/30/2024')),
              DataCell(Text('Draft and finalize a client’s last will and testament.')),
              DataCell(Text('Estate Planning')),
              DataCell(Text('Chris Davis')),
              DataCell(Text('Kevin Martin')),
            ]),
            DataRow(cells: [
              DataCell(Text('Research Case Law')),
              DataCell(Text('11/26/2024')),
              DataCell(Text('Find precedents relevant to an ongoing litigation.')),
              DataCell(Text('Intellectual Property')),
              DataCell(Text('Nina Wilson')),
              DataCell(Text('Oscar Lopez')),
            ]),
          ], // Populate rows dynamically
        ),
      ],
    )
        : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 100, color: Colors.blue),
          const SizedBox(height: 20),
          const Text('No tasks found.', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          const Text(
            'Track tasks to better manage your firm’s productivity.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('New Task'),
          ),
        ],
      ),
    );
  }
}
