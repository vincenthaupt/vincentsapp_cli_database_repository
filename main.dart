import 'dart:ffi';
import 'dart:io';
import 'dart:collection';
import 'user.dart';
import 'message.dart';
import 'data/database_repository.dart';
import 'data/mock_database.dart';
import 'user.dart';

void main() {
  DatabaseRepository mockDatabase = MockDatabase();

  // ... weitere Anweisungen
}

final Map<String, User> users = {};
final List<Message> messages = [];
User? currentUser;

void main() {
  print('Willkommen zur Messenger App!');

  String command;
  do {
    print('\nHauptmenü:');
    print('1. Anmelden');
    print('2. Registrieren');
    print('3. App Beenden');
    stdout.write('Wähle eine Option (1-3): ');
    command = stdin.readLineSync()!;

    switch (command) {
      case '1':
        login();
        break;
      case '2':
        register();
        break;
      case '3':
        print('App wird beendet...');
        break;
      default:
        print('Ungültige Auswahl. Bitte versuche es erneut.');
    }
  } while (command != '3');
}

void login() {
  stdout.write('Gib deinen Benutzernamen ein: ');
  String username = stdin.readLineSync()!;
  stdout.write('Gib dein Passwort ein: ');
  String password = stdin.readLineSync()!;

  User? user = users[username];

  if (user != null && user.password == password) {
    currentUser = user;
    print('Erfolgreich angemeldet als $username.');
    userMenu();
  } else {
    print('Anmeldung fehlgeschlagen. Benutzername oder Passwort ist falsch.');
  }
}

void register() {
  stdout.write('Wähle einen Benutzernamen: ');
  String username = stdin.readLineSync()!;

  if (users.containsKey(username)) {
    print(
        'Der Benutzername ist bereits vergeben. Versuche es mit einem anderen.');
    return;
  }

  stdout.write('Gib ein Passwort ein: ');
  String password = stdin.readLineSync()!;

  String id = DateTime.now().millisecondsSinceEpoch.toString();
  User newUser =
      User(id: id, username: username, password: password, contacts: []);
  users[username] = newUser;

  print('Benutzer $username wurde erfolgreich registriert.');
}

void userMenu() {
  String command;
  do {
    print('\nBenutzermenü:');
    print('1. Kontakt hinzufügen');
    print('2. Nachricht senden');
    print('3. Nachrichten anzeigen');
    print('4. Abmelden');
    stdout.write('Wähle eine Option (1-4): ');
    command = stdin.readLineSync()!;

    switch (command) {
      case '1':
        addContact();
        break;
      case '2':
        sendMessage();
        break;
      case '3':
        viewMessages();
        break;
      case '4':
        currentUser = null;
        print('Du wurdest abgemeldet.');
        break;
      default:
        print('Ungültige Auswahl. Bitte versuche es erneut.');
    }
  } while (command != '4' && currentUser != null);
}

void addContact() {
  stdout.write('Gib den Benutzernamen des Kontakts ein: ');
  String contactUsername = stdin.readLineSync()!;

  if (users.containsKey(contactUsername)) {
    currentUser!.addContact(users[contactUsername]!.id);
    print('Kontakt $contactUsername wurde hinzugefügt.');
  } else {
    print('Benutzer $contactUsername existiert nicht.');
  }
}

void sendMessage() {
  stdout.write('Gib den Benutzernamen des Empfängers ein: ');
  String receiverUsername = stdin.readLineSync()!;

  if (!users.containsKey(receiverUsername)) {
    print('Der Benutzer $receiverUsername existiert nicht.');
    return;
  }

  stdout.write('Gib deine Nachricht ein: ');
  String content = stdin.readLineSync()!;

  String receiverId = users[receiverUsername]!.id;
  Message newMessage = Message(
      senderId: currentUser!.id, receiverId: receiverId, content: content);
  messages.add(newMessage);

  print('Nachricht an $receiverUsername gesendet.');
}

void viewMessages() {
  print('\nNachrichten:');
  bool hasMessages = false;

  for (var message in messages) {
    if (message.receiverId == currentUser!.id ||
        message.senderId == currentUser!.id) {
      String senderUsername =
          users.values.firstWhere((u) => u.id == message.senderId).username;
      String receiverUsername =
          users.values.firstWhere((u) => u.id == message.receiverId).username;
      print(
          'Von: $senderUsername, An: $receiverUsername, Zeit: ${message.timestamp}');
      print('Nachricht: ${message.content}\n');
      hasMessages = true;
    }
  }

  if (!hasMessages) {
    print('Keine Nachrichten vorhanden.');
  }
}
