import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/request/presentation/widgets/service_in_progress_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/history_widget.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> servicesInProgress = [
      //lista de prueba
      {
        'name': 'Kira',
        'time': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'status': 'Por terminar',
      },
      {
        'name': 'Eevee',
        'time': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'status': 'Activo',
      },
      {
        'name': 'Manguito',
        'time': '2021-07-04 12:34:56',
        'service': 'Hospedaje - 3d',
        'status': 'Pendiente',
      },
      {
        'name': 'Kira',
        'time': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'status': 'Por terminar',
      },
    ];
    List<Map<String, dynamic>> history = [
      //lista de prueba
      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Eevee',
        'date': '2021-07-05 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Manguito',
        'date': '2021-07-06 12:34:56',
        'service': 'Hospedaje - 3d',
        'price': 250,
      },
      {
        'name': 'Manguito',
        'date': '2021-07-06 12:34:56',
        'service': 'Hospedaje - 3d',
        'price': 250,
      },
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: BuddiesIcons.logoRounded(sizeIcon: 50.0),
          shadowColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.0,
                  children: [
                    botonServicio(
                        context: context,
                        title: 'Paseo',
                        page: Pages.requestFormPage,
                        icon: BuddiesIcons.paseoIcon(
                            sizeIcon: 100.0, color: primaryColor)),
                    botonServicio(
                        context: context,
                        page: Pages.requestFormPage,
                        title: 'Hospedaje',
                        icon: BuddiesIcons.serviciosIcon(
                            sizeIcon: 100.0, color: primaryColor)),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Servicios en curso",
                      style: Font.titleStyle,
                    ),
                    servicesInProgress.length > 3
                        ? TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Pages.servicesListPage,
                                  arguments: {'list': servicesInProgress});
                            },
                            child: Text(
                              "Ver todos",
                              style: Font.textStyleBold(color: redColor),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                final service = servicesInProgress[index];

                return ServiceInProgressWidget(service: service);
              },
                  childCount: servicesInProgress.length > 3
                      ? 3
                      : servicesInProgress.length),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Historial",
                      style: Font.titleStyle,
                    ),
                    history.length > 3
                        ? TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Pages.historyListPage,
                                  arguments: {'list': history});
                            },
                            child: Text(
                              "Ver todos",
                              style: Font.textStyleBold(color: redColor),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                final entry = history[index];

                return HistoryWidget(history: entry);
              }, childCount: history.length > 3 ? 3 : history.length),
            ),
          ]),
        ),
      ),
    );
  }

  Widget botonServicio(
      {String? title,
      SvgPicture? icon,
      required String page,
      required BuildContext context}) {
    return ElevatedButton(
      onPressed: () =>
          Navigator.pushNamed(context, page, arguments: {'title': title}),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(inputGrey),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: redColor, width: 2.0),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title!,
            style: Font.titleStyle,
          ),
          icon!,
        ],
      ),
    );
  }
}
