import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('SaaS landing page loads', (tester) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PizzaNovaApp());
    await tester.pumpAndSettle();

    expect(find.text('PizzaNova'), findsWidgets);
    expect(find.text('Ver planos'), findsOneWidget);
  });
}
