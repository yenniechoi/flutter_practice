
// BookAllList() 상태 관리하는 컨트롤러

import 'package:get/get.dart';

import '../../api/ApiProvider.dart';
import '../../items/ListItem.dart';

class ListController extends GetxController {
  static ListController get to => Get.find();

  RxList<Book> books = <Book>[].obs; // api 호출로 받아올 책 리스트 값
  var query = ''.obs; // 검색창에 입력한 검색어

  @override
  void onInit() { // 시작할 때 초기값으로 책 리스트 검색
    super.onInit();
    // 시작할 때 'a'로 초기화
    getBookList('a');

    // query 값이 변경될 때마다 호출
    ever(query, (_) {
      if (query.value.isEmpty) {
        query.value = 'a'; // query가 비어있을 때 'a'로 설정
      }
      getBookList(query.value);
    });
  }

  // api 호출해서 리스트 받아오기
  void getBookList(String input) async {
    var listInfo = await BooksProvider.getBookList(input);
    if (listInfo.isNotEmpty) {
      books.value = listInfo;
      update(); // GetBuilder에 알림을 보내어 UI를 업데이트합니다.
    }
  }


}
