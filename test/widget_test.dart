import 'package:flutter_test/flutter_test.dart';
import 'package:habitura/main.dart' as app;

void main() {
  testWidgets('Habitura app boots', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('Good Morning,'), findsOneWidget);
  });
}
