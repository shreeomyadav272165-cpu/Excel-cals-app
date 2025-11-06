import 'package:flutter/material.dart';
import 'utils/excel_funcs.dart';

void main() {
  runApp(const ExcelCalcApp());
}

class ExcelCalcApp extends StatelessWidget {
  const ExcelCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excel Calculator',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF2E7D32),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final numsCtrl = TextEditingController(text: '10,20,30,40');
  final opCtrl = ValueNotifier<String>('SUM');
  String result = '';

  void _calculate() {
    try {
      final parts = numsCtrl.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty);
      final nums = parts.map((e) => double.parse(e)).toList();
      double? out;
      switch (opCtrl.value) {
        case 'SUM':       out = XL.sum(nums); break;
        case 'AVERAGE':   out = XL.average(nums); break;
        case 'MIN':       out = XL.minVal(nums); break;
        case 'MAX':       out = XL.maxVal(nums); break;
        case 'MEDIAN':    out = XL.median(nums); break;
        case 'STDEV.S':   out = XL.stdevS(nums); break;
        default:          out = null;
      }
      setState(() => result = out?.toString() ?? 'Select an operation');
    } catch (e) {
      setState(() => result = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ops = const ['SUM', 'AVERAGE', 'MIN', 'MAX', 'MEDIAN', 'STDEV.S'];
    return Scaffold(
      appBar: AppBar(title: const Text('Excel Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Numbers (comma separated):'),
            TextField(
              controller: numsCtrl,
              decoration: const InputDecoration(hintText: 'e.g. 10, 20, 35.5'),
            ),
            const SizedBox(height: 12),
            const Text('Operation:'),
            ValueListenableBuilder<String>(
              valueListenable: opCtrl,
              builder: (context, value, _) {
                return DropdownButton<String>(
                  value: value,
                  items: ops.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) { if (v != null) opCtrl.value = v; },
                );
              },
            ),
            const SizedBox(height: 12),
            FilledButton(onPressed: _calculate, child: const Text('Calculate')),
            const SizedBox(height: 16),
            SelectableText('Result: $result', style: const TextStyle(fontSize: 18)),
            const Spacer(),
            const Text('Tip: Add more Excel-like functions via XL.* utilities.'),
          ],
        ),
      ),
    );
  }
}
