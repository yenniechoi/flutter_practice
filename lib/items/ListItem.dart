// 가져올 데이터를 클래스로 만들어 관리
// https://quicktype.io/


/// 리스트 조회 후 결과 담는 아이템

class Book {
  String title; // 책 제목
  String link; // 네이버 도서 정보 URL
  String image; // 섬네일 이미지의 URL
  String author; // 저자 이름
  String discount; // 판매 가격. 절판 등의 이유로 가격이 없으면 값을 반환하지 않습니다.
  String publisher; // 출판사
  String pubdate; // 출간일
  String isbn; // ISBN (책 고유번호) --> 디테일 api 조회시 사용
  String description; // 네이버 도서의 책 소개

  // '' (빈 문자열)을 기본값으로 설정하여 값을 null로 받을 경우 빈 문자열로 초기화
  Book({
    this.title = '',
    this.link = '',
    this.image = '',
    this.author = '',
    this.discount = '',
    this.publisher = '',
    this.pubdate = '',
    this.isbn = '',
    this.description = '',
  });

  // json 값 넣을때 쓰임
  // 들어오는 값이 null 인 경우를 대비
  factory Book.fromJson(Map<String, dynamic> json) => Book(
    title: json["title"] ?? '',
    link: json["link"] ?? '',
    image: json["image"] ?? '',
    author: json["author"] ?? '',
    discount: json["discount"] ?? '',
    publisher: json["publisher"] ?? '',
    pubdate: json["pubdate"] ?? '',
    isbn: json["isbn"] ?? '',
    description: json["description"] ?? '',
  );

}