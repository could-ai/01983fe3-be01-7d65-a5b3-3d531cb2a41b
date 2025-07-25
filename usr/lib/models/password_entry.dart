import 'dart:convert';

class PasswordEntry {
  final String id;
  final String website;
  final String username;
  final String password;
  final String? notes;

  PasswordEntry({
    required this.id,
    required this.website,
    required this.username,
    required this.password,
    this.notes,
  });

  factory PasswordEntry.fromJson(Map<String, dynamic> json) {
    return PasswordEntry(
      id: json['id'] as String,
      website: json['website'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'website': website,
      'username': username,
      'password': password,
      'notes': notes,
    };
  }

  static List<PasswordEntry> decode(String passwords) =>
      (json.decode(passwords) as List<dynamic>)
          .map<PasswordEntry>((item) => PasswordEntry.fromJson(item))
          .toList();

  static String encode(List<PasswordEntry> passwords) => json.encode(
        passwords
            .map<Map<String, dynamic>>((password) => password.toJson())
            .toList(),
      );
}
