import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/infrastructure/firebase/data_path.dart';

export 'package:furniture/infrastructure/firebase/data_path.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  /// 家具データをFurnitureクラスへ変換
  Future<Furniture> convertDataToFurniture(
        Map<String, dynamic> docData,
        Map<String, Designer> designers,
        Map<String, Brand> brands
      ) async {

    /// DBデータ → PreFurnitureクラス
    final preFurniture = PreFurniture.fromJson(docData);

    /// brandId, designerId → Designerクラス, Brandクラス
    final brand = brands[preFurniture.brandId]!;  // nullチェック
    final designer = designers[preFurniture.designerId]!;  // nullチェック
    final type = FurnitureType.convertFromString(preFurniture.type);

    /// PreFurnitureクラス → Furnitureクラス
    final furniture = Furniture(
      enName: preFurniture.enName,
      jaName: preFurniture.jaName,
      designedYear: preFurniture.designedYear,
      type: type,
      designer: designer,
      brand: brand,
      imageUrl: preFurniture.imageUrl,
      memo: preFurniture.memo,
    );

    return furniture;
  }

  /// 家具一覧を取得
  Future<List<Furniture>> fetchFurniture(FurnitureQuery? query) async {
    /// デザイナー、ブランドを取得
    final designers  = await readDesignerMap();
    final brands = await readBrandMap();

    /// DBから家具一覧のデータを取得
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if(query == null){
      snapshot = await db.collection(Collection.furniture).get();
    }
    else {
      snapshot = await db.collection(Collection.furniture).where(query.property, whereIn: query.targets).get();
    }

    /// DBデータ → List<Furniture>
    List<Furniture> furnitureList = [];
    for(QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      final f = await convertDataToFurniture(doc.data(), designers, brands);
      furnitureList.add(f);
    }

    return furnitureList;
  }
  Future<Map<String, Furniture>> fetchFurnitureMap(FurnitureQuery? query) async {
    /// デザイナー、ブランドを取得
    final designers  = await readDesignerMap();
    final brands = await readBrandMap();

    /// DBから家具一覧のデータを取得
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if(query == null){
      snapshot = await db.collection(Collection.furniture).get();
    }
    else {
      snapshot = await db.collection(Collection.furniture).where(query.property, whereIn: query.targets).get();
    }

    /// DBデータ → Map<String, Furniture>
    Map<String, Furniture> furnitureMap = {};
    for(QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      final f = await convertDataToFurniture(doc.data(), designers, brands);
      final map = {doc.id: f};
      furnitureMap.addAll(map);
    }

    return furnitureMap;
  }


  /// デザイナー一覧を取得
  Future<List<Designer>> fetchDesignerCollection() async {
    final snapshot = await db.collection(Collection.designers).get();

    /// DBデータ →　List<Designer>
    final List<Designer> list = snapshot.docs.map(
            (doc) => Designer.designerFromMap(doc.data())).toList();

    return list;
  }
  /// デザイナー一覧マップを取得
  Future<Map<String, Designer>> readDesignerMap() async {
    final snapshot = await db.collection(Collection.designers).get();

    Map<String, Designer> designers = {};
    for(var doc in snapshot.docs){
      final id = doc.id;
      final designer = Designer.designerFromMap(doc.data());
      final map = <String, Designer>{id: designer};
      designers.addAll(map);
    }

    return designers;
  }

  /// ブランド一覧を取得
  Future<List<Brand>> fetchBrandCollection() async {
    final snapshot = await db.collection(Collection.brands).get();

    /// DBデータ →　List<Brand>
    final List<Brand> list = snapshot.docs.map(
            (doc) => Brand.fromJson(doc.data())).toList();

    return list;
  }
  /// ブランド一覧マップを取得
  Future<Map<String, Brand>> readBrandMap() async {
    final snapshot = await db.collection(Collection.brands).get();

    Map<String, Brand> brands = {};
    for(var doc in snapshot.docs){
      final id = doc.id;
      final brand = Brand.fromJson(doc.data());
      final map = <String, Brand>{id: brand};
      brands.addAll(map);
    }

    return brands;
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

  /// 家具のメモ情報を更新
  Future<void> updateFurnitureMemo(String id, String memo) async {
    await db.collection(Collection.furniture).doc(id).update(
        {
          FurnitureField.memo: memo,
        },
    );
  }
}
























