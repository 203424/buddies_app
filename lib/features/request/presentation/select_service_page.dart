import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';

class SelectServicePage extends StatefulWidget {
  const SelectServicePage({super.key});

  @override
  State<SelectServicePage> createState() => _SelectServicePageState();
}

class _SelectServicePageState extends State<SelectServicePage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> groupOptions = [
      {
        'name': 'Paseo de 30min',
        'cost': 40.0,
        'service': 'Paseo grupal - 30min'
      },
      {'name': 'Paseo de 1hr', 'cost': 80.0, 'service': 'Paseo grupal - 1hr'},
      {
        'name': 'Paseo de 2hrs',
        'cost': 160.0,
        'service': 'Paseo grupal - 2hrs'
      },
    ];

    List<Map<String, dynamic>> individualOptions = [
      {
        'name': 'Paseo de 30min',
        'cost': 50.0,
        'service': 'Paseo individual - 30min'
      },
      {
        'name': 'Paseo de 1hr',
        'cost': 100.0,
        'service': 'Paseo individual - 1hr'
      },
      {
        'name': 'Paseo de 2hrs',
        'cost': 200.0,
        'service': 'Paseo individual - 2hrs'
      },
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title:
              const Text('Selecciona un paquete', style: Font.pageTitleStyle),
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(color: black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomScrollView(slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  'Paseo grupal',
                  style: Font.titleBoldStyle,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final dynamic service = groupOptions[index];
                  return customOptionButton(service);
                },
                childCount: groupOptions.length,
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  'Paseo individual',
                  style: Font.titleBoldStyle,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final dynamic service = individualOptions[index];
                  return customOptionButton(service);
                },
                childCount: groupOptions.length,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget customOptionButton(service) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, service);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(inputGrey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  service['name'],
                  style: Font.textStyle,
                ),
                Text(
                  '\$${service['cost'].toStringAsFixed(2)}',
                  style: Font.numberStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )),
    );
  }
}
