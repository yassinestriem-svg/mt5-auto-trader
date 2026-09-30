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
      title: 'MT5 Auto-Trader',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFFF59E0B),
        cardColor: const Color(0xFF1E293B),
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
  final List<String> _logs = [];

  void _handleConnect() {
    if (_loginController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      setState(() {
        _isConnected = true;
        _logs.add('[${DateTime.now().toString().substring(11, 19)}] تم الاتصال بالخادم بنجاح.');
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم الاتصال بحساب التداول بنجاح!')),
      );
    }
  }

  void _toggleBot() {
    setState(() {
      _isBotRunning = !_isBotRunning;
      if (_isBotRunning) {
        _logs.add('[${DateTime.now().toString().substring(11, 19)}] تم تشغيل الروبوت على $_symbol.');
      } else {
        _logs.add('[${DateTime.now().toString().substring(11, 19)}] تم إيقاف الروبوت.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Row(
          children: [
            Icon(Icons.bolt, color: Color(0xFFF59E0B)),
            SizedBox(width: 8),
            Text('MT5 Auto-Trader Pro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🔑 بيانات حساب MetaTrader 5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFF59E0B))),
                    const SizedBox(height: 12),
                    TextField(controller: _loginController, decoration: const InputDecoration(labelText: 'رقم الحساب (Login ID)', border: OutlineInputBorder())),
                    const SizedBox(height: 10),
                    TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'كلمة المرور (Password)', border: OutlineInputBorder())),
                    const SizedBox(height: 10),
                    TextField(controller: _serverController, decoration: const InputDecoration(labelText: 'اسم الخادم (Server)', border: OutlineInputBorder())),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF59E0B), minimumSize: const Size.fromHeight(48)),
                      onPressed: _handleConnect,
                      child: const Text('ربط الحساب بالخادم', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('⚙️ إعدادات الاستراتيجية والتداول', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFF59E0B))),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _symbol,
                      items: const [
                        DropdownMenuItem(value: 'XAUUSD', child: Text('الذهب (XAUUSD)')),
                        DropdownMenuItem(value: 'EURUSD', child: Text('اليورو / دولار (EURUSD)')),
                      ],
                      onChanged: (val) => setState(() => _symbol = val!),
                      decoration: const InputDecoration(labelText: 'زوج التداول', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _tradingStyle,
                      items: const [
                        DropdownMenuItem(value: 'scalping', child: Text('⚡ سكالبينغ (Scalping)')),
                        DropdownMenuItem(value: 'swing', child: Text('📈 سوينغ (Swing Trading)')),
                      ],
                      onChanged: (val) => setState(() => _tradingStyle = val!),
                      decoration: const InputDecoration(labelText: 'نمط التداول', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isBotRunning ? Colors.red : Colors.green,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: _isConnected ? _toggleBot : null,
                      child: Text(
                        _isBotRunning ? '🛑 إيقاف الروبوت' : '🚀 تشغيل الروبوت الآلي',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('📊 سجل العمليات اللحظي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 10),
                    Container(
                      height: 120,
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(8)),
                      child: _logs.isEmpty
                          ? const Center(child: Text('لا توجد عمليات حالية', style: TextStyle(color: Colors.grey)))
                          : ListView.builder(
                              itemCount: _logs.length,
                              itemBuilder: (context, index) => Text(_logs[index], style: const TextStyle(color: Colors.greenAccent, fontSize: 12)),
                            ),
                    )
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
