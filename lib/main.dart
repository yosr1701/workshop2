// lib/main.dart
import 'package:flutter/material.dart';
import 'package:waiting_room_app/waiting_room_manager.dart';

void main() {
  runApp(const WaitingRoomApp());
}

class WaitingRoomApp extends StatelessWidget {
  const WaitingRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WaitingRoomScreen(),
    );
  }
}

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({super.key});

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  // Our logic manager is now part of the UI state.
  final WaitingRoomManager _manager = WaitingRoomManager();

  // This controller manages the text input field's value.
  final TextEditingController _controller = TextEditingController();

  void _addClient() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _manager.addClient(_controller.text.trim());
        _controller.clear();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Waiting Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
        // Input row
        Row(
        children: [
        Expanded(
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Client Name',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      const SizedBox(width: 8),
        ElevatedButton(
          onPressed: _addClient,
          child: const Text('Add'),
        ),
        ],
      ),
      const SizedBox(height: 16),
      // Queue length
      Text(
        'Clients in Queue: ${_manager.clients.length}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
        // List of clients with delete button
        Expanded(
          child: ListView.builder(
            itemCount: _manager.clients.length,
            itemBuilder: (context, index) {
              final clientName = _manager.clients[index];
              return Card(
                child: ListTile(
                  title: Text(clientName),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _manager.removeClient(clientName);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
        ],
      ),
    ),
    );
  }
}