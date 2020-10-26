class ItemsProvider<T> {
  ItemsProvider({this.items, this.total, this.requestMore});

  List<T> items;
  int total;
  Future Function() requestMore;
}
