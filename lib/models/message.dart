import 'dart:convert';

class Message {
  final int id;
  final int sender;
  final int recipient;
  final String message;
  final DateTime sentAt;
  final bool isRead;
  final bool is_sent_by_user;
  final String? image;

  // Constructeur
  Message({
    required this.id,
    required this.sender,
    required this.recipient,
    required this.message,
    required this.sentAt,
    required this.isRead,
    required this.is_sent_by_user,
    required this.image,
  });

  // Méthode pour convertir un objet Message en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'recipient': recipient,
      'message': message,
      'sent_at': sentAt.toIso8601String(), // Format ISO 8601 pour DateTime
      'is_read': isRead,
      'is_sent_by_user':is_sent_by_user,
      'image':image
    };
  }

  // Méthode pour créer un objet Message depuis un JSON
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      sender: json['sender'],
      recipient: json['recipient'],
      message: json['message'],
      sentAt: DateTime.parse(json['sent_at']), // Reconversion en DateTime
      isRead: json['is_read'],
      is_sent_by_user: json['is_sent_by_user'],
      image: json['image']
    );
  }
}
//
// void main() {
//   // Exemple de création d'un objet Message
//   Message message = Message(
//     id: 1,
//     sender: 1,
//     recipient: 1,
//     message: "salut",
//     sentAt: DateTime.parse("2024-12-01T18:14:41.745138Z"),
//     isRead: false,
//   );
//
//   // Conversion de l'objet Message en JSON
//   String jsonString = jsonEncode(message.toJson());
//   print('Message en JSON: $jsonString');
//
//   // Conversion du JSON en objet Message
//   Map<String, dynamic> messageJson = jsonDecode(jsonString);
//   Message newMessage = Message.fromJson(messageJson);
//   print('Message reconverti: ${newMessage.message}, Sent at: ${newMessage.sentAt}');
// }