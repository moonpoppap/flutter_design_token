import 'package:design_token/design_tokens.dart';
import 'package:design_token/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesignTokens.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // bool? isDarkMode = false;
  // SharedPreferences? sharedPreferences;

  MyApp({super.key, SharedPreferences? sharedPreferences /*bool? isDarkMode*/
      });

  @override
  Widget build(BuildContext context) {
    // final bool isDarkMode = sharedPreferences?.getBool(ThemeProvider.THEME_KEY) ?? true;
    // bool isDarkMode = widget.isDarkMode ?? false;
    // final themeProvider = Provider.of<ThemeProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getTheme(!(themeProvider.isDarkMode)),
            darkTheme: AppTheme.getTheme(themeProvider.isDarkMode),
            // themeMode: themeProvider.themeMode,
            home: MyHomePage(),
          );
        },
      ),
    );

    // return ChangeNotifierProvider(
    //   create: (_) => ThemeProvider(),
    //   builder: (context, child) {
    //     return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       theme: AppTheme.getTheme(!isDarkMode),
    //       darkTheme: AppTheme.getTheme(isDarkMode),
    //       themeMode: ThemeMode.system,
    //       // theme: ThemeData(
    //       //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //       //   useMaterial3: true,
    //       // ),
    //       home: MyHomePage(isDarkMode),
    //     );
    //   },
    //
    // );
  }
}

class MyHomePage extends StatefulWidget {
  // bool? isDarkMode;

  MyHomePage(/*bool isDarkMode,*/ {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();

    return Scaffold(
      // backgroundColor: DesignTokens.getColor('background'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'POPPAP',
              style: Theme.of(context).textTheme.bodyLarge,
              // style: DesignTokens.getTextStyle('body1'),
              // style: TextStyle(color: Colors.deepPurpleAccent),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 0,
                ),
                onPressed: () async {
                  themeProvider.toggleTheme();
                },
                child: const Text(
                  'change mode',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
