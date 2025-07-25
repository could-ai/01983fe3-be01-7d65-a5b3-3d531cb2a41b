import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/password_entry.dart';
import 'package:couldai_user_app/services/local_storage_service.dart';

class PasswordListPage extends StatefulWidget {
  const PasswordListPage({super.key});

  @override
  State<PasswordListPage> createState() => _PasswordListPageState();
}

class _PasswordListPageState extends State<PasswordListPage> {
  final LocalStorageService _localStorageService = LocalStorageService();
  List<PasswordEntry> _passwords = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPasswords();
  }

  Future<void> _loadPasswords() async {
    setState(() {
      _isLoading = true;
    });
    _passwords = await _localStorageService.loadPasswords();
    // Add some mock data if the list is empty for demonstration
    if (_passwords.isEmpty) {
      _passwords.addAll([
        PasswordEntry(
          id: '1',
          website: 'example.com',
          username: 'user@example.com',
          password: 'mySecurePassword123',
          notes: 'Personal account',
        ),
        PasswordEntry(
          id: '2',
          website: 'socialmedia.com',
          username: 'my_social_handle',
          password: 'AnotherStrongPass!',
          notes: 'Social media login',
        ),
      ]);
      await _localStorageService.savePasswords(_passwords);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Manager'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _passwords.isEmpty
              ? const Center(child: Text('No passwords saved yet. Add one!'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _passwords.length,
                  itemBuilder: (context, index) {
                    final passwordEntry = _passwords[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          child: Text(
                            passwordEntry.website[0].toUpperCase(),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          passwordEntry.website,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          passwordEntry.username,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy, color: Colors.grey),
                          onPressed: () {
                            // Implement copy password to clipboard
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Password copied!')),
                            );
                          },
                        ),
                        onTap: () {
                          // Navigate to detail page or show password details
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Viewing details for ${passwordEntry.website}')),
                          );
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add/Edit Password Page
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigate to Add Password Page')),
          );
        },
        tooltip: 'Add Password',
        child: const Icon(Icons.add),
      ),
    );
  }
}
