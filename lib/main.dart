import 'package:flutter/material.dart';

void main() {
  runApp(const RafeeqApp());
}

class RafeeqApp extends StatelessWidget {
  const RafeeqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الرفيق الذكي',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal,
          secondary: Colors.amber,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  bool _isVoiceRecording = false;

  final List<Widget> _screens = [
    const StreetNavigationScreen(),
    const FavoritePlacesScreen(),
    const TransitScreen(),
    const ToolsScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الرفيق الذكي',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          GestureDetector(
            onLongPressStart: (_) {
              setState(() {
                _isVoiceRecording = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🎤 جاري الاستماع للمساعد الذكي... (تحدث الآن)'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            onLongPressEnd: (_) {
              setState(() {
                _isVoiceRecording = false;
              });
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🔊 [نغمة تأكيد: تم استلام الطلب وبدء المعالجة محلياً]'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.teal,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _isVoiceRecording ? Colors.red : Colors.teal.shade700,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isVoiceRecording ? Icons.mic_flex_out : Icons.mic,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_road, size: 26),
            label: 'الشارع',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark, size: 26),
            label: 'المفضلة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_subway, size: 26),
            label: 'المواصلات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets, size: 26),
            label: 'الأدوات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 26),
            label: 'الإعدادات',
          ),
        ],
      ),
    );
  }
}

class StreetNavigationScreen extends StatefulWidget {
  const StreetNavigationScreen({super.key});

  @override
  State<StreetNavigationScreen> createState() => _StreetNavigationScreenState();
}

class _StreetNavigationScreenState extends State<StreetNavigationScreen> {
  bool _isNavigating = false;
  bool _isCallActive = false;

  int _scenarioIndex = 0;
  final List<String> _safetyMessages = [
    "الجانب الأيمن آمن ومفتوح.\nتوجيه: امشي مجاوراً للحائط الأيمن، ولا تمشِ في منتصف الشارع.",
    "تنبيه: حيوان ضال (كلب) متواجد على الرصيف الأيمن!\n«تغيير مسار تلقائي: انحرف خطوتين لليسار والابتعاد بمسافة آمنة»",
    "تنبيه: الجوانب مغلقة بسبب وجود سيارة متوقفة.\nتحول حذر للمنتصف: انتبه! توكتوك قادم من الأمام.",
    "تحذير سلامة: أرضية زلقة أمامك (مياه على السيراميك)!\nخفف سرعتك واخطُ بحذر.",
    "تنبيه مخاطر علوية: توجد تندة محلات منخفضة وشجرة بعد خطوتين!",
    "خطر انسداد الطريق بالكامل!\nتوقف فوراً! ارجع خطوتين للخلف واستند على الرصيف الأيمن."
  ];

  void _toggleNavigation() {
    setState(() {
      _isNavigating = !_isNavigating;
      _isCallActive = false;
    });
  }

  void _nextScenario() {
    if (_isNavigating && !_isCallActive) {
      setState(() {
        _scenarioIndex = (_scenarioIndex + 1) % _safetyMessages.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _nextScenario,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _isCallActive
                      ? Colors.orange.shade100
                      : (_isNavigating ? Colors.teal.shade50 : Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isCallActive
                        ? Colors.orange.shade800
                        : (_isNavigating ? Colors.teal : Colors.grey),
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    _isCallActive
                        ? "📞 مكالمة واردة الآن!\n\n«توقف جانباً على اليمين مجاوراً للحائط واثبت مكانك»\n\nتم رفع الصوت والاهتزاز، ثم إيقاف التوجيه مؤقتاً."
                        : (_isNavigating
                            ? _safetyMessages[_scenarioIndex]
                            : "انقر على الزر بالأسفل للبدء في التوجيه والحماية المستمرة للشارع."),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _isCallActive
                          ? Colors.orange.shade900
                          : (_isNavigating ? Colors.teal.shade900 : Colors.black87),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 80,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isNavigating ? Colors.redAccent : Colors.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: _toggleNavigation,
              icon: Icon(_isNavigating ? Icons.stop : Icons.shield, size: 36),
              label: Text(
                _isNavigating ? 'إيقاف نظام الحماية والتوجيه' : 'تشغيل الحماية والتوجيه الذكي',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritePlacesScreen extends StatelessWidget {
  const FavoritePlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'الأماكن المفضلة والتوجيه الداخلي والخارجي',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          onPressed: () {},
          icon: const Icon(Icons.add_location_alt, size: 28),
          label: const Text(
            'حفظ مسار جديد بالوصف الصوتي',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class TransitScreen extends StatelessWidget {
  const TransitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'مساعد المواصلات والمترو والوجهات الرئيسية',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'الأدوات الذكية المساعدة (بدون إنترنت)',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 15),
        Card(
          elevation: 4,
          child: ListTile(
            leading: const Icon(Icons.attach_money, color: Colors.teal, size: 36),
            title: const Text('قارئ العملات المصرية', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('التعرف اللحظي بالصوت على العملات الورقية والبلاستيكية'),
            onTap: () {},
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 4,
          child: ListTile(
            leading: const Icon(Icons.explore, color: Colors.teal, size: 36),
            title: const Text('بوصلة القبلة والمساجد', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('توجيه بصوت مرتفع واهتزاز خفيف لتحديد الاتجاه'),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _autoVolumeBoost = true;
  bool _hapticAssist = true;
  bool _strayAnimalAvoidance = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'إعدادات الصوت والحماية والاهتزاز',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 15),
        SwitchListTile(
          title: const Text('رفع مستوى الصوت تلقائياً (Auto Volume Boost)'),
          value: _autoVolumeBoost,
          activeColor: Colors.teal,
          onChanged: (val) => setState(() => _autoVolumeBoost = val),
        ),
        const Divider(),
        SwitchListTile(
          title: const Text('الاهتزاز المساعد للتوجيه الصوتي'),
          value: _hapticAssist,
          activeColor: Colors.teal,
          onChanged: (val) => setState(() => _hapticAssist = val),
        ),
        const Divider(),
        SwitchListTile(
          title: const Text('التجنب الآلي للحيوانات الضالة'),
          value: _strayAnimalAvoidance,
          activeColor: Colors.teal,
          onChanged: (val) => setState(() => _strayAnimalAvoidance = val),
        ),
      ],
    );
  }
}

