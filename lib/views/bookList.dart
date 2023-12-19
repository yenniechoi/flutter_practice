

/*
* [ 버전 2 ]
* Model, Provider, Views 로 나눠 구현한 버전.
*
* */

import 'package:flutter/material.dart';
import 'package:helloflutter/models/book.dart';

import '../providers/books_provider.dart';

class AllList extends StatefulWidget {
  const AllList({super.key});

  @override
  State<AllList> createState() => _AllListState();
}

class _AllListState extends State<AllList> {
  List<Book> _books = <Book>[]; // api 결과를 담을 빈 배열 생성
  bool loading = false; // 데이터 로드하는 동안 띄울 로딩 이미지 T/F

  @override
  void initState() {
    super.initState();
    BooksProvider.getBookInfo().then((value) {
      setState(() {
        _books = value;
        loading = true;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loading ? 'Naver Book Searching' : 'Loading...'),
      ),
      body: ListView.builder(
          itemCount: _books.length,
          itemBuilder: (context, index){
            return Card(
              margin: const EdgeInsets.symmetric( // 대칭적 여백 지정
                horizontal: 15.0, // 수평 (왼오)
                vertical: 10.0, // 수직 (위아래)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0), // 전체 여백 지정
                child: Row( // 이미지와 텍스트를 가로로 나열
                  children: [
                    Expanded( // 부모의 남은 부분을 전부 채움. 기본 flex값을 1 가지고 있음.
                        child: SizedBox(
                          width: 100, // 이미지 너비 조절
                          child: Image.network(
                            _books[index].image,
                            //fit: BoxFit.cover, // 이미지를 화면에 맞게 조정
                          ),
                        )
                    ),
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text( _books[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(_books[index].author),
                          ],
                        )
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
