import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memo/pages/done.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:memo/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    // Use the ffi on windows
    sqfliteFfiInit();
    databaseFactoryOrNull = databaseFactoryFfi;
  }
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _pageIdx = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_pageIdx) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const DonePage();
        break;
      default:
        throw UnimplementedError('no widget for $_pageIdx');
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Row(children: [
        SafeArea(
          child: NavigationRail(
            backgroundColor: Colors.grey.shade200,
            extended: false,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.check_circle),
                label: Text('Favorites'),
              ),
            ],
            selectedIndex: _pageIdx,
            onDestinationSelected: (value) {
              setState(() {
                _pageIdx = value;
              });
            },
          ),
        ),
        Expanded(
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: page,
          ),
        ),
      ]),
    );
  }
}
