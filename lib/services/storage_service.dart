import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/health_entry.dart';

class StorageService {
  static const String _entriesKey = 'health_entries';

  // Save list of entries
  Future<void> saveEntries(List<HealthEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = entries.map((e) => e.toJson()).toList();
    await prefs.setString(_entriesKey, jsonEncode(jsonList));
  }

  // Load list of entries
  Future<List<HealthEntry>> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_entriesKey);
    if (jsonString == null) return [];
    final jsonList = jsonDecode(jsonString) as List;
    return jsonList.map((e) => HealthEntry.fromJson(e)).toList();
  }

  // Add a new entry
  Future<void> addEntry(HealthEntry entry) async {
    final entries = await loadEntries();
    entries.add(entry);
    await saveEntries(entries);
  }

  // Get today's entry if exists
  Future<HealthEntry?> getTodayEntry() async {
    final entries = await loadEntries();
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    try {
      return entries.firstWhere(
        (e) => DateTime(e.date.year, e.date.month, e.date.day) == todayDate,
      );
    } catch (e) {
      return null;
    }
  }
}