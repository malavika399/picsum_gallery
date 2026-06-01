import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:picsum_gallery/main.dart';
import 'package:picsum_gallery/providers/gallery_provider.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => GalleryProvider(),
        child: const PicsumGalleryApp(),
      ),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
