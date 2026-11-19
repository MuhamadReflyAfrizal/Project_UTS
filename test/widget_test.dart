
import 'package:flutter_test/flutter_test.dart';
import 'package:activity_counter/views/home_view.dart';
import 'package:activity_counter/main.dart';


void main() {
  testWidgets('App runs smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ActivityCounterApp());
    expect(find.byType(HomeView), findsOneWidget);
  });
}

