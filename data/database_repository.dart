import '../model/user.dart';
import '../model/message.dart';

abstract class DatabaseRepository {
  //alle user abrufen
  List<User> getAllUsers();

  //nachrichten aufrufen
  List<Message> getMessagesByUserId(String userId);

  //benutzer hinzufügen
  void addUser(User newUser);

  // benutzer löschen
  void deleteUserById(String userId);

  // nachricht schicken
  void addMessage(Message newMessage);

  // nachricht löschen
  void deleteMessageById(String messageId);
}
