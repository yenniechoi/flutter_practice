
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api/ApiProvider.dart';
import '../../items/ListItem.dart';


/// BookAllList() 상태 관리하는 컨트롤러

class ListController extends GetxController {
  static ListController get to => Get.find(); // controller 호출한 곳 찾기

  TextEditingController searchController = TextEditingController(); // TextFormField controller (입력창 데이터)
  RxList<Book> books = <Book>[].obs; // api 호출로 받아올 책 리스트 값
  var query = ''.obs; // 검색창에 입력한 검색어

  /// 시작할 때 초기값으로 책 리스트 검색
  @override
  void onInit() {
    super.onInit();
    getBookList('a'); // api 호출시 인자값이 꼭 필요해서 기본값(임의 지정) 넣어줌

    // query 값이 변경될 때마다 api 호출 --- 실시간 검색
    ever(query, (_) {
      getBookList(query.value); // api 재호출
    });
  }

  /// api 호출해서 리스트 받아오기
  void getBookList(String input) async {
    var listInfo = await BooksProvider.getBookList(input); // 리턴값
    if (listInfo.isNotEmpty) {
      books.value = listInfo;
      update(); // GetBuilder에 알림을 보내어 UI를 업데이트
    }
  }

  /// 검색창 입력값 변경 시 호출
  void updateSearchQuery(String text) {
    query.value = text;
  }

  /// 검색창 입력값 초기화 시 호출
  void clearSearchQuery() {
    searchController.clear(); // 검색창 비우기
    query.value = 'a'; // 검색어 없을 때 초기값 대입
  }

  /// 카드 탭하면 디테일 페이지로 이동
  void moveToDetail(int index) {
    Get.toNamed('/detail/${books[index].isbn}');
    // Get.to(BookInfo(isbn:books[index].isbn))
    /*
     arguments 나 파라메터는 무조건 '' 로 감싸져서 String 으로 들어가야 한다.
     그러기 힘들 경우 ${} 로 묶어서 처리하기
     arguments 에는 ${} 못씀.
    */
  }


}
