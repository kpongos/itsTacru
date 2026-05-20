import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProtocolDashboard(),
    );
  }
}

class ProtocolDashboard extends StatefulWidget {
  const ProtocolDashboard({super.key});

  @override
  State<ProtocolDashboard> createState() => _ProtocolDashboardState();
}

class _ProtocolDashboardState extends State<ProtocolDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> _protocols = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchProtocols();
  }

  Future<void> _fetchProtocols() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2/api/protocols'));
      if (response.statusCode == 200) {
        setState(() {
          _protocols = json.decode(response.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching protocols: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final bls = _protocols.where((p) => p['type'] == 'BLS').toList();
    final als = _protocols.where((p) => p['type'] == 'ALS').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TACRU Protocols'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'BLS'), Tab(text: 'ALS')],
        ),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                itemCount: bls.length,
                itemBuilder: (context, i) => ListTile(title: Text(bls[i]['title'])),
              ),
              ListView.builder(
                itemCount: als.length,
                itemBuilder: (context, i) => ListTile(title: Text(als[i]['title'])),
              ),
            ],
          ),
    );
  }
}