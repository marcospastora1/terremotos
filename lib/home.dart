import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terremotos/controller.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomePage extends GetView<Controller> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terremotos'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () {
            if (controller.load.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: controller.dados['features']?.length ?? 0,
                itemBuilder: (_, index) {
                  initializeDateFormatting('fr_FR', null);
                  Intl.defaultLocale = 'pt_BR';
                  var format = DateFormat.yMMMMd('pt_BR').add_jm();
                  var data = format.format(
                    DateTime.fromMicrosecondsSinceEpoch(
                      controller.dados['features'][index]['properties']
                              ['time'] *
                          1000,
                    ),
                  );

                  if (controller.statusError.value == false) {
                    return Column(
                      children: [
                        const Divider(
                          height: 15,
                        ),
                        ListTile(
                          onTap: () => Get.defaultDialog(
                            title: 'Terremoto',
                            middleText:
                                '${controller.dados['features'][index]['properties']['place']}',
                          ),
                          title: Text(
                            data,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${controller.dados['features'][index]['properties']['place']}',
                          ),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.green,
                            child: Text(
                              '${controller.dados['features'][index]['properties']['mag'].toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text('Erro ao carregar dados'),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
