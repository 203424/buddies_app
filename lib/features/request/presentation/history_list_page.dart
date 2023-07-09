import 'package:flutter/material.dart';

class HistoryListPage extends StatelessWidget {
  const HistoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          Center(child: Text('Aca se muestra el historial completo en forma de lista'))
        ],
      ),
    );
  }
}