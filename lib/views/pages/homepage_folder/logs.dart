import 'package:flutter/material.dart';

class Logs extends StatefulWidget {
  const Logs({super.key});

  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('LOGS HERE'),
      ),
    );
  }
}
