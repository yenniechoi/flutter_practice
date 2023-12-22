

import 'package:flutter/material.dart';

import '../items/DetailItem.dart';
import '../api/ApiProvider.dart';

/// GetX 사용하지 않은 버전
// 리스트에서 책을 누르면 나오는 책 상세페이지
class BookDetail extends StatelessWidget {
  const BookDetail({Key? key, required this.isbn}) : super(key: key);
  // 리스트에서 인자값으로 받아온 책 고유번호 --> 디테일 api 호출할 때 쓰임
  final String isbn;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상세보기'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView( // Column 위젯이 화면을 넘어서 렌더링되는걸 방지.
        child: FutureBuilder<Detail>( // 비동기 통신. 서버에서 데이터를 모두 받아오기 전에 화면을 그려줄 수 있음.
          /// 디테일 api 호출
          future: BookDetailProvider.getBookInfo(isbn),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) { // Future 실행 중
              return const CircularProgressIndicator(); // 로딩 표시
            } else if (snapshot.hasError) { // 에러 발생
              return Text('에러: ${snapshot.error}');
            } else
            if (!snapshot.hasData) { // 에러는 없지만 데이터가 아직 없는 경우
              return const Text('데이터 오는 중...'); // 플레이스 홀더 표시
            } else { // Future가 완료되고 데이터가 있는 경우 데이터를 표시합니다.
              Detail detail = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                // -------------------------- 통신받은 데이터 뿌려주기 -----------------------------------
                children: [
                  Image.network(detail.detailImage),
                  Text('제목: ${detail.detailTitle}'),
                  Text('작가: ${detail.detailAuthor}'),
                  Text('출판사: ${detail.detailPublisher}'),
                  Text('출판일: ${detail.detailPubdate}'),
                  Text('가격: ${detail.detailDiscount}'),
                  Text('설명: ${detail.detailDescription}'),
                // 필요에 따라 더 많은 상세 정보를 추가합니다.
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
