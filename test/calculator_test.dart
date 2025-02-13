import 'package:calculator/main.dart';
import 'package:calculator/view/home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator/view/features/calculator.dart';

void main() {
  testWidgets('Calculate widget test', (widgetTester) async {
    await widgetTester.pumpWidget(const MyApp());
    expect(find, findsOneWidget);
  });
}
