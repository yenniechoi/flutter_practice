

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api/ApiProvider.dart';
import '../../items/DetailItem.dart';

/// BookInfo() 상태 관리하는 컨트롤러

class DetailController extends GetxController {
  static DetailController get to => Get.find();

  final isbn = Get.parameters['isbn']; // route 인자값으로 전달됨

  Rx<Detail> detail = Detail().obs;
  RxBool loading = true.obs; // 데이터가 로드되기 전에 ui가 먼저 빌드되지 않기 위해 사용

  /// 페이지 호출시 api 호출
  @override
  void onInit() {
    super.onInit();
    getBookInfo();
  }

  /// api 호출해서 리스트 받아오기
  void getBookInfo() async {
    try {
      loading.value = true; // 데이터 로딩 시작 -- page 에서 로딩 인디케이터 뜰거임.
      detail.value = await BookDetailProvider.getBookInfo(isbn!); // api 호출

      update(); // GetBuilder에 알림을 보내어 UI를 업데이트
      loading.value = false; // 데이터 로딩 완료. 로딩인디케이터 사라지고 데이터 표시됨.

    } catch (e) { // 에러 처리
      debugPrint('Error while fetching book info: $e');
    } finally {
      loading.value = false; // 무조건 로딩 상태를 false로 변경
    }
  }

  /// 뒤로가기 버튼
  void getBack() {
    Get.back();
  }
}