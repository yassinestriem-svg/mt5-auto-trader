import 'package:flutter/material.dart';

void main() {
  runApp(const AutoTraderApp());
}

class AutoTraderApp extends StatelessWidget {
  const AutoTraderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFFF59E0B),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _serverController = TextEditingController();
  
  String _tradingStyle = 'scalping';
  String _symbol = 'XAUUSD';
  bool _isConnected = false;
  bool _isBotRunning = false;

  void _handleConnect() {
    if (_loginController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      setState(() => _isConnected = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم الاتصال بالحساب بنجاح!')),
      );
    }
  }

  void _toggleBot() {
    setState(() => _isBotRunning = !_isBotRunning);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚡ منصة MT5 الآلية'),
        backgroundColor: const Color(0xFF1E293B),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.circle,
              color: _isConnected ? Colors.green : Colors.red,
              size: 16,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('1. بيانات حساب MetaTrader 5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    TextField(controller: _loginController, decoration: const InputDecoration(labelText: 'رقم الحساب (Login)')),
                    TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'كلمة المرور')),
                    TextField(controller: _serverController, decoration: const InputDecoration(labelText: 'اسم الخادم (Server)')),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF59E0B), minimumSize: const Size.fromHeight(48)),
                      onPressed: _handleConnect,
                      child: const Text('ربط الحساب', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('2. استراتيجية التداول', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _tradingStyle,
                      items: const [
                        DropdownMenuItem(value: 'scalping', child: Text('⚡ سكالبينغ (Scalping)')),
                        DropdownMenuItem(value: 'swing', child: Text('📈 سوينغ (Swing Trading)')),
                      ],
                      onChanged: (val) => setState(() => _tradingStyle = val!),
                      decoration: const InputDecoration(labelText: 'نمط التداول'),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _symbol,
                      items: const [
                        DropdownMenuItem(value: 'XAUUSD', child: Text('الذهب (XAUUSD)')),
                        DropdownMenuItem(value: 'EURUSD', child: Text('اليورو / دولار (EURUSD)')),
                      ],
                      onChanged: (val) => setState(() => _symbol = val!),
                      decoration: const InputDecoration(labelText: 'زوج التداول'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isBotRunning ? Colors.red : Colors.green,
                        minimumSize: const Size.fromHeight(48),
                      ),
                      onPressed: _isConnected ? _toggleBot : null,
                      child: Text(_isBotRunning ? 'إيقاف الروبوت' : 'تشغيل الروبوت الآلي', style: const TextStyle(fontWeight: FontWeight.bold)),
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
