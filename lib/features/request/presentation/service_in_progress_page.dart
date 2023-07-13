import 'package:flutter/material.dart';

class ServiceInProgressPage extends StatelessWidget {
  const ServiceInProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          Center(child: Text('Aca se muestra la info del servicio en curso'))
        ],
      ),
    );
  }
}
