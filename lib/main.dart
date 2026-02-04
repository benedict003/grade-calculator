import 'package:flutter/material.dart';

void main() {
  runApp(const GradeCalculatorApp());
}

class GradeCalculatorApp extends StatelessWidget {
  const GradeCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Grade Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        fontFamily: 'Roboto',
      ),
      home: const GradeHomePage(),
    );
  }
}

class GradeHomePage extends StatefulWidget {
  const GradeHomePage({super.key});

  @override
  State<GradeHomePage> createState() => _GradeHomePageState();
}

class _GradeHomePageState extends State<GradeHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mathController = TextEditingController();
  final TextEditingController _scienceController = TextEditingController();
  final TextEditingController _englishController = TextEditingController();

  double _average = 0.0;
  String _grade = '';
  String _status = '';

  void _calculateGrade() {
    double math = double.tryParse(_mathController.text) ?? 0;
    double science = double.tryParse(_scienceController.text) ?? 0;
    double english = double.tryParse(_englishController.text) ?? 0;

    double avg = (math + science + english) / 3;

    String grade;
    String status;

    if (avg >= 90) {
      grade = 'A';
      status = 'Excellent';
    } else if (avg >= 80) {
      grade = 'B';
      status = 'Very Good';
    } else if (avg >= 70) {
      grade = 'C';
      status = 'Good';
    } else if (avg >= 60) {
      grade = 'D';
      status = 'Needs Improvement';
    } else {
      grade = 'F';
      status = 'Failed';
    }

    setState(() {
      _average = avg;
      _grade = grade;
      _status = status;
    });
  }
