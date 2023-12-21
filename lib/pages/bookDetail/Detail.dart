

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/ApiProvider.dart';
import '../../items/DetailItem.dart';
import 'DetailController.dart';

class BookInfo extends StatelessWidget {
  BookInfo({super.key});

  // 상태관리 할 컨트롤러 의존성 주입
  final DetailController controller = Get.put(DetailController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상세보기'),
        leading: IconButton(
          onPressed: () { Get.back(); },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child:GetBuilder<DetailController>(
          builder: (controller) {
            if (controller.loading.value) {
              return const CircularProgressIndicator(); // 로딩 중이면 로딩 표시
            } else {
              return buildDetailInfo(
                  controller.detail.value); // 로딩이 완료되면 데이터 표시
            }
          }
        )
      ),
    );
  }

  Widget buildDetailInfo(Detail info) {
    return SingleChildScrollView( // Column 위젯이 화면을 넘어서 렌더링되는걸 방지.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(info.detailImage),
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


  Widget buildDetailText(String title, String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: '$title: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: content),
          ],
        ),
      ),
    );
  }
}

