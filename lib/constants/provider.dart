import 'package:shopping_for_friends/providers/content_provider.dart';

class ProviderConstant {
  static ContentProvider contentProvider;

  static void newContentProvider() {
    contentProvider = ContentProvider();
  }
}
