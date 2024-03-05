import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/home_page.dart';

import 'history_model.dart';

void main(){
  runApp(
      ChangeNotifierProvider(create: (context) => HistoryModel(),
        child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          dividerTheme: DividerThemeData(
            color: Colors.transparent
          ),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
              size: 30
            )
          )
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
    );
  }
}
