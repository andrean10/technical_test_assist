import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/constants_lottie.dart';

abstract class StateProcessWidget {
  static Widget onLoading() {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Container(
          width: double.infinity,
          height: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Get.theme.textTheme.bodyMedium?.color,
          ),
        ),
      ).animate(onPlay: (controller) => controller.repeat()).shimmer(
            duration: 1800.ms,
            color: Get.theme.cardColor,
          ),
      itemCount: 10,
    );
  }

  static Widget onEmpty(String title) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            ConstantsLottie.empty,
            width: Get.size.width / 2,
          ),
          Text(
            'Data $title Tidak Ditemukan',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static Widget onError([String? errMessage]) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: Lottie.asset(
                ConstantsLottie.warning,
                fit: BoxFit.cover,
                width: Get.size.width / 2,
              ),
            ),
            Text(
              errMessage ?? 'Kesalahan Saat Mengambil Data',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Get.theme.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
