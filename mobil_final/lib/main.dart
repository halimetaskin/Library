import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yemekhane/page/login/home_login.dart';
import 'package:yemekhane/services/themedata.dart';

void main() {
  runApp(
    ChangeNotifierProvider<SerTehmeData>(
        create: (context) => SerTehmeData(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //widgetım oluşmadan önce veri tabanımdan en son yapılan tema bilgisini alıp güncelledim
    Provider.of<SerTehmeData>(context).loadTheme();

    return MaterialApp(
      theme: Provider.of<SerTehmeData>(context).defaultTheme
          ? ThemeData.light()
          : ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const LoginScreen(),
    );
  }
}
