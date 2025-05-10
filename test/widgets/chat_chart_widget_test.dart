import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/widgets/chat_chart_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

// Mock classes for WebView
class MockWebViewPlatform extends Mock implements WebViewPlatform {}

class MockWebViewPlatformController extends Mock
    implements WebViewPlatformController {
  String? lastLoadedHtmlString;

  @override
  Future<void> loadHtmlString(String html, {String? baseUrl}) async {
    lastLoadedHtmlString = html;
  }

  @override
  Future<void> setJavaScriptMode(JavaScriptMode javaScriptMode) async {
    // No-op
  }
}

void main() {
  late MockWebViewPlatform mockWebViewPlatform;
  late MockWebViewPlatformController mockController;

  setUp(() {
    mockWebViewPlatform = MockWebViewPlatform();
    mockController = MockWebViewPlatformController();

    // ignore: invalid_use_of_protected_member
    WebView.platform = mockWebViewPlatform;
    when(mockWebViewPlatform.buildPlatformSpecificWidget(any))
        .thenReturn(Container()); // Return a dummy widget
    when(mockWebViewPlatform.buildWebViewController(any, any))
        .thenReturn(mockController);
  });

  testWidgets('ChatChartWidget attempts to load an HTML string',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChatChartWidget(
          chartType: 'bar',
          labels: const ['A', 'B'],
          datasets: const [
            {'label': 'Data1', 'data': [10, 20]}
          ],
        ),
      ),
    );

    // The widget's initState calls loadHtmlString
    expect(mockController.lastLoadedHtmlString, isNotNull);
    expect(mockController.lastLoadedHtmlString, contains('<canvas id="myChart"></canvas>'));
  });

  testWidgets('ChatChartWidget generates correct HTML for bar chart',
      (WidgetTester tester) async {
    final labels = ['Jan', 'Feb', 'Mar'];
    final datasets = [
      {
        'label': 'Sales',
        'data': [100, 150, 120],
        'backgroundColor': 'blue',
      }
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: ChatChartWidget(
          chartType: 'bar',
          labels: labels,
          datasets: datasets,
        ),
      ),
    );

    final htmlString = mockController.lastLoadedHtmlString;
    expect(htmlString, isNotNull);
    expect(htmlString, contains("type: 'bar'"));
    expect(htmlString, contains('labels: ${jsonEncode(labels)}'));
    expect(htmlString, contains('datasets: ${jsonEncode(datasets)}'));
  });

  testWidgets('ChatChartWidget generates correct HTML for pie chart',
      (WidgetTester tester) async {
    final labels = ['Red', 'Blue', 'Yellow'];
    final datasets = [
      {
        'label': 'Votes',
        'data': [30, 50, 20],
        'backgroundColor': ['red', 'blue', 'yellow'],
      }
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: ChatChartWidget(
          chartType: 'pie',
          labels: labels,
          datasets: datasets,
        ),
      ),
    );

    final htmlString = mockController.lastLoadedHtmlString;
    expect(htmlString, isNotNull);
    expect(htmlString, contains("type: 'pie'"));
    expect(htmlString, contains('labels: ${jsonEncode(labels)}'));
    expect(htmlString, contains('datasets: ${jsonEncode(datasets)}'));
  });

  testWidgets('ChatChartWidget handles chartData missing "type" gracefully',
      (WidgetTester tester) async {
    // Note: The widget itself doesn't validate the chartType string for Chart.js
    // It just passes it through. So, an "invalid" type from Chart.js's perspective
    // will still be included in the HTML.
    final labels = ['A', 'B'];
    final datasets = [{'label': 'Data', 'data': [1,2]}];
    
    await tester.pumpWidget(
      MaterialApp(
        home: ChatChartWidget(
          chartType: '', // Empty type
          labels: labels,
          datasets: datasets,
        ),
      ),
    );
    final htmlString = mockController.lastLoadedHtmlString;
    expect(htmlString, isNotNull);
    expect(htmlString, contains("type: ''")); // Type is passed as is
    expect(htmlString, contains('labels: ${jsonEncode(labels)}'));
    expect(htmlString, contains('datasets: ${jsonEncode(datasets)}'));
  });


  testWidgets('ChatChartWidget handles chartData with empty labels/datasets',
      (WidgetTester tester) async {
    // Chart.js might error on this, but the widget should render the HTML
    await tester.pumpWidget(
      const MaterialApp(
        home: ChatChartWidget(
          chartType: 'bar',
          labels: [], // Empty labels
          datasets: [], // Empty datasets
        ),
      ),
    );
    final htmlString = mockController.lastLoadedHtmlString;
    expect(htmlString, isNotNull);
    expect(htmlString, contains("type: 'bar'"));
    expect(htmlString, contains('labels: []'));
    expect(htmlString, contains('datasets: []'));
  });
}

// Minimal Mockito 'Mock' class and 'when' function
class Mock {
  final Map<Invocation, Function> _stubbings = {};
  dynamic noSuchMethod(Invocation invocation) {
    if (_stubbings.containsKey(invocation)) {
      return _stubbings[invocation]!();
    }
    return super.noSuchMethod(invocation);
  }
}

T when<T>(T mockCall) {
  // This is a bit of a hack to capture the invocation.
  // In a real Mockito setup, this would be more robust.
  return mockCall;
}

// Helper to capture 'any' argument for when()
class AnyMatcher {
  const AnyMatcher();
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => true;
}
const any = AnyMatcher();
