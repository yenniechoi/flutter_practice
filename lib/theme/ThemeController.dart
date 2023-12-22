

import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// 테마 변경 관리하는 Controller

class ThemeController extends GetxController {
  static ThemeController get to => Get.find(); // main.dart 에서 호출됨

  RxBool isDarkMode = false.obs; // 다크모드인지 판단해서 아이콘 바꿀 때 필요

  // @override
  // void onInit() {
  //   super.onInit();
  //
  //   // Get.context가 변경될 때마다 호출되는 콜백 함수
  //   // Get.context가 유효해질 때까지 기다림
  //   ever(Get.context as RxInterface<Object?>, (_) {
  //     if (Get.context != null) {
  //       updateThemeMode(); // main이 build 되면 자동으로 현재 밝기에 맞게 다크모드 변수 설정
  //     }
  //   });
  //
  // }
  //
  // /// 시스템 테마에 따라 isDarkMode 업데이트
  // void updateThemeMode() {
  //   if (Get.context != null) {
  //     Brightness currentBrightness = Theme.of(Get.context!).brightness;
  //     isDarkMode.value = currentBrightness == Brightness.dark; // 현재 설정된 테마에 따라 변수값 할당
  //   }
  // }

  /// 다크모드 전환 아이콘 누르면 호출
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}