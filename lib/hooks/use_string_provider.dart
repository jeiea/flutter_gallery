import 'package:dio/dio.dart';
import 'package:flutter_gallery/hooks/items_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ItemsProvider<String> useStringProvider() {
  final items = useState(<String>[]);
  final total = useState<int>(null);
  final isRequesting = useState<bool>(false);
  final isMounted = useIsMounted();

  fetchSchedules() async {
    if (!isMounted()) {
      return;
    }
    if (isRequesting.value) {
      return;
    }
    try {
      isRequesting.value = true;
      final users = await Dio().get('https://reqres.in/api/users?page=2');
      final emails = users.data['data'].map((x) => x['email']).cast<String>();
      if (!isMounted()) {
        return;
      }
      items.value.addAll(emails);
    } catch (error) {
      print(error);
      rethrow;
    } finally {
      isRequesting.value = false;
    }
  }

  final requestMore = useMemoized(() => () => Future(fetchSchedules), [items]);

  return useMemoized(
      () => ItemsProvider(
          items: items.value, total: total.value, requestMore: requestMore),
      [items.value.length, total.value, requestMore]);
}
