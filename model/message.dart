class Message {
  String senderId;
  String receiverId;
  String content;
  DateTime timestamp;

  Message(
      {required this.senderId,
      required this.receiverId,
      required this.content,
      DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() {
    return 'From: $senderId, To: $receiverId, At: $timestamp\nMessage: $content';
  }
}
