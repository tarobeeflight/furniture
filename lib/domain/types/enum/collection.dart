enum COLLECTION {
  furniture('furniture'),
  designers('designers'),
  brands('brands');

  const COLLECTION(this.displayName);
  final String displayName;

  @override
  String toString() => displayName;
}