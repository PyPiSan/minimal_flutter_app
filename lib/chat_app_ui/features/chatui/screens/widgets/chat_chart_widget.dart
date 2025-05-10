import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatChartWidget extends StatefulWidget {
  final String chartType;
  final List<String> labels;
  final List<Map<String, dynamic>> datasets;

  const ChatChartWidget({
    super.key,
    required this.chartType,
    required this.labels,
    required this.datasets,
  });

  @override
  State<ChatChartWidget> createState() => _ChatChartWidgetState();
}

class _ChatChartWidgetState extends State<ChatChartWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(_generateChartHtml());
  }

  String _generateChartHtml() {
    final String datasetsJson = jsonEncode(widget.datasets);
    final String labelsJson = jsonEncode(widget.labels);

    return '''
<!DOCTYPE html>
<html>
<head>
  <title>Chart</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
  <canvas id="myChart"></canvas>
  <script>
    const ctx = document.getElementById('myChart').getContext('2d');
    new Chart(ctx, {
      type: '${widget.chartType}',
      data: {
        labels: $labelsJson,
        datasets: $datasetsJson
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true
          }
        }
      }
    });
  </script>
</body>
</html>
''';
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
