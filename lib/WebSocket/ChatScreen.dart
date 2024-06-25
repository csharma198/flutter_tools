import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'package:equatable/equatable.dart';



class MyAppChat extends StatelessWidget {
  const MyAppChat({super.key});

  @override
  Widget build(BuildContext context) {
   // final channel = IOWebSocketChannel.connect('wss://socket.zilaghaziabad.com:6001');
    final channel = IOWebSocketChannel.connect('wss://connect.websocket.in/v3/1?api_key=B6rn1zIi1xpwxRGDaEOxbMSW1GEKswQilAUvXa09&notify_self');
    final chatBloc = ChatBloc(channel);

    return MaterialApp(
      home: BlocProvider(
        create: (context) => chatBloc,
        child: Scaffold(
          appBar: AppBar(title: const Text('Chat')),
          body: ChatScreen(),
        ),
      ),
    );
  }
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final IOWebSocketChannel channel;

  ChatBloc(this.channel) : super(ChatInitial()) {
    on<SendMessage>((event, emit) {
      channel.sink.add(event.message);
    });
    on<ReceiveMessage>((event, emit) {
      emit(ChatReceived(message: event.message));
    });

    channel.stream.listen((message) {
      add(ReceiveMessage(message));
    });
  }

  @override
  Future<void> close() {
    channel.sink.close();
    return super.close();
  }
}

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends ChatEvent {
  final String message;

  const SendMessage(this.message);

  @override
  List<Object> get props => [message];
}

class ReceiveMessage extends ChatEvent {
  final String message;

  const ReceiveMessage(this.message);

  @override
  List<Object> get props => [message];
}

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatReceived extends ChatState {
  final String message;

  const ChatReceived({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);

    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatReceived) {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(state.message));
                  },
                );
              }
              return const Center(child: Text('No messages'));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter your message',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  final message = _controller.text;
                  if (message.isNotEmpty) {
                    chatBloc.add(SendMessage(message));
                    _controller.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
