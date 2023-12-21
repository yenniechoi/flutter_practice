
// BookInfo() 상태 관리하는 컨트롤러

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api/ApiProvider.dart';
import '../../items/DetailItem.dart';

class DetailController extends GetxController {
  static DetailController get to => Get.find();

  Rx<Detail> detail = Detail().obs;
  final isbn = Get.parameters['isbn'];
  RxBool loading = true.obs; // 데이터가 로드되기 전에 ui 빌드되지 않기 위해 사용

  @override
  void onInit() { // 시작할 때 초기값으로 책 리스트 검색
    super.onInit();
    getBookInfo();
  }

  // api 호출해서 리스트 받아오기
  void getBookInfo() async {
    try {
      loading.value = true; // 데이터 로딩 시작 -- page 에서 로딩 인디케이터 뜰거임.

      var detailInfo = await BookDetailProvider.getBookInfo(isbn!);
      detail.value = detailInfo;
      /*
      * update() 메서드 호출은 GetBuilder 위젯이 해당 컨트롤러를 구독하고 있을 때에만 UI 업데이트를 트리거합니다.
      * 따라서 해당 페이지에서 GetBuilder 위젯을 사용하고 있는지 확인하세요.
      */
      update(); // GetBuilder에 알림을 보내어 UI를 업데이트

      loading.value = false; // 데이터 로딩 완료. 로딩인디케이터 사라지고 데이터 표시됨.

    } catch (e) { // 에러 처리
      debugPrint('Error while fetching book info: $e');
    } finally {
      // 무조건 로딩 상태를 false로 변경
      loading.value = false;
    }
  }
}