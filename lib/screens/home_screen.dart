import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/session_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userController = TextEditingController();
  final deviceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final service = context.watch<SessionService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('RB Tree Session Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: userController,
              decoration: const InputDecoration(
                labelText: 'User ID',
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: deviceController,
              decoration: const InputDecoration(
                labelText: 'Device ID',
              ),
            ),

            const SizedBox(height: 20),

            SwitchListTile(
              title: const Text('Single Device Mode'),
              value: service.singleDeviceMode,
              onChanged: (value) {
                service.singleDeviceMode = value;
                service.notifyListeners();
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                service.login(
                  userId: userController.text,
                  deviceId: deviceController.text,
                );
              },
              child: const Text('LOGIN'),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: service.sessions.length,
                itemBuilder: (context, index) {
                  final session = service.sessions[index];

                  return Card(
                    child: ListTile(
                      title: Text(session.userId),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Session: ${session.sessionId}'),
                          Text('Device: ${session.deviceId}'),
                          Text('Login: ${session.loginTime}'),
                          Text('Last Active: ${session.lastActiveTime}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          service.logout(session.sessionId);
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}