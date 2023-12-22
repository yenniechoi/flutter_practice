

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../items/ListItem.dart';
import '../bookDetail/Detail.dart';
import 'ListController.dart';

/*
Stateful은 화면의 일부를 변경하기 위해 화면 전체를 재렌더링하는 방식이라 너무 비효율적이어서
Statelsee로 바꾸고
GetX와 Controller 로 상태를 관리하는 방식으로 변경

단순 상태 관리 : 기존의 데이터와 변경되는 데이터가 같은지 확인 X
반응형 상태 관리 : 데이터가 변화가 있을 때만 재렌더링
 */

/// 첫 시작 화면, 네이버 도서 리스트 검색 결과 창

class BookAllList extends StatelessWidget {
  BookAllList({super.key});

  // 상태관리 할 컨트롤러 의존성 주입
  // Get.put()을 사용하여 클래스를 인스턴스화하여 모든 "child'에서 사용가능하게 합니다.
  final ListController controller = Get.put(ListController());


  // 전체 뷰 --------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          buildSearchBar(), // 검색창
          buildSearchResults(), // 검색 결과
        ],
      ),
    );
  }
// 전체 뷰 --------------------------------------------------------------------


/*
 *
 * (상단) 검색창 위젯
 *
*/

  Widget buildSearchBar(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      child: TextFormField( // TextField 를 포함하고 있는 FormField
        controller: controller.searchController,
        onChanged: (text) { controller.updateSearchQuery(text); }, // 검색창 입력값이 변할때마다 실시간으로 api 호출

        // 검색창 디자인
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, size: 30),
          suffixIcon: IconButton( // 입력창 뒤에 오는 X 아이콘
            onPressed: () => { controller.clearSearchQuery() }, // 검색창 초기화
            icon: const Icon(Icons.clear),
          ),
          hintText: '책 제목 / 저자',
          contentPadding: const EdgeInsets.symmetric( // 입력창 내용 대칭 정렬
            vertical: 8,
            horizontal: 16,
          ),
        ),
      ),
    );
  }

  /*
  *
  * (하단) 검색 결과 -- 도서 리스트
  *
  */

  Widget buildSearchResults() {
    return Expanded(
      child: GetBuilder<ListController>( // api 가 새로 호출될 경우 변경되는 부분
        builder: (controller) {
          if (controller.books.isNotEmpty) { // 검색 결과가 있을 경우 정보 나타내기
            return ListView.builder( // 리스트 형식
              itemCount: controller.books.length, // 배열에 담긴 값만큼 반복
              itemBuilder: (context, index) {
                return InkWell( // 탭 감지 (각 카드 영역)
                  onTap: () {controller.moveToDetail(index);}, // 리스트에서 카드 누르면 디테일 페이지로 이동
                  child: buildBookCard(controller.books[index]), // 검색 결과를 카드로 보여주는 부분
                );
              },
            );
          } else { // 검색 결과가 없을 경우
            return const Text('searching...');
          }
        },
      ),
    );
  }


  /*
  *
  * 검색 결과에 띄우는 각각의 카드
  *
  */

  Widget buildBookCard(Book book) {
    return Card( // 카드 형태
      elevation: 3,
      margin: const EdgeInsets.symmetric( // 대칭적 여백 지정
        horizontal: 15.0, // 수평 (왼오)
        vertical: 10.0, // 수직 (위아래)
      ),

      child: Padding(
        padding: const EdgeInsets.all(8.0), // 전체 여백 지정
        child:
        // 이미지와 텍스트를 가로로 나열 -- Row 에 Expand 2개를 쓰면 각 Expand 당 1/2 씩 너비 나눠 가짐
        Row(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.network(book.image), // 책 이미지
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // 포함된 자식 콘텐츠의 크기만큼 차지
                  crossAxisAlignment: CrossAxisAlignment.start, // 가로축 기준 상단 정렬
                  children: [
                    Text(
                      book.title,  // 책 제목
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(book.author), // 책 저자
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
