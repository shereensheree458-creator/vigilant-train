import 'package:flutter/material.dart';

void main() {
  runApp(const RafeeqSmartApp());
}

class RafeeqSmartApp extends StatelessWidget {
  const RafeeqSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rafeeq Smart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MainDashboard(),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rafeeq Smart - Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          stretch: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_road, size: 40),
                label: const Text('Street Mode', style: TextStyle(fontSize: 24)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const StreetModeScreen()));
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.bookmark, size: 40),
                label: const Text('Favorite Places', style: TextStyle(fontSize: 24)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesModeScreen()));
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.directions_bus, size: 40),
                label: const Text('Transit Mode', style: TextStyle(fontSize: 24)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const TransitModeScreen()));
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.amber[700],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mic, size: 36, color: Colors.black),
                    SizedBox(width: 10),
                    Text(
                      'Voice Assistant (Hold to Speak)',
                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreetModeScreen extends StatelessWidget {
  const StreetModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Street Mode')),
      body: const Center(
        child: Text('Offline Vision active', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class FavoritesModeScreen extends StatelessWidget {
  const FavoritesModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Places')),
      body: const Center(
        child: Text('Door-to-door navigation', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class TransitModeScreen extends StatelessWidget {
  const TransitModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transit Mode')),
      body: const Center(
        child: Text('Transit guidance active', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(
        child: Text('Settings Screen', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

