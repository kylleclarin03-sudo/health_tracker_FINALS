import 'package:flutter/material.dart';
import '../models/health_entry.dart';
import '../services/storage_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final StorageService _storage = StorageService();
  List<HealthEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final entries = await _storage.loadEntries();
    // Sort by date descending
    entries.sort((a, b) => b.date.compareTo(a.date));
    setState(() {
      _entries = entries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health History'),
        backgroundColor: Colors.green,
      ),
      body: _entries.isEmpty
          ? const Center(
              child: Text('No entries yet. Add some data!'),
            )
          : ListView.builder(
              itemCount: _entries.length,
              itemBuilder: (context, index) {
                final entry = _entries[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      '${entry.date.day}/${entry.date.month}/${entry.date.year}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Steps: ${entry.steps}'),
                        Text('Water: ${entry.water} L'),
                        Text('Sleep: ${entry.sleep} h'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}