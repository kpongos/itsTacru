import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Safe web detector
import 'dart:io' show Platform; // Kept safe behind conditions

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const ApiTestScreen(),
    );
  }
}

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  String _backendMessage = "Press the button to fetch data";
  bool _isLoading = false;

  Future<void> fetchBackendData() async {
    setState(() {
      _isLoading = true;
    });

    String baseUrl = 'http://localhost';

    // 1. Check if running in a web browser first to avoid Platform crashes
    if (kIsWeb) {
      baseUrl = 'http://localhost'; 
    } 
    // 2. If it's not a web browser, it's safe to use the native Platform utility
    else if (Platform.isAndroid) {
      baseUrl = 'http://10.0.2.2'; // Target for native Android emulators
    }

    try {
      final dio = Dio();
      final response = await dio.get('$baseUrl/api/test-message');
      
      setState(() {
        _backendMessage = response.data['message'];
      });
    } catch (e) {
      setState(() {
        _backendMessage = "Failed connecting to backend: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('itsTacru Full-Stack Core'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                const CircularProgressIndicator()
              else
                Text(
                  _backendMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : fetchBackendData,
                icon: const Icon(Icons.cloud_download),
                label: const Text('Fetch Message From Docker'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}