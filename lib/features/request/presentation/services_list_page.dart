import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';

import 'widgets/service_in_progress_widget.dart';

class ServicesListPage extends StatelessWidget {
  final List<Map<String, dynamic>> list;
  const ServicesListPage({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          'Servicio en curso',
          style: Font.pageTitleStyle,
        ),
        iconTheme: const IconThemeData(color: greyColor),
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                final service = list[index];

                return ServiceInProgressWidget(service: service);
              }, childCount: list.length),
            ),
          ],
        ),
      ),
    ));
  }
}
