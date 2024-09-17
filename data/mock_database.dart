import 'database_repository.dart';


class MockDatabase implements DatabaseRepository {
  Map todoData = {};
  // ...
import 'database_repository.dart'
import '../models/user.dart';
import '../models/message.dart';

abstract class DatabaseRepository {
  // Create
  void addUser(User newUser);
  void addMessage(Message newMessage);

  // Read
  List<User> getAllUsers();
  List<Message> getMessagesByUserId(String userId);


  // Delete
  void deleteUserById(String userId);
  void deleteMessageById(String messageId);

  @override
  String toString() {
    return 'User: $username, ID: $id';
  @override
  String toString() {
    return 'From: $senderId, To: $receiverId, At: $timestamp\nMessage: $content';
}