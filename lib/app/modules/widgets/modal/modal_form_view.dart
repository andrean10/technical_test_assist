import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:technical_test_assist/app/data/models/region_model/wilayah_kab_or_kota_model.dart';
import 'package:technical_test_assist/app/data/models/region_model/wilayah_kecamatan_model.dart';
import 'package:technical_test_assist/app/data/models/region_model/wilayah_kelurahan_model.dart';
import 'package:technical_test_assist/app/data/models/region_model/wilayah_provinsi_model.dart';

import '../state_process/state_process_widget.dart';

class ModalFormView<T extends GetxController, K> extends GetView<T> {
  final ScrollController _scrollController;
  final String title;
  final Future<List<K>> fetchData;
  final void Function(K) itemTap;
  final Widget? customBuilderBody;

  const ModalFormView(
    this._scrollController, {
    required this.title,
    required this.fetchData,
    required this.itemTap,
    this.customBuilderBody,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget builderAppBar() {
      return SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: theme.dividerColor)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: AutoSizeText(
                  'Pilih $title',
                  style: theme.textTheme.titleLarge,
                ),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
        ),
      );
    }

    Widget builderBody() {
      return Expanded(
        child: customBuilderBody ??
            FutureBuilder(
              future: fetchData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return StateProcessWidget.onLoading();
                } else if (snapshot.hasError) {
                  return StateProcessWidget.onError();
                } else if (snapshot.hasData && snapshot.data != null) {
                  var data = [];

                  if (snapshot.data is List<WilayahProvinsiModel>) {
                    data = snapshot.data as List<WilayahProvinsiModel>;
                  } else if (snapshot.data is List<WilayahKabOrKotaModel>) {
                    data = snapshot.data as List<WilayahKabOrKotaModel>;
                  } else if (snapshot.data is List<WilayahKecamatanModel>) {
                    data = snapshot.data as List<WilayahKecamatanModel>;
                  } else if (snapshot.data is List<WilayahKelurahanModel>) {
                    data = snapshot.data as List<WilayahKelurahanModel>;
                  } else {
                    data = snapshot.data as List;
                  }

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final item = data[index];

                      return ListTile(
                        onTap: () {
                          itemTap(item);
                          Get.back();
                        },
                        title: AutoSizeText(
                          '${item.name}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                    itemCount: data.length,
                  );
                }

                return StateProcessWidget.onEmpty(title);
              },
            ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        builderAppBar(),
        builderBody(),
      ],
    );
  }
}
