

/*
* [ 버전 2 ]
* Model, Provider, Views 로 나눠 구현한 버전.
*
* */

import 'package:flutter/material.dart';
import 'package:helloflutter/models/book.dart';

import '../providers/books_provider.dart';
import 'bookDetail.dart';

class AllList extends StatefulWidget {
  const AllList({super.key});

  @override
  State<AllList> createState() => _AllListState();
}

class _AllListState extends State<AllList> {
  List<Book> _books = <Book>[]; // api 결과를 담을 빈 배열 생성
  bool loading = false; // 데이터 로드하는 동안 띄울 로딩 이미지 T/F
  TextEditingController searchController = TextEditingController(); // 검색창 입력내용 controller. 입력값 가져올 때 사용

  @override
  void initState() {
    super.initState();
    BooksProvider.getBookList('a').then((value) {
      setState(() {
        _books = value;
        loading = true;
      });
    });
  }

  // 검색어로 리스트 불러오기
  fetchList(query) {
    BooksProvider.getBookList(query).then((value) {
          setState(() {
            _books = value;
            loading = true;
          });
        });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }


  // 전체 뷰 --------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Naver Book',
          style: TextStyle(
            color: Colors.lime,
            fontSize: 28,
          ),
        ),
      ),
      body: Column(
        children: [
          buildSearchBar(), // 검색창
          buildSearchResults() // 검색 결과
        ],
      ),
    );
  }

  // 전체 뷰 ---------------------------------------------------------------------------

  /*
  *
  * (상단) 검색창 위젯
  *
  */

  Widget buildSearchBar(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: TextFormField( // TextField 를 포함하고 있는 FormField
        controller: searchController,
        onFieldSubmitted: fetchList, // 검색어 입력하고 엔터 치면 메서드 실행
        decoration: InputDecoration(
          prefixIcon: IconButton( // 입력창 앞에 오는 검색 아이콘
            onPressed: () => fetchList,
            icon: const Icon(Icons.search, color: Colors.lime, size: 30),
          ),
          suffixIcon: IconButton( // 입력창 뒤에 오는 X 아이콘
            onPressed: () => setState(() {
              searchController.clear(); // 누르면 입력창에 입력한 값 사라짐
            }),
            icon: const Icon(Icons.clear, color: Colors.black12),
          ),
          filled: true, // 텍스트 입력필드 배경 바꾸기 위해 true
          fillColor: Colors.white,
          hintText: '책 제목 / 저자',
          hintStyle: const TextStyle(color: Colors.black12),
          contentPadding: const EdgeInsets.symmetric( // 입력창 내용 대칭 정렬
            vertical: 8,
            horizontal: 16,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.lime),
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
      child: _books.isNotEmpty ? ListView.builder( // 리스트 형식
        itemCount: _books.length, // 배열에 담긴 값만큼 반복
        itemBuilder: (context, index) {
          return InkWell( // 탭 감지
            onTap: () { // 리스트에서 책 누르면 디테일 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookDetail(
                  isbn: _books[index].isbn,
                ),
                ),
              );
            },
            child: buildBookCard(_books[index]),
          );
        },
      )
          : const Text('searching...'),
    );
  }


  /*
  *
  * 검색 결과에 띄우는 각각의 카드
  *
  */

  Widget buildBookCard(Book book) {
    return Card(// 카드 형태
      color: Colors.white, // ???????? 왜 안들어먹는지 이해 불가
      elevation: 2,
      shadowColor: Colors.grey,
      margin: const EdgeInsets.symmetric(// 대칭적 여백 지정
        horizontal: 15.0, // 수평 (왼오)
        vertical: 10.0, // 수직 (위아래)
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0), // 전체 여백 지정
          // 이미지와 텍스트를 가로로 나열 -- Row 에 Expand 2개를 쓰면 각 Expand 당 1/2 씩 너비 나눠 가짐
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,  // 이미지 높이 설정
                child: Image.network(
                  book.image,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                // leading 속성은 일반적으로 작은 아이콘이나 이미지를 표시하기 위해 사용됨. (크기 조절 안됨)
                title: Text(
                  book.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(book.author),
              )
              //IconButton(onPressed: onPressed, icon: const Icon(Icons.add))
            ],
          )

      ),
    );
  }

}
