enum FurnitureType {
  chair('チェア'),
  stool('スツール'),
  table('テーブル'),
  sofa('ソファ'),
  bench('ベンチ'),
  light('照明'),
  mirror('ミラー'),
  bed('ベッド'),
  shelf('シェルフ'),
  rug('ラグ'),
  desk('デスク'),
  other('その他');

  const FurnitureType(this.displayName);
  final String displayName;

  @override
  String toString() => displayName;

  static FurnitureType convertFromString(String strType){
    const list = FurnitureType.values;
    for(var type in list){
      if(strType == type.displayName){
        return type;
      }
    }

    return FurnitureType.other;
  }
}