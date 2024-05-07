import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_paddy/models/chat_model.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatSuccessState<T> extends ChatState {
  final T data;
  ChatSuccessState(this.data);
}

class ChatErrorState extends ChatState {
  final String message;
  ChatErrorState(this.message) {
    log(message);
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(ChatInitialState());

  Future watchForChats() async {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseDatabase.instance.ref('https://chatapp-e7f23-default-rtdb.firebaseio.com').child('chats/${user!.uid}').onChildAdded.listen((event) {
      final newChat = ChatModel.fromMap(event.snapshot.value as Map<dynamic, dynamic>);
      emit(ChatSuccessState<ChatList>(
        ChatList(chats: <ChatModel>[]),
      ));
      final chatList = (state as ChatSuccessState<ChatList>).data;
      emit(ChatSuccessState<ChatList>(
        chatList.copyWith(chats: [newChat, ...chatList.chats]),
      ));
    });
    FirebaseDatabase.instance.ref('https://chatapp-e7f23-default-rtdb.firebaseio.com').child('chats/${user.uid}').onChildChanged.listen((event) {
      final newChat = ChatModel.fromMap(event.snapshot.value as Map<dynamic, dynamic>);
      emit(ChatSuccessState<ChatList>(
        ChatList(chats: <ChatModel>[]),
      ));
      final chatList = (state as ChatSuccessState<ChatList>).data;
      emit(ChatSuccessState<ChatList>(
        chatList.copyWith(
            chats: chatList.chats.map((chat) {
          return chat == newChat ? newChat : chat;
        }).toList()),
      ));
    });

    FirebaseDatabase.instance.ref('https://chatapp-e7f23-default-rtdb.firebaseio.com').child('chats/${user.uid}').onChildRemoved.listen((event) {
      final removedChat = ChatModel.fromMap(event.snapshot.value as Map<dynamic, dynamic>);
      emit(ChatSuccessState<ChatList>(
        ChatList(chats: <ChatModel>[]),
      ));
      final chatList = (state as ChatSuccessState<ChatList>).data;
      emit(ChatSuccessState<ChatList>(
        chatList.copyWith(
            chats: chatList.chats.where((chat) {
          return chat != removedChat;
        }).toList()),
      ));
    });
  }

  Future addChat(ChatModel chat) async {
    emit(ChatLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;
      await FirebaseDatabase.instance.ref('https://chatapp-e7f23-default-rtdb.firebaseio.com').child('chats/${user!.uid}').set(chat.toJson());
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  Future getChats() async {
    emit(ChatLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;
      final chats = await FirebaseDatabase.instance.ref('https://chatapp-e7f23-default-rtdb.firebaseio.com').child('chats/${user!.uid}').once();
      final chatList = ChatList.fromMap(chats.snapshot.value as Map<dynamic, dynamic>);
      emit(ChatSuccessState<ChatList>(chatList));
    } catch (e) {
      emit(ChatErrorState(e.toString()));
    }
  }

  emit(ChatState value) {
    state = value;
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) => ChatNotifier());
