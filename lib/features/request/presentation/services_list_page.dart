import 'package:flutter/material.dart';

class ServicesListPage extends StatelessWidget {
  const ServicesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          Center(
              child: Text('Aca se muestra la lista de los servicios en curso'))
        ],
      ),
    );
  }
}
