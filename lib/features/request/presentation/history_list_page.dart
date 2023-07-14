import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';
import 'widgets/history_widget.dart';

class HistoryListPage extends StatelessWidget {
  final List<Map<String, dynamic>> list;
  const HistoryListPage({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          'Historial',
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
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final entry = list[index];

                return HistoryWidget(history: entry);
              },
              childCount: list.length,
            ))
          ],
        ),
      ),
    ));
  }
}
