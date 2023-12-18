// 가져올 데이터를 클래스로 만들어 관리

class Book {
  String? title; // 책 제목
  String? link; // 네이버 도서 정보 URL
  String? image; // 섬네일 이미지의 URL
  String? author; // 저자 이름
  int? discount; // 판매 가격. 절판 등의 이유로 가격이 없으면 값을 반환하지 않습니다.
  String? publisher; // 출판사
  String? description; // 네이버 도서의 책 소개
  String? pubdate; // 출간일

  Book({
    this.title,
    this.link,
    this.image,
    this.author,
    this.discount,
    this.publisher,
    this.description,
    this.pubdate,
  });

}