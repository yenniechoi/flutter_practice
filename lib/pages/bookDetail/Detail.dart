
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/ApiProvider.dart';
import '../../items/DetailItem.dart';
import 'DetailController.dart';


/// 리스트에서 책 카드를 누르면 넘어오는 디테일 창

class BookInfo extends StatelessWidget {
  BookInfo({super.key});

  // 상태관리 할 컨트롤러 의존성 주입
  final DetailController controller = Get.put(DetailController());


  // 전체 뷰 --------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true, // 스크롤 시 색상 변경 안되게.
        leading: IconButton( // 뒤로가기 버튼
          onPressed: () {controller.getBack();},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
          child: GetBuilder<DetailController>( // 컨트롤러에 인자값이 전달되면 빌드될 구역
              builder: (controller) {
                if (controller.loading.value) {
                  return const CircularProgressIndicator(); // 로딩 중이면 로딩 표시
                } else {
                  /// 디테일 데이터 뿌려주는 영역
                  return DetailInfoWidget(controller.detail.value); // 로딩이 완료되면 데이터 표시
                }
              }
          )
      ),
    );
  }
// 전체 뷰 --------------------------------------------------------------------

}


  /*
  *
  * 디테일 데이터 뿌려주는 영역
  *
  */

class DetailInfoWidget extends StatelessWidget {
  final Detail info;

  const DetailInfoWidget(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Column 위젯이 화면을 넘어서 렌더링되는걸 방지.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 위쪽 정렬
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0), // 전체 여백 지정
            child: Image.network(info.detailImage), // 이미지
          ),
          buildDetailText('제목', info.detailTitle),
          buildDetailText('작가', info.detailAuthor),
          buildDetailText('출판사', info.detailPublisher),
          buildDetailText('출판일', info.detailPubdate),
          buildDetailText('가격', info.detailDiscount),
          buildDetailText('설명', info.detailDescription),
        ],
      ),
    );
  }

  // 텍스트 스타일 지정하는 위젯
  Widget buildDetailText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

  // // 텍스트 스타일 지정하는 위젯
  // Widget buildDetailText(String title, String content) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0), // 전체 여백
  //     child: RichText( // 문자열 각각의 스타일을 다르게 지정할 수 있음
  //       text: TextSpan( // 문자열 분리
  //         style: const TextStyle(color: Colors.black),
  //         children: [
  //           TextSpan(
  //             text: '$title: ',
  //             style: const TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           TextSpan(text: content),
  //         ],
  //       ),
  //     ),
  //   );
  // }


