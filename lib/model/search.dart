class SearchModel {
  List<Data>? data;

  SearchModel({this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? nameEn;
  String? nameAr;
  int? pages;
  String? price;
  String? sellerAr;
  String? sellerEn;
  String? writerAr;
  String? writerEn;
  String? img;
  int? hullNum;
  int? sectionNum;
  String? lat;
  String? long;
  List<SemellerBooks>? semellerBooks;
  List<DarElnasher>? darElnasher;

  Data(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.pages,
      this.price,
      this.sellerAr,
      this.sellerEn,
      this.writerAr,
      this.writerEn,
      this.img,
      this.hullNum,
      this.sectionNum,
      this.lat,
      this.long,
      this.semellerBooks,
      this.darElnasher});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_En'];
    nameAr = json['name_Ar'];
    pages = json['pages'];
    price = json['price'];
    sellerAr = json['seller_ar'];
    sellerEn = json['seller_en'];
    writerAr = json['writer_ar'];
    writerEn = json['writer_en'];
    img = json['img'];
    hullNum = json['hull_num'];
    sectionNum = json['section_num'];
    lat = json['lat'];
    long = json['long'];
    if (json['semeller_books'] != null) {
      semellerBooks = <SemellerBooks>[];
      json['semeller_books'].forEach((v) {
        semellerBooks!.add(SemellerBooks.fromJson(v));
      });
    }
    if (json['dar_elnasher'] != null) {
      darElnasher = <DarElnasher>[];
      json['dar_elnasher'].forEach((v) {
        darElnasher!.add(DarElnasher.fromJson(v));
      });
    }
  }
}

class SemellerBooks {
  int? id;
  String? nameEn;
  String? nameAr;
  int? pages;
  String? price;
  String? sellerAr;
  String? sellerEn;
  String? writerAr;
  String? writerEn;
  String? img;
  int? hullNum;
  int? sectionNum;
  String? lat;
  String? long;
  List<SemellerBooksdata>? semellerBooks;
  List<DarElnasher>? darElnasher;

  SemellerBooks(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.pages,
      this.price,
      this.sellerAr,
      this.sellerEn,
      this.writerAr,
      this.writerEn,
      this.img,
      this.hullNum,
      this.sectionNum,
      this.lat,
      this.long,
      this.semellerBooks,
      this.darElnasher});

  SemellerBooks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_En'];
    nameAr = json['name_Ar'];
    pages = json['pages'];
    price = json['price'];
    sellerAr = json['seller_ar'];
    sellerEn = json['seller_en'];
    writerAr = json['writer_ar'];
    writerEn = json['writer_en'];
    img = json['img'];
    hullNum = json['hull_num'];
    sectionNum = json['section_num'];
    lat = json['lat'];
    long = json['long'];
    if (json['semeller_books'] != null) {
      semellerBooks = <SemellerBooksdata>[];
      json['semeller_books'].forEach((v) {
        semellerBooks!.add(SemellerBooksdata.fromJson(v));
      });
    }
    if (json['dar_elnasher'] != null) {
      darElnasher = <DarElnasher>[];
      json['dar_elnasher'].forEach((v) {
        darElnasher!.add(DarElnasher.fromJson(v));
      });
    }
  }
}

class SemellerBooksdata {
  int? id;
  String? nameEn;
  String? nameAr;
  int? pages;
  String? price;
  String? sellerAr;
  String? sellerEn;
  String? writerAr;
  String? writerEn;
  String? img;
  int? hullNum;
  int? sectionNum;
  String? lat;
  String? long;

  SemellerBooksdata({
    this.id,
    this.nameEn,
    this.nameAr,
    this.pages,
    this.price,
    this.sellerAr,
    this.sellerEn,
    this.writerAr,
    this.writerEn,
    this.img,
    this.hullNum,
    this.sectionNum,
    this.lat,
    this.long,
  });

  SemellerBooksdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_En'];
    nameAr = json['name_Ar'];
    pages = json['pages'];
    price = json['price'];
    sellerAr = json['seller_ar'];
    sellerEn = json['seller_en'];
    writerAr = json['writer_ar'];
    writerEn = json['writer_en'];
    img = json['img'];
    hullNum = json['hull_num'];
    sectionNum = json['section_num'];
    lat = json['lat'];
    long = json['long'];
  }
}

class DarElnasher {
  int? id;
  String? nameAr;
  String? nameEn;
  String? lat;
  String? long;
  String? statusEn;
  String? statusAr;
  String? addressEn;
  String? addressAr;
  String? area;

  DarElnasher(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.lat,
      this.long,
      this.statusEn,
      this.statusAr,
      this.addressEn,
      this.addressAr,
      this.area});

  DarElnasher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    lat = json['lat'];
    long = json['long'];
    statusEn = json['status_en'];
    statusAr = json['status_ar'];
    addressEn = json['address_en'];
    addressAr = json['address_ar'];
    area = json['area'];
  }
}
