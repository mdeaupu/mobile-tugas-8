import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas8/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          home: MyHomePage(),
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _loadInitialUsername();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _loadInitialUsername() async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    await themeProvider.loadUser();
    setState(() {
      _usernameController.text = themeProvider.userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas 8', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(themeProvider.isDarkMode ? 'Dark Mode' : 'Light Mode'),
                Switch(
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              ],
            ),
            SizedBox(height: 25),
            Column(
              children: [
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Masukan Nama Pengguna',
                    ),
                    onChanged: (value) {
                      themeProvider.saveUser(value);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
