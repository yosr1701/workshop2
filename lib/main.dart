// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiting_room_app/queue_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => QueueProvider(),
      child: const WaitingRoomApp(),
    ),
  );
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

class WaitingRoomScreen extends StatelessWidget {
  const WaitingRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen for changes in the QueueProvider
    final queueProvider = context.watch<QueueProvider>();
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Waiting Room'),
        actions: [
          IconButton(
            key: const Key('nextClientButton'),
            icon: const Icon(Icons.skip_next),
            onPressed: () {
              // Call nextClient() without listening for rebuild
              context.read<QueueProvider>().nextClient();
            },
            tooltip: 'Next Client',
          ),
        ],
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
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              context.read<QueueProvider>().addClient(_controller.text.trim());
              _controller.clear();
            }
          },
          child: const Text('Add'),
        ),
        ],
      ),
      const SizedBox(height: 16),
      // Queue length
      Text(
        'Clients in Queue: ${queueProvider.clients.length}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
        // List of clients with delete button
        Expanded(
          child: ListView.builder(
            itemCount: queueProvider.clients.length,
            itemBuilder: (context, index) {
              final clientName = queueProvider.clients[index];
              return Card(
                child: ListTile(
                  title: Text(clientName),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<QueueProvider>().removeClient(clientName);
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