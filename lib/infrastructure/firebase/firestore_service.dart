import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/infrastructure/firebase/data_path.dart';

export 'package:furniture/infrastructure/firebase/data_path.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  /// 家具データをFurnitureクラスへ変換
  Future<Furniture> convertDataToFurniture(Map<String, dynamic> docData) async {

    final preFurniture = PreFurniture.fromJson(docData);

    // brandId → Brandクラス
    final brandDoc = await db.collection(Collection.brands).doc(preFurniture.brandId).get();
    final brand = Brand.fromJson(brandDoc.data()!);

    // designerId → Designerクラス
    final designerDoc = await db.collection(Collection.designers).doc(preFurniture.designerId).get();
    final designer = Designer.designerFromMap(designerDoc.data()!);

    // PreFurnitureクラス → Furnitureクラス
    final furniture = Furniture(
      enName: preFurniture.enName,
      jaName: preFurniture.jaName,
      designedYear: preFurniture.designedYear,
      type: preFurniture.type,
      designer: designer,
      brand: brand,
      imageUrl: preFurniture.imageUrl,
      memo: preFurniture.memo,
    );

    return furniture;
  }

  /// 家具一覧を取得
  Future<List<Furniture>> readFurnitureList(DbQuery? query) async {
    // DBから家具一覧のデータを取得
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if(query == null){
      // TODO: エラーの方がいい？
      snapshot = await db.collection(Collection.furniture).limit(1).get();
    } else if(query.property == FurnitureField.all) {
      if(query.limit == null){
        snapshot = await db.collection(Collection.furniture).get();
      }
      else{
        snapshot = await db.collection(Collection.furniture).limit(query.limit!).get();
      }
    }
    else {
      if(query.limit == null) {
        snapshot = await db.collection(Collection.furniture)
            .where(query.property, whereIn: query.targets).get();
      }
      else {
        snapshot = await db.collection(Collection.furniture)
            .where(query.property, whereIn: query.targets).limit(query.limit!).get();
      }
    }

    // DBデータ → List<Furniture>
    List<Furniture> furnitureList = [];
    for(QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      final f = await convertDataToFurniture(doc.data());
      furnitureList.add(f);
    }

    return furnitureList;
  }

  /// 特定のIDの家具を取得
  Future<Furniture> fetchFurniture(String id) async {
    // DBから家具データを取得
    final data = await db.collection(Collection.furniture).doc(id).get();
    final f = await convertDataToFurniture(data.data()!);

    return f;
  }

  /// デザイナー一覧を取得
  Future<List<Designer>> readDesignerList() async {
    final snapshot = await db.collection(Collection.designers).get();

    // DBデータ →　List<Designer>
    List<Designer> list = snapshot.docs.map(
            (doc) => Designer.designerFromMap(doc.data())).toList();

    return list;
  }

  /// ブランド一覧を取得
  Future<List<Brand>> readBrandList() async {
    final snapshot = await db.collection(Collection.brands).get();

    // DBデータ →　List<Brand>
    List<Brand> list = snapshot.docs.map(
            (doc) => Brand.fromJson(doc.data())).toList();

    return list;
  }
  
  /// デザイナーIDを検索
  Future<String> searchDesignerId(String jaName) async {
    final snapshot = await db.collection(Collection.designers)
        .where(DesignerField.jaName, isEqualTo: jaName).limit(1).get();
    final id = snapshot.docs.first.id;

    return id;
  }
  /// ブランドIDを検索
  Future<String> searchBrandId(String jaName) async {
    final snapshot = await db.collection(Collection.brands)
        .where(DesignerField.jaName, isEqualTo: jaName).limit(1).get();
    final id = snapshot.docs.first.id;

    return id;
  }
  // /// 家具の数を取得 TODO: 引数で抽象化する
  // Future<int> countFurniture() async {
  //   final countData = await db.collection(Collection.furniture)
  //       .where(FurnitureField.designerId, isEqualTo: 'D0001').count().get();
  //   final count = countData.count;
  //   return count;
  // }

  // --------------------------------------------テスト-------------------------------

  static final designerList = [
    Designer(
      enName: 'Murata Shotaro',
      jaName: '村田勝太郎',
      country: 'ドイツ',
      culture: 'ヨーロッパ',
      birthday: DateTime(1998, 5, 24),
      faceUrl: 'faceUrl',
      memo: 'memo'
    ),
    Designer(
      enName: 'Inazumi Rico',
      jaName: '稲角理子',
      country: '韓国',
      culture: 'アジア',
      birthday: DateTime(1998, 12, 4),
      faceUrl: 'faceUrl',
      memo: 'memo'
    ),
    Designer(
      enName: 'Onoue Yudai',
      jaName: '尾上雄大',
      country: 'イタリア',
      culture: 'ヨーロッパ',
      birthday: DateTime(1998, 8, 13),
      faceUrl: 'faceUrl',
      memo: 'memo'
    ),
  ];
  static final brandList = [
    const Brand(
      enName: 'TOYOTA',
      jaName: 'トヨタ',
      country: '日本',
      foundedYear: 1876,
      memo: 'memo'
    ),
    const Brand(
        enName: 'Audi',
        jaName: 'アウディ',
        country: 'ドイツ',
        foundedYear: 1776,
        memo: 'memo'
    ),
    const Brand(
        enName: 'Caderac',
        jaName: 'キャデラック',
        country: 'アメリカ',
        foundedYear: 1899,
        memo: 'memo'
    ),
  ];
  static final furnitureList = [
    Furniture(
      enName: 'Prius',
      jaName: 'プリウス',
      designedYear: 2002,
      type: 'ハッチバック',
      designer: designerList.elementAt(0),
      brand: brandList.elementAt(0),
      imageUrl: 'imageUrl',
      memo: 'memo'
    ),
    Furniture(
        enName: 'Crown',
        jaName: 'クラウン',
        designedYear: 1998,
        type: 'セダン',
        designer: designerList.elementAt(0),
        brand: brandList.elementAt(0),
        imageUrl: 'imageUrl',
        memo: 'memo'
    ),
    Furniture(
        enName: 'Sentry',
        jaName: 'センチュリー',
        designedYear: 1990,
        type: 'セダン',
        designer: designerList.elementAt(0),
        brand: brandList.elementAt(0),
        imageUrl: 'imageUrl',
        memo: 'memo'
    ),
    Furniture(
        enName: 'A6',
        jaName: 'A6',
        designedYear: 2012,
        type: 'ステーションワゴン',
        designer: designerList.elementAt(1),
        brand: brandList.elementAt(1),
        imageUrl: 'imageUrl',
        memo: 'memo'
    ),
    Furniture(
        enName: 'TT',
        jaName: 'TT',
        designedYear: 1996,
        type: 'カブリオレ',
        designer: designerList.elementAt(1),
        brand: brandList.elementAt(1),
        imageUrl: 'imageUrl',
        memo: 'memo'
    ),
    Furniture(
        enName: 'escarade',
        jaName: 'エスカレード',
        designedYear: 2020,
        type: 'SUV',
        designer: designerList.elementAt(2),
        brand: brandList.elementAt(2),
        imageUrl: 'imageUrl',
        memo: 'memo'
    ),
    Furniture(
        enName: 'Eldrad',
        jaName: 'エルドラド',
        designedYear: 2002,
        type: 'SUV',
        designer: designerList.elementAt(2),
        brand: brandList.elementAt(2),
        imageUrl: 'imageUrl',
        memo: 'memo'
    ),
  ];
  // テスト用の通信をしない家具リスト
  List<Furniture> testGetFurnitureList(){
    return furnitureList;
  }
}
























