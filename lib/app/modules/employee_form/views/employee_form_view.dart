import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:technical_test_assist/app/data/models/region_model/wilayah_kab_or_kota_model.dart';
import 'package:technical_test_assist/app/data/models/region_model/wilayah_kecamatan_model.dart';
import 'package:technical_test_assist/app/data/models/region_model/wilayah_kelurahan_model.dart';
import 'package:technical_test_assist/app/data/models/region_model/wilayah_provinsi_model.dart';
import 'package:technical_test_assist/app/modules/main/controllers/main_controller.dart';
import 'package:technical_test_assist/app/modules/widgets/buttons/custom_filled_button.dart';

import '../../../helpers/validation.dart';
import '../../widgets/modal/modal_form_view.dart';
import '../../widgets/textformfield/custom_text_form_field.dart';
import '../controllers/employee_form_controller.dart';

class EmployeeFormView extends GetView<EmployeeFormController> {
  const EmployeeFormView({super.key});

  @override
  Widget build(BuildContext context) {
    void showBottomSheet<T>({
      required String title,
      required Future<List<T>> fetchData,
      required void Function(T) itemTap,
      double? initialChildSize,
    }) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        useSafeArea: true,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: initialChildSize ?? 0.75,
            expand: false,
            snap: true,
            snapSizes: const [0.5, 0.75, 1],
            builder: (context, scrollController) =>
                ModalFormView<EmployeeFormController, T>(
              scrollController,
              title: title,
              fetchData: fetchData,
              itemTap: itemTap,
            ),
          );
        },
      );
    }

    Widget builderName() {
      return Obx(
        () => CustomTextField(
          controller: controller.nameC,
          focusNode: controller.nameF,
          title: 'Nama',
          hintText: 'Misal Anton',
          suffixIconState: controller.name.value.isNotEmpty,
          keyboardType: TextInputType.name,
          validator: (value) => Validation.formField(
            value: value,
            titleField: 'Nama',
          ),
        ),
      );
    }

    Widget builderProvince() {
      return CustomTextField(
        controller: controller.provinceC,
        focusNode: controller.provinceF,
        title: 'Provinsi',
        hintText: 'Pilih Provinsi',
        suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        isReadOnly: true,
        validator: (value) => Validation.formField(
          value: value,
          titleField: 'Provinsi',
        ),
        onTap: () => showBottomSheet<WilayahProvinsiModel>(
          title: 'Provinsi',
          fetchData: controller.fetchProvince(),
          itemTap: (value) => controller.setProvince(value),
        ),
      );
    }

    Widget builderKabupaten() {
      return Obx(
        () => CustomTextField(
          controller: controller.kabupatenC,
          focusNode: controller.kabupatenF,
          title: 'Kabupaten',
          hintText: 'Pilih Kabupaten',
          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
          isReadOnly: true,
          isEnable: controller.dataProvince.value.id != null,
          validator: (value) => Validation.formField(
            value: value,
            titleField: 'Kabupaten',
          ),
          onTap: () => showBottomSheet<WilayahKabOrKotaModel>(
            title: 'Kabupaten',
            fetchData: controller.fetchKabupaten(),
            itemTap: (value) => controller.setKabupaten(value),
          ),
        ),
      );
    }

    Widget builderKecamatan() {
      return Obx(
        () => CustomTextField(
          controller: controller.kecamatanC,
          focusNode: controller.kecamatanF,
          title: 'Kecamatan',
          hintText: 'Pilih Kecamatan',
          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
          isReadOnly: true,
          isEnable: controller.dataKabAtauKota.value.id != null,
          validator: (value) => Validation.formField(
            value: value,
            titleField: 'Kecamatan',
          ),
          onTap: () => showBottomSheet<WilayahKecamatanModel>(
            title: 'Kecamatan',
            fetchData: controller.fetchKecamatan(),
            itemTap: (value) => controller.setKecamatan(value),
          ),
        ),
      );
    }

    Widget builderKelurahan() {
      return Obx(
        () => CustomTextField(
          controller: controller.kelurahanC,
          focusNode: controller.kelurahanF,
          title: 'Kelurahan',
          hintText: 'Pilih Kelurahan',
          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
          isReadOnly: true,
          isEnable: controller.dataKecamatan.value.id != null,
          validator: (value) => Validation.formField(
            value: value,
            titleField: 'Kelurahan',
          ),
          onTap: () => showBottomSheet<WilayahKelurahanModel>(
            title: 'Kelurahan',
            fetchData: controller.fetchKelurahan(),
            itemTap: (value) => controller.setKelurahan(value),
          ),
        ),
      );
    }

    Widget builderAddress() {
      return Obx(
        () => CustomTextField(
          controller: controller.addressC,
          focusNode: controller.addressF,
          title: 'Alamat',
          hintText: 'Misal Jalan Garuda Sakti',
          suffixIconState: controller.address.value.isNotEmpty,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.done,
          validator: (value) => Validation.formField(
            value: value,
            titleField: 'Alamat',
          ),
        ),
      );
    }

    Widget builderForm() {
      return Form(
        key: controller.formKey,
        child: Column(
          children: [
            builderName(),
            const Gap(24),
            builderProvince(),
            const Gap(24),
            builderKabupaten(),
            const Gap(24),
            builderKecamatan(),
            const Gap(24),
            builderKelurahan(),
            const Gap(24),
            builderAddress(),
          ],
        ),
      );
    }

    Widget builderConfirm() {
      return Obx(
        () => CustomFilledButton(
          width: double.infinity,
          isFilledTonal: false,
          state: controller.isLoading.value,
          onPressed: controller.confirm,
          child: Text(controller.btnTitle),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => controller.moveToMain(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: (controller.type == Type.update)
            ? [
                IconButton(
                  onPressed: () => controller.deleteEmployee(controller.id!),
                  icon: const Icon(Icons.delete_rounded),
                )
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            builderForm(),
            const Gap(32),
            builderConfirm(),
          ],
        ),
      ),
    );
  }
}
