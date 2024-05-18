import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:technical_test_assist/app/helpers/format_string.dart';
import 'package:technical_test_assist/utils/constants_asset_image.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pegawai'),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) {
          final data = state!;

          return ListView.separated(
            itemCount: data.length,
            separatorBuilder: (context, index) => const Gap(8),
            itemBuilder: (context, index) {
              final item = data[index];

              var address = '${item.jalan}';

              final provinsi =
                  FormatString.capitalizeEachWord(item.provinsi?.name);
              final kabupaten =
                  FormatString.capitalizeEachWord(item.kabupaten?.name);
              final kecamatan =
                  FormatString.capitalizeEachWord(item.kecamatan?.name);
              final kelurahan =
                  FormatString.capitalizeEachWord(item.kelurahan?.name);

              if (provinsi.isNotEmpty) {
                address += ', $provinsi';
              }

              if (kabupaten.isNotEmpty) {
                address += ', $kabupaten';
              }

              if (kecamatan.isNotEmpty) {
                address += ', $kecamatan';
              }

              if (kelurahan.isNotEmpty) {
                address += ', $kelurahan';
              }

              return ListTile(
                onTap: () => controller.moveToForm(
                  id: item.id,
                  type: Type.update,
                  data: item,
                ),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage(ConstantsAssetImage.noPhoto),
                  radius: 24,
                ),
                title: Text('${item.nama}'),
                titleTextStyle: textTheme.titleLarge,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: Colors.red,
                        ),
                        const Gap(2),
                        Expanded(
                          child: Text(address),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.moveToForm(type: Type.add),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Tambah Pegawai'),
      ),
    );
  }
}
