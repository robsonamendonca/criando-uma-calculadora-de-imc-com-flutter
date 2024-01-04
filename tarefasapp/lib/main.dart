import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:tarefasapp/pages/welcome_page.dart';
import 'package:tarefasapp/services/category_purchase_service.dart';
import 'package:tarefasapp/services/dark_mode_service.dart';
import 'package:tarefasapp/shared/app_settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppSettings.screenWidth = MediaQuery.of(context).size.width;
    AppSettings.screenHeight = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeService>(
            create: (_) => DarkModeService()),
        ChangeNotifierProvider<CategoryPurchaseService>(
          create: (ctx) => CategoryPurchaseService(),
        )
      ],
      child: Consumer<DarkModeService>(builder: (_, darkModeService, widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'O que compra? (QcomprarApp)',
          theme:
              darkModeService.darkMode ? ThemeData.dark() : ThemeData.light(),
          home: const WelcomPage(),
        );
      }),
    );
  }
}
