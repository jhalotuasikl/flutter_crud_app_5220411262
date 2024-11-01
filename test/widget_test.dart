import 'package:flutter_test/flutter_test.dart';
import 'package:crud_app/main.dart'; // Ganti dengan path yang sesuai
import 'package:crud_app/views/home_view.dart'; // Pastikan path ini benar

void main() {
  testWidgets('MyApp displays HomeView', (WidgetTester tester) async {
    // Build the MyApp widget
    await tester.pumpWidget(MyApp());

    // Verify if HomeView is displayed
    expect(find.byType(HomeView), findsOneWidget);
  });
}
