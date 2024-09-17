class User {
  String id;
  String username;
  String password;
  List<String> contacts;

  User(
      {required this.id,
      required this.username,
      required this.password,
      required this.contacts});

  void addContact(String contactId) {
    if (!contacts.contains(contactId)) {
      contacts.add(contactId);
    }
  }

  void removeContact(String contactId) {
    contacts.remove(contactId);
  }

  @override
  String toString() {
    return 'User: $username, ID: $id';
  }
}
