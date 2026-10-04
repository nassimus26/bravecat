import 'package:flutter_test/flutter_test.dart';
import 'package:bravecat/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const WhiskersGameApp());
    expect(find.byType(WhiskersGameApp), findsOneWidget);
  });
}
