// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ChatModel {
  String userUid;
  String picture;
  String name;
  String message;
  String time;
  ChatModel({
    required this.userUid,
    required this.picture,
    required this.name,
    required this.message,
    required this.time,
  });

  ChatModel copyWith({
    String? userUid,
    String? picture,
    String? name,
    String? message,
    String? time,
  }) {
    return ChatModel(
      userUid: userUid ?? this.userUid,
      picture: picture ?? this.picture,
      name: name ?? this.name,
      message: message ?? this.message,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userUid': userUid,
      'picture': picture,
      'name': name,
      'message': message,
      'time': time,
    };
  }

  factory ChatModel.fromMap(Map<dynamic, dynamic> map) {
    return ChatModel(
      userUid: map['userUid'] as String,
      picture: map['picture'] as String,
      name: map['name'] as String,
      message: map['message'] as String,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<dynamic, dynamic>);

  @override
  String toString() {
    return 'ChatModel(userUid: $userUid, picture: $picture, name: $name, message: $message, time: $time)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.userUid == userUid && other.picture == picture && other.name == name && other.message == message && other.time == time;
  }

  @override
  int get hashCode {
    return userUid.hashCode ^ picture.hashCode ^ name.hashCode ^ message.hashCode ^ time.hashCode;
  }
}

class ChatList {
  List<ChatModel> chats;
  ChatList({
    required this.chats,
  });

  ChatList copyWith({
    List<ChatModel>? chats,
  }) {
    return ChatList(
      chats: chats ?? this.chats,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chats': chats.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatList.fromMap(Map<dynamic, dynamic> map) {
    return ChatList(
      chats: List<ChatModel>.from(
        (map['chats'] as List<int>).map<ChatModel>(
          (x) => ChatModel.fromMap(x as Map<dynamic, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatList.fromJson(String source) => ChatList.fromMap(json.decode(source) as Map<dynamic, dynamic>);

  @override
  String toString() => 'ChatList(chats: $chats)';

  @override
  bool operator ==(covariant ChatList other) {
    if (identical(this, other)) return true;

    return listEquals(other.chats, chats);
  }

  @override
  int get hashCode => chats.hashCode;
}
