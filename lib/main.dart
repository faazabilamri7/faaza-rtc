import 'package:faaza_stream_rtc/call_screen.dart';
import 'package:faaza_stream_rtc/config.dart';
import 'package:faaza_stream_rtc/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final client = StreamVideo(
    AppConfig.apiKey,
    user: User.regular(
      userId: AppConfig.userId,
      role: AppConfig.userRole,
      name: AppConfig.userName,
    ),
    userToken: AppConfig.userToken,
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final StreamVideo client;

  const MyApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    // Islamic-inspired color scheme
    return MaterialApp(
      title: 'Faaza Video Call',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F7A54), // Islamic green
          primary: const Color(0xFF1F7A54),
          secondary: const Color(0xFFC99645), // Gold accent
          surface: const Color(0xFFF8F7F2),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Color(0xFF1F7A54)),
          displayMedium: TextStyle(color: Color(0xFF1F7A54)),
          bodyLarge: TextStyle(color: Color(0xFF333333)),
          bodyMedium: TextStyle(color: Color(0xFF333333)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1F7A54),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F7A54),
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(title: 'Faaza Quran Learning'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.video_call_rounded,
                  size: 80,
                  color: Color(0xFF1F7A54),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Welcome to Faaza Video Call',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F7A54),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Connect with family and friends in a secure environment',
                  style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    elevation: 4,
                  ),
                  onPressed: () async {
                    try {
                      var call = StreamVideo.instance.makeCall(
                        callType: StreamCallType.defaultType(),
                        id: AppConfig.generateCallId(),
                      );
                      await call.getOrCreate();

                      if (!mounted) return;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CallScreen(call: call),
                        ),
                      );
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  },
                  child: const Text(
                    'Start New Call',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
