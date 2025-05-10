import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/controllers/chat_controller.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/models/conversation_model.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/widgets/chat_chart_widget.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/widgets/message_list_widget.dart';
import 'package:minimal_flutter_app/chat_app_ui/features/chatui/screens/widgets/typing_loader.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// Mock ChatController
class MockChatController extends GetxController {
  var messages = <CoversationModel>[].obs;
  var isLoading = false.obs;
  // Add other fields/methods from ChatController if they are accessed by buildMessageList
  final ScrollController scrollController = ScrollController(); 
  final FocusNode inputFocusNode = FocusNode(); // Added
  final TextEditingController inputController = TextEditingController(); // Added


  @override
  void onInit() {
    super.onInit();
    // Mock any initialization if needed
  }

  // Mock methods used by the widget or its children if necessary
  void scrollToBottom() {
    // No-op or mock behavior
  }
}

void main() {
  late MockChatController mockChatController;
  late ScrollController scrollController;

  setUpAll(() {
    // This is needed to ensure that Get.put works correctly in tests.
    TestWidgetsFlutterBinding.ensureInitialized(); 
  });

  setUp(() {
    // Reset and re-initialize dependencies for each test
    Get.reset(); // Important to reset GetX bindings between tests
    mockChatController = MockChatController();
    Get.put<ChatController>(mockChatController); // Use ChatController as type
    scrollController = ScrollController();
  });

  tearDown(() {
    scrollController.dispose();
    Get.delete<ChatController>(); // Clean up GetX bindings
  });

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  final barChartData = {
    'type': 'bar',
    'labels': ['Jan', 'Feb', 'Mar'],
    'datasets': [
      {'label': 'Sales', 'data': [100, 150, 120]}
    ]
  };

  testWidgets('Renders ChatChartWidget for valid chart data and MarkdownBody for text',
      (WidgetTester tester) async {
    mockChatController.messages.addAll([
      CoversationModel(text: 'Hello User', sender: Sender.ai),
      CoversationModel(
          text: 'Here is a chart',
          sender: Sender.ai,
          chartData: barChartData),
      CoversationModel(text: 'Hello AI', sender: Sender.user),
    ]);

    await tester.pumpWidget(
        buildTestableWidget(buildMessageList(mockChatController, scrollController)));
    
    // Wait for any potential frame rendering if ChatChartWidget has async parts
    // (though our current mock doesn't require this, it's good practice for WebViews)
    await tester.pumpAndSettle(); 

    expect(find.byType(ChatChartWidget), findsOneWidget);
    expect(find.byType(MarkdownBody), findsNWidgets(2)); // 2 text messages
  });

  testWidgets('Renders MarkdownBody as fallback if chartData is missing "type"',
      (WidgetTester tester) async {
    mockChatController.messages.add(CoversationModel(
        text: 'Chart without type',
        sender: Sender.ai,
        chartData: {
          // 'type': 'bar', // Missing type
          'labels': ['A', 'B'],
          'datasets': [{'data': [1,2]}]
        }));

    await tester.pumpWidget(
        buildTestableWidget(buildMessageList(mockChatController, scrollController)));
    await tester.pumpAndSettle();

    expect(find.byType(ChatChartWidget), findsNothing);
    expect(find.byType(MarkdownBody), findsOneWidget);
  });

  testWidgets('Renders MarkdownBody as fallback if chartData is missing "labels"',
      (WidgetTester tester) async {
    mockChatController.messages.add(CoversationModel(
        text: 'Chart without labels',
        sender: Sender.ai,
        chartData: {
          'type': 'bar',
          // 'labels': ['A', 'B'], // Missing labels
          'datasets': [{'data': [1,2]}]
        }));
    await tester.pumpWidget(
        buildTestableWidget(buildMessageList(mockChatController, scrollController)));
    await tester.pumpAndSettle();

    expect(find.byType(ChatChartWidget), findsNothing);
    expect(find.byType(MarkdownBody), findsOneWidget);
  });

  testWidgets('Renders MarkdownBody as fallback if chartData is missing "datasets"',
      (WidgetTester tester) async {
    mockChatController.messages.add(CoversationModel(
        text: 'Chart without datasets',
        sender: Sender.ai,
        chartData: {
          'type': 'bar',
          'labels': ['A', 'B'],
          // 'datasets': [] // Missing datasets
        }));
    await tester.pumpWidget(
        buildTestableWidget(buildMessageList(mockChatController, scrollController)));
    await tester.pumpAndSettle();

    expect(find.byType(ChatChartWidget), findsNothing);
    expect(find.byType(MarkdownBody), findsOneWidget);
  });

  testWidgets('Renders MarkdownBody if chartData is null',
      (WidgetTester tester) async {
    mockChatController.messages.add(CoversationModel(
        text: 'Message with null chartData',
        sender: Sender.ai,
        chartData: null));
    await tester.pumpWidget(
        buildTestableWidget(buildMessageList(mockChatController, scrollController)));
    await tester.pumpAndSettle();

    expect(find.byType(ChatChartWidget), findsNothing);
    expect(find.byType(MarkdownBody), findsOneWidget);
  });
  
  testWidgets('Renders TypingLoader when isLoading is true', (WidgetTester tester) async {
    mockChatController.isLoading.value = true;
    // Add one message so the index for loader is messages.length
    mockChatController.messages.add(CoversationModel(text: "Hi", sender: Sender.user));

    await tester.pumpWidget(
        buildTestableWidget(buildMessageList(mockChatController, scrollController)));
    // No need for pumpAndSettle if TypingLoader is simple
    
    expect(find.byType(TypingLoader), findsOneWidget);
  });

  testWidgets('Does not render TypingLoader when isLoading is false', (WidgetTester tester) async {
    mockChatController.isLoading.value = false;
    mockChatController.messages.add(CoversationModel(text: "Hi", sender: Sender.user));
    
    await tester.pumpWidget(
        buildTestableWidget(buildMessageList(mockChatController, scrollController)));

    expect(find.byType(TypingLoader), findsNothing);
  });
}
