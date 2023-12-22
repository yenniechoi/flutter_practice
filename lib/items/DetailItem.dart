
/// 디테일 조회 후 결과 담는 생성자

class Detail {
  String detailTitle; // 책 제목
  String detailLink; // 네이버 도서 정보 URL
  String detailImage;  // 섬네일 이미지의 URL
  String detailAuthor; // 저자 이름
  String detailDiscount; // 판매 가격. 절판 등의 이유로 가격이 없으면 값을 반환하지 않습니다.
  String detailPublisher; // 출판사
  String detailPubdate; // 출간일
  String detailIsbn; // ISBN (책 고유번호) --> 디테일 api 조회시 사용
  String detailDescription; // 네이버 도서의 책 소개

  // '' (빈 문자열)을 기본값으로 설정하여 값을 null로 받을 경우 빈 문자열로 초기화
  Detail({
    this.detailTitle = '',
    this.detailLink = '',
    this.detailImage = '',
    this.detailAuthor = '',
    this.detailDiscount = '',
    this.detailPublisher = '',
    this.detailPubdate = '',
    this.detailIsbn = '',
    this.detailDescription = '',
  });

  // json 파싱
  // 들어오는 값이 null 인 경우를 대비
  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    detailTitle: json["title"] ?? '',
    detailLink: json["link"] ?? '',
    detailImage: json["image"] ?? '',
    detailAuthor: json["author"] ?? '',
    detailDiscount: json["discount"] ?? '',
    detailPublisher: json["publisher"] ?? '',
    detailPubdate: json["pubdate"] ?? '',
    detailIsbn: json["isbn"] ?? '',
    detailDescription: json["description"] ?? '',
  );
}