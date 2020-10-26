import 'package:flutter_gallery/hooks/items_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

PagingController<int, T> usePager<T>(ItemsProvider<T> provider) {
  final pager = useMemoized(() => PagingController<int, T>(firstPageKey: 0));

  registerPageRequester() {
    pager.addPageRequestListener((pageKey) async {
      try {
        await provider.requestMore();
      } catch (error) {
        pager.error = error;
      }
    });
  }

  useEffect(registerPageRequester, [pager]);

  final pagerIndex = useState(0);
  final items = provider.items;
  subscribeItems() {
    final itemsToAppend = items.sublist(pagerIndex.value);
    final hasNoMoreReview = items.length == provider.total;
    if (hasNoMoreReview) {
      pager.appendLastPage(itemsToAppend);
    } else {
      final nextKey = items.length;
      pager.appendPage(itemsToAppend, nextKey);
    }
    pagerIndex.value = items.length;
  }

  useEffect(subscribeItems, [pager, items.length]);

  return pager;
}
